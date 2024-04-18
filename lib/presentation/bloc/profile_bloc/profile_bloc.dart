import 'package:dartz/dartz.dart';
import 'package:pantest/lib.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final SocialMediaUsecase userUsecase;

  ProfileBloc(this.userUsecase) : super(ProfileState.initial()) {
    on<OnGetProfile>((event, emit) async {
      emit(
        const ProfileState(
          requestState: RequestState.loading,
          profileResponseModel: null,
        ),
      );

      var result = await userUsecase.getProfileUsecase(event.idUser);

      result.fold((left) {
        emit(
          const ProfileState(
            requestState: RequestState.error,
            profileResponseModel: null,
          ),
        );
      }, (right) {
        emit(ProfileState(
          requestState: RequestState.loaded,
          profileResponseModel: right,
        ));
      });
    });
  }
}
