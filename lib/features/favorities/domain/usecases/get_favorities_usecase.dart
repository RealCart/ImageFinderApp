import 'package:image_finder_app/core/domain/entities/photo/photo_entity.dart';
import 'package:image_finder_app/core/domain/usecases/uescase.dart';
import 'package:image_finder_app/features/favorities/domain/repositories/favorities_repository.dart';

class GetFavoritiesUsecase implements Usecase<List<PhotoEntity>, void> {
  const GetFavoritiesUsecase(this.repository);

  final FavoritiesRepository repository;
  
  @override
  Future<List<PhotoEntity>> call({required void params}) async {
    return await repository.getFavorites();
  }
}