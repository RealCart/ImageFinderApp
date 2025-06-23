class PhotoEntity {
  const PhotoEntity({
    required this.id,
    required this.pathUrl,
    required this.authorName,
    required this.authorUsername,
    required this.profileImage,
    required this.downloadLink,
  });

  final String id;
  final String pathUrl;
  final String authorName;
  final String authorUsername;
  final String profileImage;
  final String downloadLink;
}
