import 'package:image_finder_app/core/constants/api_ursl.dart';
import 'package:image_finder_app/core/data/sources/remote/dio_client.dart';
import 'package:image_finder_app/features/home/data/models/photo_model.dart';
import 'package:image_finder_app/features/home/domain/entities/search_entity.dart';

abstract interface class HomeRemote {
  Future<List<PhotoModel>> getRandomPhotos();
  Future<List<PhotoModel>> searchPhoto({required SearchEntity params});
}

class HomeRemoteImpl implements HomeRemote {
  const HomeRemoteImpl(this.dioClient);

  final DioClient dioClient;

  @override
  Future<List<PhotoModel>> getRandomPhotos() async {
    final response = await dioClient.get(
      ApiUrsl.randomPhoto,
      queryParameters: {
        "count": 8,
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return (response.data as List)
          .map((e) => PhotoModel.fromJson(e))
          .toList();
    }

    throw Exception();
  }

  @override
  Future<List<PhotoModel>> searchPhoto({required SearchEntity params}) async {
    final response = await dioClient.get(
      ApiUrsl.searchPhoto,
      queryParameters: {
        "query": params.value,
        "page": params.page,
        "per_page": params.perPage,
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return (response.data["results"] as List)
          .map((e) => PhotoModel.fromJson(e))
          .toList();
    }

    throw Exception(response.statusMessage);
  }
}
