part of 'photo_bloc.dart';

sealed class PhotoEvent extends Equatable {
  const PhotoEvent();

  @override
  List<Object> get props => [];
}

final class GetPhotoByIdEvent extends PhotoEvent {
  const GetPhotoByIdEvent({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}

final class CheckFavoriteStatusEvent extends PhotoEvent {
  const CheckFavoriteStatusEvent({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}

final class ToggleFavoriteEvent extends PhotoEvent {
  const ToggleFavoriteEvent({required this.photo});

  final PhotoEntity photo;

  @override
  List<Object> get props => [photo];
}

final class DownloadPhotoEvent extends PhotoEvent {
  const DownloadPhotoEvent({required this.photo});

  final PhotoEntity photo;

  @override
  List<Object> get props => [photo];
}
