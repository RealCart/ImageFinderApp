part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.status = StatusEnum.loading,
    this.photo,
    this.error,
    this.searchValue = "",
    this.page = 1,
    this.perPage = 10,
    this.loadingMore = StatusEnum.initial,
    this.canLoadMore = true,
  });

  final StatusEnum status;

  final List<PhotoEntity>? photo;
  final Failure? error;

  final String searchValue;

  bool get searchIsEmpty => searchValue.trim().isEmpty;

  final int page;
  final int perPage;

  final StatusEnum loadingMore;

  final bool canLoadMore;

  HomeState copyWith({
    StatusEnum? status,
    String? searchValue,
    List<PhotoEntity>? photo,
    Failure? error,
    int? page,
    int? perPage,
    StatusEnum? loadingMore,
    bool? canLoadMore,
  }) =>
      HomeState(
        status: status ?? this.status,
        searchValue: searchValue ?? this.searchValue,
        photo: photo ?? this.photo,
        error: error ?? this.error,
        page: page ?? this.page,
        perPage: perPage ?? this.perPage,
        loadingMore: loadingMore ?? this.loadingMore,
        canLoadMore: canLoadMore ?? this.canLoadMore,
      );

  @override
  List<Object?> get props => [
        status,
        searchValue,
        photo,
        error,
        page,
        perPage,
        loadingMore,
        canLoadMore,
      ];
}
