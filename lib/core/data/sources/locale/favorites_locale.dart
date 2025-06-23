import 'dart:convert';

import 'package:image_finder_app/core/constants/constant_variables.dart';
import 'package:image_finder_app/core/data/sources/locale/sqflite_client.dart';
import 'package:image_finder_app/features/home/data/models/photo_model.dart';

abstract interface class FavoritesLocale {
  Future<List<PhotoModel>> getFavorites();
  Future<void> addToFavorites(PhotoModel photo);
  Future<void> removeFromFavorites(String id);
  Future<bool> isFavorite(String id);
}

class FavoritesLocaleImpl implements FavoritesLocale {
  const FavoritesLocaleImpl(this._sqfliteClient);

  final SqfliteClient _sqfliteClient;

  @override
  Future<List<PhotoModel>> getFavorites() async {
    final rows = await _sqfliteClient.query(favoritesTable);

    return rows
        .map((e) => PhotoModel.fromJson(
              jsonDecode(e['value'] as String) as Map<String, dynamic>,
            ))
        .toList();
  }

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
