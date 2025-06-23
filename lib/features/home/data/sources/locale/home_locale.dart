import 'dart:convert';

import 'package:image_finder_app/core/constants/constant_variables.dart';
import 'package:image_finder_app/core/data/sources/locale/sqflite_client.dart';
import 'package:image_finder_app/features/home/data/models/photo_model.dart';

abstract interface class HomeLocale {
  Future<List<PhotoModel>> getCachedRandomPhoto();
  Future<void> chachedRandomPhoto(List<PhotoModel> list);
}

class HomeLocaleImpl implements HomeLocale {
  const HomeLocaleImpl(this._sqfliteClient);

  final SqfliteClient _sqfliteClient;

  @override
  Future<List<PhotoModel>> getCachedRandomPhoto() async {
    final rows = await _sqfliteClient.query(cachedRandomTable);

    return rows
        .map((e) => PhotoModel.fromJson(
              jsonDecode(e['value'] as String) as Map<String, dynamic>,
            ))
        .toList();
  }

  @override
  Future<void> chachedRandomPhoto(List<PhotoModel> list) async {
    await _sqfliteClient.transaction((action) async {
      await action.delete(cachedRandomTable);

      final batch = action.batch();
      for (final photo in list) {
        batch.insert(cachedRandomTable, {'value': jsonEncode(photo.toJson())});
      }

      await batch.commit(noResult: true);
    });
  }
}
