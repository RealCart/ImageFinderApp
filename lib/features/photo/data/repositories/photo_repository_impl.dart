import 'package:image_finder_app/core/domain/entities/photo/photo_entity.dart';
import 'package:image_finder_app/core/utils/either/either.dart';
import 'package:image_finder_app/core/utils/error/failure.dart';
import 'package:image_finder_app/features/home/data/models/photo_model.dart';
import 'package:image_finder_app/features/photo/data/sources/locale/photo_locale.dart';
import 'package:image_finder_app/features/photo/domain/repositories/photo_repository.dart';
import 'package:image_finder_app/core/data/sources/remote/download_service.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  PhotoRepositoryImpl({
    required this.locale,
  });

  final PhotoLocale locale;
  final DownloadService _downloadService = DownloadService();

  @override
  Future<Either<Failure, void>> addToFavorites(PhotoEntity photo) async {
    try {
      final photoModel = PhotoModel.fromEntity(photo);
      await locale.addToFavorites(photoModel);
      return Either.right(null);
    } catch (e) {
      return Either.left(UnexpectedFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromFavorites(String id) async {
    try {
      await locale.removeFromFavorites(id);
      return Either.right(null);
    } catch (e) {
      return Either.left(UnexpectedFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(String id) async {
    try {
      final result = await locale.isFavorite(id);
      return Either.right(result);
    } catch (e) {
      return Either.left(UnexpectedFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> downloadPhoto(PhotoEntity photo) async {
    try {
      final fileName = 'photo_${photo.id}';
      final filePath =
          await _downloadService.downloadImage(photo.pathUrl, fileName);

      if (filePath != null) {
        return Either.right(filePath);
      } else {
        return Either.left(UnexpectedFailure(errorMessage: 'Download failed'));
      }
    } catch (e) {
      return Either.left(UnexpectedFailure(errorMessage: e.toString()));
    }
  }
}
