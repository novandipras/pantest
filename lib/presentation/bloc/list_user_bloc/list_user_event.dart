part of 'list_user_bloc.dart';

abstract class ListUserEvent extends Equatable {
  const ListUserEvent();
}

class OnInitListUserEvent extends ListUserEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class OnNextPageListUserEvent extends ListUserEvent {
  const OnNextPageListUserEvent({
    required this.context,
  });

  final BuildContext context;

  @override
  List<Object?> get props => [
        context,
      ];
}
