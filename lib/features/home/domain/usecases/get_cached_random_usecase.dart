import 'package:image_finder_app/core/domain/usecases/uescase.dart';
import 'package:image_finder_app/core/domain/entities/photo/photo_entity.dart';
import 'package:image_finder_app/features/home/domain/repositories/home_repository.dart';

class GetCachedRandomUsecase implements Usecase<List<PhotoEntity>, NoParams> {
  GetCachedRandomUsecase(this.repository);

  final HomeRepository repository;

  @override
  Future<List<PhotoEntity>> call({NoParams? params}) async {
    return await repository.getChachedPhoto();
  }
}
