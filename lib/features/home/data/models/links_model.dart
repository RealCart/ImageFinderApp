import 'package:json_annotation/json_annotation.dart';

part 'links_model.g.dart';

@JsonSerializable()
class LinksModel {
  const LinksModel({required this.download});

  final String download;

  factory LinksModel.fromJson(Map<String, dynamic> json) =>
      _$LinksModelFromJson(json);

  Map<String, dynamic> toJson() => _$LinksModelToJson(this);
}
