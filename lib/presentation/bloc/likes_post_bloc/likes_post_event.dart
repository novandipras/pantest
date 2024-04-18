part of 'likes_post_bloc.dart';

abstract class LikesPostEvent extends Equatable {
  const LikesPostEvent();
}

class OnInitLikesPostEvent extends LikesPostEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}