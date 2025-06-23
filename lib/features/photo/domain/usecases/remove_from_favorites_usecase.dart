import 'package:image_finder_app/core/domain/usecases/uescase.dart';
import 'package:image_finder_app/core/utils/either/either.dart';
import 'package:image_finder_app/core/utils/error/failure.dart';
import 'package:image_finder_app/features/photo/domain/repositories/photo_repository.dart';

class RemoveFromFavoritesUseCase
    implements Usecase<Either<Failure, void>, String> {
  const RemoveFromFavoritesUseCase(this._repository);

  final PhotoRepository _repository;

  @override
  Future<Either<Failure, void>> call({required String params}) async {
    return await _repository.removeFromFavorites(params);
  }
}
