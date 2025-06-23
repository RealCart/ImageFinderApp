import 'package:image_finder_app/core/domain/usecases/uescase.dart';
import 'package:image_finder_app/core/utils/either/either.dart';
import 'package:image_finder_app/core/utils/error/failure.dart';
import 'package:image_finder_app/core/domain/entities/photo/photo_entity.dart';
import 'package:image_finder_app/features/home/domain/repositories/home_repository.dart';

class GetRandomPhotoUsecase
    implements Usecase<Either<Failure, List<PhotoEntity>>, NoParams> {
  const GetRandomPhotoUsecase(this.repository);

  final HomeRepository repository;

  @override
  Future<Either<Failure, List<PhotoEntity>>> call({
    NoParams? params,
  }) async {
    return await repository.getRandomPhoto();
  }
}
