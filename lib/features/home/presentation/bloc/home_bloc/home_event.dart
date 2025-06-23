part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class GetRandomPhotosEvent extends HomeEvent {
  const GetRandomPhotosEvent({this.completer});

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}

final class SearchPhotoEvent extends HomeEvent {
  const SearchPhotoEvent({
    required this.value,
    this.completer,
  });

  final String value;
  final Completer? completer;

  @override
  List<Object?> get props => [value, completer];
}

final class PullToRefreshEvent extends HomeEvent {
  const PullToRefreshEvent({required this.completer});

  final Completer completer;

  @override
  List<Object?> get props => [completer];
}

final class GetMorePhotoEvent extends HomeEvent {}
