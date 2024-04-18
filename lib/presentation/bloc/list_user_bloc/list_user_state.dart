part of 'list_user_bloc.dart';

class ListUserState extends Equatable {
  const ListUserState({
    this.listDataUser,
    this.userResponseModel,
    this.requestState,
    this.filter,
    this.totalPage,
  });

  final  List<DataUser>? listDataUser;
  final UserResponseModel? userResponseModel;
  final RequestState? requestState;
  final Map<String, dynamic>? filter;
  final int? totalPage;

  factory ListUserState.initial() {
    return const ListUserState(
      listDataUser: [],
      userResponseModel: null,
      requestState: RequestState.empty,
      totalPage: null,
      filter: null,
    );
  }

  ListUserState copyWith({
    List<DataUser>? listDataUser,
    UserResponseModel? userResponseModel,
    RequestState? requestState,
    Map<String, dynamic>? filter,
    int? totalPage,
  }) {
    return ListUserState(
      requestState: requestState ?? this.requestState,
      listDataUser: listDataUser ?? this.listDataUser,
      userResponseModel: userResponseModel ?? this.userResponseModel,
      filter: filter ?? this.filter,
      totalPage: totalPage ?? this.totalPage,
    );
  }

  @override
  List<Object?> get props => [
    listDataUser,
    requestState,
    userResponseModel,
    filter,
    totalPage,
  ];
}
