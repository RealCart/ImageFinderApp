part of 'favorities_bloc.dart';

class FavoritiesState extends Equatable {
  const FavoritiesState({
    this.favorities = const [],
    this.status = StatusEnum.initial,
  });

  final List<PhotoEntity> favorities;
  final StatusEnum status;

  FavoritiesState copyWith({
    List<PhotoEntity>? favorities,
    StatusEnum? status,
  }) {
    return FavoritiesState(
      favorities: favorities ?? this.favorities,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [favorities, status];
}
