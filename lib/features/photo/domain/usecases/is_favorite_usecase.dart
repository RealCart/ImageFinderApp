import 'package:image_finder_app/core/domain/usecases/uescase.dart';
import 'package:image_finder_app/core/utils/either/either.dart';
import 'package:image_finder_app/core/utils/error/failure.dart';
import 'package:image_finder_app/features/photo/domain/repositories/photo_repository.dart';

class IsFavoriteUseCase implements Usecase<Either<Failure, bool>, String> {
  const IsFavoriteUseCase(this._repository);

  final PhotoRepository _repository;

  @override
  Future<Either<Failure, bool>> call({required String params}) async {
    return await _repository.isFavorite(params);
  }
}
