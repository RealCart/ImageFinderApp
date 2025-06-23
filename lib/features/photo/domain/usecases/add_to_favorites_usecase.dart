import 'package:image_finder_app/core/domain/entities/photo/photo_entity.dart';
import 'package:image_finder_app/core/domain/usecases/uescase.dart';
import 'package:image_finder_app/core/utils/either/either.dart';
import 'package:image_finder_app/core/utils/error/failure.dart';
import 'package:image_finder_app/features/photo/domain/repositories/photo_repository.dart';

class AddToFavoritesUseCase
    implements Usecase<Either<Failure, void>, PhotoEntity> {
  const AddToFavoritesUseCase(this._repository);

  final PhotoRepository _repository;

  @override
  Future<Either<Failure, void>> call({required PhotoEntity params}) async {
    return await _repository.addToFavorites(params);
  }
}
