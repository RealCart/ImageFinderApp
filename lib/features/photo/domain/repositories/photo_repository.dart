import 'package:image_finder_app/core/domain/entities/photo/photo_entity.dart';
import 'package:image_finder_app/core/utils/either/either.dart';
import 'package:image_finder_app/core/utils/error/failure.dart';

abstract interface class PhotoRepository {
  Future<Either<Failure, void>> addToFavorites(PhotoEntity photo);
  Future<Either<Failure, void>> removeFromFavorites(String id);
  Future<Either<Failure, bool>> isFavorite(String id);
  Future<Either<Failure, String>> downloadPhoto(PhotoEntity photo);
}
