part of 'photo_bloc.dart';

class PhotoState extends Equatable {
  const PhotoState({
    this.status = StatusEnum.initial,
    this.photo,
    this.isLiked = false,
    this.isDownloading = false,
    this.downloadProgress = 0.0,
    this.downloadStatus = StatusEnum.initial,
  });

  final StatusEnum status;

  final StatusEnum downloadStatus;

  final PhotoEntity? photo;
  final bool isLiked;
  final bool isDownloading;
  final double downloadProgress;

  PhotoState copyWith({
    StatusEnum? status,
    PhotoEntity? photo,
    bool? isLiked,
    bool? isDownloading,
    double? downloadProgress,
    StatusEnum? downloadStatus,
  }) =>
      PhotoState(
        status: status ?? this.status,
        downloadStatus: downloadStatus ?? this.downloadStatus,
        photo: photo ?? this.photo,
        isLiked: isLiked ?? this.isLiked,
        isDownloading: isDownloading ?? this.isDownloading,
        downloadProgress: downloadProgress ?? this.downloadProgress,
      );

  @override
  List<Object?> get props => [
        status,
        photo,
        isLiked,
        isDownloading,
        downloadProgress,
        downloadStatus,
      ];
}
