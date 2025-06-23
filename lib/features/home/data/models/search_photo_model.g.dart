// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_photo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchPhotoModel _$SearchPhotoModelFromJson(Map<String, dynamic> json) =>
    SearchPhotoModel(
      (json['results'] as List<dynamic>)
          .map((e) => PhotoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchPhotoModelToJson(SearchPhotoModel instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
