import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:pantest/lib.dart';
import 'package:rxdart/rxdart.dart';

part 'posting_on_profile_event.dart';

part 'posting_on_profile_state.dart';

class PostingOnProfileBloc
    extends Bloc<PostingOnProfileEvent, PostingOnProfileState> {
  final SocialMediaUsecase userUsecase;

  int limit = 20;


  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  PostingOnProfileBloc(this.userUsecase)
      : super(PostingOnProfileState.initial()) {
    on<OnInitPostingOnProfileEvent>((event, emit) async {
      emit(
        PostingOnProfileState(
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

      Either<Failure, PostProfileResponseModel> result =
          await userUsecase.getListPostProfileUsecase(
        payload: payload,
        id: event.id,
      );

      result.fold((left) {
        emit(
          PostingOnProfileState(
            requestState: RequestState.error,
            listData: const [],
            dataResponse: null,
            filter: state.filter,
            totalPage: state.totalPage,
          ),
        );
      }, (right) {
        emit(
          PostingOnProfileState(
            requestState: RequestState.loaded,
            dataResponse: right,
            listData: right.data,
            filter: state.filter,
            totalPage: (right.total! / right.limit!).ceil(),
          ),
        );
      });
    });

    on<OnNextPagePostingOnProfileEvent>(
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

          Either<Failure, PostProfileResponseModel> result =
          await userUsecase.getListPostProfileUsecase(
            payload: payload,
            id: event.id,
          );

          result.fold((left) {
            CustomToast.showError('Gagal Load Data', context: event.context);
            emit(
              state.copyWith(requestState: RequestState.error),
            );
          }, (right) {
            List<DataPostProfile>? tempList = [
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
