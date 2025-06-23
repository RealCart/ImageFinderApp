import 'package:image_finder_app/core/domain/entities/photo/photo_entity.dart';

abstract interface class FavoritiesRepository {
  Future<List<PhotoEntity>> getFavorites();
}