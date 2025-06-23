import 'package:image_finder_app/core/domain/usecases/uescase.dart';
import 'package:image_finder_app/core/domain/entities/photo/photo_entity.dart';
import 'package:image_finder_app/features/home/domain/repositories/home_repository.dart';

class CachedRandomPhotoUsecase implements Usecase<void, List<PhotoEntity>> {
  CachedRandomPhotoUsecase(this.repository);

  final HomeRepository repository;

  @override
  Future<void> call({required List<PhotoEntity> params}) async {
    await repository.chachedRandomPohto(params);
  }
}
