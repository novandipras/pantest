part of 'explore_bloc.dart';

abstract class ExploreEvent extends Equatable {
  const ExploreEvent();
}

class OnInitPostingOnExploreEvent extends ExploreEvent {
  const OnInitPostingOnExploreEvent();

  @override
  List<Object?> get props => [];
}

class OnInitPostingOnTagExploreEvent extends ExploreEvent {
  const OnInitPostingOnTagExploreEvent({required this.tag});

  final String tag;

  @override
  List<Object?> get props => [
        tag,
      ];
}

class OnNextPagePostingOnExploreEvent extends ExploreEvent {
  const OnNextPagePostingOnExploreEvent({
    required this.context,
  });

  final BuildContext context;

  @override
  List<Object?> get props => [
        context,
      ];
}


class OnNextPagePostingOnTagExploreEvent extends ExploreEvent {
  const OnNextPagePostingOnTagExploreEvent({
    required this.context,
    required this.tag,
  });

  final BuildContext context;
  final String tag;

  @override
  List<Object?> get props => [
    context,
    tag,
  ];
}
