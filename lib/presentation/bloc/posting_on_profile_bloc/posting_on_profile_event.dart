part of 'posting_on_profile_bloc.dart';

abstract class PostingOnProfileEvent extends Equatable {
  const PostingOnProfileEvent();
}

class OnInitPostingOnProfileEvent extends PostingOnProfileEvent {
  const OnInitPostingOnProfileEvent({required this.id});

  final String id;

  @override
  List<Object?> get props => [
        id,
      ];
}

class OnNextPagePostingOnProfileEvent extends PostingOnProfileEvent {
  const OnNextPagePostingOnProfileEvent({
    required this.context,
    required this.id,
  });

  final BuildContext context;
  final String id;

  @override
  List<Object?> get props => [
        context,
        id,
      ];
}
