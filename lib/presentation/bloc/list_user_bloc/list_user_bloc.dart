import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:pantest/lib.dart';
import 'package:rxdart/rxdart.dart';

part 'list_user_event.dart';

part 'list_user_state.dart';

class ListUserBloc extends Bloc<ListUserEvent, ListUserState> {
  final SocialMediaUsecase userUsecase;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  int limit = 20;

  ListUserBloc(this.userUsecase) : super(ListUserState.initial()) {
    on<OnInitListUserEvent>((event, emit) async {
      emit(
        ListUserState(
          requestState: RequestState.loading,
          listDataUser: const [],
          userResponseModel: null,
          filter: state.filter,
          totalPage: state.totalPage,
        ),
      );

      Map<String, dynamic> payload = {
        "limit": limit,
        "page": 0,
      };

      if (state.filter != null) {
        payload.addAll(state.filter!);
      }

      Either<Failure, UserResponseModel> result =
          await userUsecase.getListUserUsecase(
        payload: payload,
      );

      result.fold((left) {
        emit(
          ListUserState(
            requestState: RequestState.error,
            listDataUser: const [],
            userResponseModel: null,
            filter: state.filter,
            totalPage: state.totalPage,
          ),
        );
      }, (right) {
        emit(
          ListUserState(
            requestState: RequestState.loaded,
            userResponseModel: right,
            listDataUser: right.data,
            filter: state.filter,
            totalPage: right.total,
          ),
        );
      });
    });

    on<OnNextPageListUserEvent>(
      (event, emit) async {
        if ((state.requestState != RequestState.loading) &&
            (state.totalPage! > state.userResponseModel!.page!)) {
          emit(state.copyWith(requestState: RequestState.loading));

          Map<String, dynamic> payload = {
            "limit": limit,
            "page": state.userResponseModel!.page! + 1,
          };

          if (state.filter != null) {
            payload.addAll(state.filter!);
          }

          Either<Failure, UserResponseModel> result =
              await userUsecase.getListUserUsecase(
            payload: payload,
          );

          result.fold((left) {
            CustomToast.showError('Gagal Load Data', context: event.context);
            emit(
              state.copyWith(requestState: RequestState.error),
            );
          }, (right) {
            List<DataUser>? tempList = [
              ...?state.listDataUser,
              ...?right.data,
            ];

            emit(state.copyWith(
              requestState: RequestState.loaded,
              userResponseModel: right,
              listDataUser: tempList,
              totalPage: right.total,
            ));
          });
        }
      },
      transformer: debounce(
        const Duration(milliseconds: 1500),
      ),
    );
  }
}
