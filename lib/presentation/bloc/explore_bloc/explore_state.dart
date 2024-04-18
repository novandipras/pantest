part of 'explore_bloc.dart';

class ExploreState extends Equatable {
  const ExploreState({
    this.listData,
    this.dataResponse,
    this.requestState,
    this.filter,
    this.totalPage,
  });

  final List<DataExplore>? listData;
  final ExploreResponseModel? dataResponse;
  final RequestState? requestState;
  final Map<String, dynamic>? filter;
  final int? totalPage;

  factory ExploreState.initial() {
    return const ExploreState(
      listData: [],
      dataResponse: null,
      requestState: RequestState.empty,
      totalPage: null,
      filter: null,
    );
  }

  ExploreState copyWith({
    List<DataExplore>? listData,
    ExploreResponseModel? dataResponse,
    RequestState? requestState,
    Map<String, dynamic>? filter,
    int? totalPage,
  }) {
    return ExploreState(
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
