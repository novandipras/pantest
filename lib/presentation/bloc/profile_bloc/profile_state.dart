part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.profileResponseModel,
    this.requestState,
  });

  final ProfileResponseModel? profileResponseModel;
  final RequestState? requestState;

  factory ProfileState.initial() {
    return const ProfileState(
      profileResponseModel: null,
      requestState: RequestState.empty,
    );
  }

  @override
  List<Object?> get props => [
        profileResponseModel,
        requestState,
      ];
}
