import 'package:dio/dio.dart';
import 'package:image_finder_app/core/utils/either/either.dart';
import 'package:image_finder_app/core/utils/error/failure.dart';
import 'package:image_finder_app/features/home/data/models/photo_model.dart';
import 'package:image_finder_app/features/home/data/sources/locale/home_locale.dart';
import 'package:image_finder_app/features/home/data/sources/remote/home_remote.dart';
import 'package:image_finder_app/core/domain/entities/photo/photo_entity.dart';
import 'package:image_finder_app/features/home/domain/entities/search_entity.dart';
import 'package:image_finder_app/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl({
    required this.remote,
    required this.locale,
  });

  final HomeRemote remote;
  final HomeLocale locale;

  @override
  Future<Either<Failure, List<PhotoEntity>>> getRandomPhoto() async {
    try {
      final response = await remote.getRandomPhotos();

      final responseData = response.map((e) => e.toEntity()).toList();

      return Either.right(responseData);
    } on DioException catch (e) {
      return Either.left(e.error as Failure);
    }
  }

  @override
  Future<Either<Failure, List<PhotoEntity>>> serchPhoto(
      SearchEntity params) async {
    try {
      final response = await remote.searchPhoto(params: params);

      final responseData = response.map((e) => e.toEntity()).toList();

      return Either.right(responseData);
    } on DioException catch (e) {
      return Either.left(e.error as Failure);
    }
  }

  @override
  Future<List<PhotoEntity>> getChachedPhoto() async {
    try {
      final response = await locale.getCachedRandomPhoto();

      final responseData = response.map((e) => e.toEntity()).toList();
      return responseData;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> chachedRandomPohto(List<PhotoEntity> list) async {
    final listData = list.map((e) => PhotoModel.fromEntity(e)).toList();

    await locale.chachedRandomPhoto(listData);
  }
}
