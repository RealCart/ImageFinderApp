import 'package:image_finder_app/core/utils/either/either.dart';
import 'package:image_finder_app/core/utils/error/failure.dart';
import 'package:image_finder_app/core/domain/entities/photo/photo_entity.dart';
import 'package:image_finder_app/features/home/domain/entities/search_entity.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, List<PhotoEntity>>> getRandomPhoto();
  Future<Either<Failure, List<PhotoEntity>>> serchPhoto(SearchEntity params);

  Future<List<PhotoEntity>> getChachedPhoto();
  Future<void> chachedRandomPohto(List<PhotoEntity> list);
}
