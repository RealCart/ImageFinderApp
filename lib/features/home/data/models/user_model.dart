import 'package:image_finder_app/features/home/data/models/profile_image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  const UserModel({
    required this.username,
    required this.name,
    required this.profileImage,
  });

  final String username;
  final String name;

  @JsonKey(name: "profile_image")
  final ProfileImage profileImage;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
