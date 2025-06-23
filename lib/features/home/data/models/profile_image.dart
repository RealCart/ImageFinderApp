import 'package:json_annotation/json_annotation.dart';

part 'profile_image.g.dart';

@JsonSerializable()
class ProfileImage {
  const ProfileImage({required this.medium});

  final String medium;

  factory ProfileImage.fromJson(Map<String, dynamic> json) =>
      _$ProfileImageFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileImageToJson(this);
}
