import 'dart:convert';

import 'package:image_finder_app/core/constants/constant_variables.dart';
import 'package:image_finder_app/core/data/sources/locale/sqflite_client.dart';
import 'package:image_finder_app/features/home/data/models/photo_model.dart';

abstract interface class PhotoLocale {
  Future<void> addToFavorites(PhotoModel photo);
  Future<void> removeFromFavorites(String id);
  Future<bool> isFavorite(String id);
}

class PhotoLocaleImpl implements PhotoLocale {
  const PhotoLocaleImpl(this._sqfliteClient);

  final SqfliteClient _sqfliteClient;


  @override
  Future<void> addToFavorites(PhotoModel photo) async {
    await _sqfliteClient.insert(
      favoritesTable,
      {
        'id': photo.id,
        'value': jsonEncode(photo.toJson()),
      },
    );
  }

  @override
  Future<void> removeFromFavorites(String id) async {
    await _sqfliteClient.delete(
      favoritesTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<bool> isFavorite(String id) async {
    final rows = await _sqfliteClient.query(
      favoritesTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    return rows.isNotEmpty;
  }
}
