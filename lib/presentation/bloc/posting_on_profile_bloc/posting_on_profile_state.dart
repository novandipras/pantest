part of 'posting_on_profile_bloc.dart';

class PostingOnProfileState extends Equatable {
  const PostingOnProfileState({
    this.listData,
    this.dataResponse,
    this.requestState,
    this.filter,
    this.totalPage,
  });

  final List<DataPostProfile>? listData;
  final PostProfileResponseModel? dataResponse;
  final RequestState? requestState;
  final Map<String, dynamic>? filter;
  final int? totalPage;

  factory PostingOnProfileState.initial() {
    return const PostingOnProfileState(
      listData: [],
      dataResponse: null,
      requestState: RequestState.empty,
      totalPage: null,
      filter: null,
    );
  }

  PostingOnProfileState copyWith({
    List<DataPostProfile>? listData,
    PostProfileResponseModel? dataResponse,
    RequestState? requestState,
    Map<String, dynamic>? filter,
    int? totalPage,
  }) {
    return PostingOnProfileState(
      requestState: requestState ?? this.requestState,
      listData: listData ?? this.listData,
      dataResponse: dataResponse ?? this.dataResponse,
      filter: filter ?? this.filter,
      totalPage: totalPage ?? this.totalPage,
    );
  }

  @override
  List<Object?> get props => [
    listData,
    requestState,
    dataResponse,
    filter,
    totalPage,
  ];
}
