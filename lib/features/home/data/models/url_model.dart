import 'package:json_annotation/json_annotation.dart';

part 'url_model.g.dart';

@JsonSerializable()
class UrlModel {
  const UrlModel(this.regular);

  final String regular;

  factory UrlModel.fromJson(Map<String, dynamic> json) =>
      _$UrlModelFromJson(json);

  Map<String, dynamic> toJson() => _$UrlModelToJson(this);
}
