import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_finder_app/core/domain/entities/photo/photo_entity.dart';
import 'package:image_finder_app/core/utils/status_enum/status_enum.dart';
import 'package:image_finder_app/features/photo/domain/usecases/add_to_favorites_usecase.dart';
import 'package:image_finder_app/features/photo/domain/usecases/download_photo_usecase.dart';
import 'package:image_finder_app/features/photo/domain/usecases/is_favorite_usecase.dart';
import 'package:image_finder_app/features/photo/domain/usecases/remove_from_favorites_usecase.dart';

part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  PhotoBloc({
    required this.isFavoriteUseCase,
    required this.addToFavoritesUseCase,
    required this.removeFromFavoritesUseCase,
    required this.downloadPhotoUseCase,
  }) : super(const PhotoState()) {
    on<CheckFavoriteStatusEvent>(_onCheckFavoriteStatus);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<DownloadPhotoEvent>(_onDownloadPhoto);
  }

  final IsFavoriteUseCase isFavoriteUseCase;
  final AddToFavoritesUseCase addToFavoritesUseCase;
  final RemoveFromFavoritesUseCase removeFromFavoritesUseCase;
  final DownloadPhotoUseCase downloadPhotoUseCase;

  _onCheckFavoriteStatus(
      CheckFavoriteStatusEvent event, Emitter<PhotoState> emit) async {
    emit(state.copyWith(status: StatusEnum.loading));

    final result = await isFavoriteUseCase(params: event.id);

    result.fold(
      (l) => emit(state.copyWith(status: StatusEnum.error)),
      (r) => emit(state.copyWith(
        status: StatusEnum.successfulll,
        isLiked: r,
      )),
    );
  }

  _onToggleFavorite(ToggleFavoriteEvent event, Emitter<PhotoState> emit) async {
    emit(state.copyWith(status: StatusEnum.loading));

    if (state.isLiked) {
      final result = await removeFromFavoritesUseCase(params: event.photo.id);

      result.fold(
        (l) => emit(state.copyWith(status: StatusEnum.error)),
        (r) => emit(state.copyWith(
          status: StatusEnum.successfulll,
          isLiked: false,
        )),
      );
    } else {
      final result = await addToFavoritesUseCase(params: event.photo);

      result.fold(
        (l) => emit(state.copyWith(status: StatusEnum.error)),
        (_) => emit(state.copyWith(
          status: StatusEnum.successfulll,
          isLiked: true,
        )),
      );
    }

    log("${state.isLiked}");
  }

  _onDownloadPhoto(DownloadPhotoEvent event, Emitter<PhotoState> emit) async {
    if (state.isDownloading) return;

    emit(state.copyWith(
      isDownloading: true,
      downloadProgress: 0.0,
    ));

    final result = await downloadPhotoUseCase(params: event.photo);

    result.fold(
      (l) {
        emit(state.copyWith(
          isDownloading: false,
          downloadProgress: 0.0,
          downloadStatus: StatusEnum.error,
        ));
        log('Download failed: ${l.errorMessage}');
      },
      (r) {
        emit(state.copyWith(
          isDownloading: false,
          downloadProgress: 100.0,
          downloadStatus: StatusEnum.successfulll,
        ));
        log('Download completed: $r');
      },
    );

    emit(state.copyWith(downloadStatus: StatusEnum.initial));
  }
}
