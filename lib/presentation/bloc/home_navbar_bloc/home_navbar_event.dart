part of 'home_navbar_bloc.dart';

@immutable
abstract class HomeNavbarEvent {
  const HomeNavbarEvent();
}

class ChangeHomeScreen extends HomeNavbarEvent {
  const ChangeHomeScreen({required this.page});

  final int page;
}
