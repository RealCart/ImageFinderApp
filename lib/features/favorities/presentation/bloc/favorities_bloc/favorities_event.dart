part of 'favorities_bloc.dart';

sealed class FavoritiesEvent extends Equatable {
  const FavoritiesEvent();

  @override
  List<Object> get props => [];
}

final class GetFavoritiesEvent extends FavoritiesEvent {
  const GetFavoritiesEvent({this.completer});

  final Completer<void>? completer;
}