part of 'likes_post_bloc.dart';

class LikesPostState extends Equatable {
  const LikesPostState({
    this.listData,
    this.filter,
  });

  final List<DataSavedPostModel>? listData;
  final Map<String, dynamic>? filter;

  factory LikesPostState.initial() {
    return const LikesPostState(
      listData: [],
      filter: null,
    );
  }

  LikesPostState copyWith({
    List<DataSavedPostModel>? listData,
    Map<String, dynamic>? filter,
  }) {
    return LikesPostState(
      listData: listData ?? this.listData,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [
    listData,
    filter,
  ];
}
