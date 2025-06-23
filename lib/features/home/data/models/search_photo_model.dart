import 'package:image_finder_app/features/home/data/models/photo_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_photo_model.g.dart';

@JsonSerializable()
class SearchPhotoModel {
  const SearchPhotoModel(this.results);

  final List<PhotoModel> results;

  factory SearchPhotoModel.fromJson(Map<String, dynamic> json) =>
      _$SearchPhotoModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchPhotoModelToJson(this);
}
