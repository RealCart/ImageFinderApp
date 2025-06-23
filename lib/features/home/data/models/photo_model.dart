import 'package:image_finder_app/features/home/data/models/links_model.dart';
import 'package:image_finder_app/features/home/data/models/profile_image.dart';
import 'package:image_finder_app/features/home/data/models/url_model.dart';
import 'package:image_finder_app/core/domain/entities/photo/photo_entity.dart';
import 'package:image_finder_app/features/home/data/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo_model.g.dart';

@JsonSerializable()
class PhotoModel {
  const PhotoModel({
    required this.id,
    required this.urls,
    required this.user,
    required this.links,
  });

  @JsonKey(name: 'id')
  final String id;
  final UrlModel urls;
  final UserModel user;
  final LinksModel links;

  factory PhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoModelFromJson(json);

  factory PhotoModel.fromEntity(PhotoEntity entity) => PhotoModel(
        id: entity.id,
        urls: UrlModel(entity.pathUrl),
        user: UserModel(
          username: entity.authorUsername,
          name: entity.authorName,
          profileImage: ProfileImage(medium: entity.profileImage),
        ),
        links: LinksModel(download: entity.downloadLink),
      );

  Map<String, dynamic> toJson() => _$PhotoModelToJson(this);

  PhotoEntity toEntity() => PhotoEntity(
        id: id,
        pathUrl: urls.regular,
        authorName: user.name,
        authorUsername: user.username,
        profileImage: user.profileImage.medium,
        downloadLink: links.download,
      );
}
