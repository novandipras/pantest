import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:pantest/lib.dart';
import 'package:rxdart/rxdart.dart';

part 'explore_event.dart';

part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final SocialMediaUsecase userUsecase;

  int limit = 20;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  ExploreBloc(this.userUsecase) : super(ExploreState.initial()) {
    on<OnInitPostingOnExploreEvent>((event, emit) async {
      emit(
        ExploreState(
          requestState: RequestState.loading,
          listData: const [],
          dataResponse: null,
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

      Either<Failure, ExploreResponseModel> result =
          await userUsecase.getListPostExploreUsecase(
        payload: payload,
      );

      result.fold((left) {
        emit(
          ExploreState(
            requestState: RequestState.error,
            listData: const [],
            dataResponse: null,
            filter: state.filter,
            totalPage: state.totalPage,
          ),
        );
      }, (right) {
        emit(
          ExploreState(
            requestState: RequestState.loaded,
            dataResponse: right,
            listData: right.data,
            filter: state.filter,
            totalPage: (right.total! / right.limit!).ceil(),
          ),
        );
      });
    });

    on<OnInitPostingOnTagExploreEvent>((event, emit) async {
      emit(
        ExploreState(
          requestState: RequestState.loading,
          listData: const [],
          dataResponse: null,
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

      Either<Failure, ExploreResponseModel> result =
      await userUsecase.getListPostExploreUsecase(
        payload: payload,
        tag: event.tag,
      );

      result.fold((left) {
        emit(
          ExploreState(
            requestState: RequestState.error,
            listData: const [],
            dataResponse: null,
            filter: state.filter,
            totalPage: state.totalPage,
          ),
        );
      }, (right) {
        emit(
          ExploreState(
            requestState: RequestState.loaded,
            dataResponse: right,
            listData: right.data,
            filter: state.filter,
            totalPage: (right.total! / right.limit!).ceil(),
          ),
        );
      });
    });

    on<OnNextPagePostingOnExploreEvent>(
          (event, emit) async {
        if ((state.requestState != RequestState.loading) &&
            ((state.totalPage! - 1) > state.dataResponse!.page!)) {
          emit(state.copyWith(requestState: RequestState.loading));

          Map<String, dynamic> payload = {
            "limit": limit,
            "page": state.dataResponse!.page! + 1,
          };

          if (state.filter != null) {
            payload.addAll(state.filter!);
          }

          Either<Failure, ExploreResponseModel> result =
          await userUsecase.getListPostExploreUsecase(
            payload: payload,
          );

          result.fold((left) {
            CustomToast.showError('Gagal Load Data', context: event.context);
            emit(
              state.copyWith(requestState: RequestState.error),
            );
          }, (right) {
            List<DataExplore>? tempList = [
              ...?state.listData,
              ...?right.data,
            ];

            emit(state.copyWith(
              requestState: RequestState.loaded,
              dataResponse: right,
              listData: tempList,
              totalPage: (right.total! / right.limit!).ceil(),
            ));
          });
        }
      },
      transformer: debounce(
        const Duration(milliseconds: 1500),
      ),
    );

    on<OnNextPagePostingOnTagExploreEvent>(
          (event, emit) async {
        if ((state.requestState != RequestState.loading) &&
            ((state.totalPage! - 1) > state.dataResponse!.page!)) {
          emit(state.copyWith(requestState: RequestState.loading));

          Map<String, dynamic> payload = {
            "limit": limit,
            "page": state.dataResponse!.page! + 1,
          };

          if (state.filter != null) {
            payload.addAll(state.filter!);
          }

          Either<Failure, ExploreResponseModel> result =
          await userUsecase.getListPostExploreUsecase(
            payload: payload,
            tag: event.tag,
          );

          result.fold((left) {
            CustomToast.showError('Gagal Load Data', context: event.context);
            emit(
              state.copyWith(requestState: RequestState.error),
            );
          }, (right) {
            List<DataExplore>? tempList = [
              ...?state.listData,
              ...?right.data,
            ];

            emit(state.copyWith(
              requestState: RequestState.loaded,
              dataResponse: right,
              listData: tempList,
              totalPage: (right.total! / right.limit!).ceil(),
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
