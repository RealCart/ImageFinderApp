import 'dart:convert';

import 'package:image_finder_app/core/constants/constant_variables.dart';
import 'package:image_finder_app/core/data/sources/locale/sqflite_client.dart';
import 'package:image_finder_app/features/home/data/models/photo_model.dart';

abstract interface class FavoritesLocale {
  Future<List<PhotoModel>> getFavorites();
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
}
