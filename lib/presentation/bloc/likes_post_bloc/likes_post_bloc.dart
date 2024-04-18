import 'package:flutter/foundation.dart';
import 'package:pantest/lib.dart';

part 'likes_post_event.dart';

part 'likes_post_state.dart';

class LikesPostBloc extends Bloc<LikesPostEvent, LikesPostState> {
  final SqfliteService sqfliteService;

  LikesPostBloc(this.sqfliteService) : super(LikesPostState.initial()) {
    on<OnInitLikesPostEvent>((event, emit) async {
      try {
        List<DataSavedPostModel> result = await sqfliteService.getItems();

        emit(LikesPostState(filter: state.filter, listData: result));
      } on Exception catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    });
  }
}
