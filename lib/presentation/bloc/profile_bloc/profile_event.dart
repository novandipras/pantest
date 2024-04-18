part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class OnGetProfile extends ProfileEvent {
  const OnGetProfile({required this.idUser});

  final String idUser;

  @override
  List<Object?> get props => [
        idUser,
      ];
}
