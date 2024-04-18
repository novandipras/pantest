import 'package:flutter/material.dart';
import 'package:pantest/lib.dart';

part 'home_navbar_event.dart';

class HomeNavbarBloc extends Bloc<HomeNavbarEvent, int> {
  HomeNavbarBloc() : super(0) {
    on<ChangeHomeScreen>((event, emit) {
      emit(event.page);
    });
  }
}
