import 'package:image_finder_app/core/data/sources/locale/favorites_locale.dart';
import 'package:image_finder_app/core/domain/entities/photo/photo_entity.dart';
import 'package:image_finder_app/features/favorities/domain/repositories/favorities_repository.dart';

class FavoritiesRepositoryImpl implements FavoritiesRepository {
  const FavoritiesRepositoryImpl({
    required this.locale,
  });

  final FavoritesLocale locale;
  
  @override
  Future<List<PhotoEntity>> getFavorites() async {
    final list = await locale.getFavorites();
    return list.map((e) => e.toEntity()).toList();
  }
}