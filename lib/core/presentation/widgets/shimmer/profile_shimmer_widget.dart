import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_finder_app/core/presentation/widgets/skeletons/profile_skeleton.dart';
import 'package:image_finder_app/core/presentation/widgets/shimmer/shimmer.dart';

class ProfileShimmerWidget extends StatelessWidget {
  const ProfileShimmerWidget({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          placeholder: (_, __) => Shimmer(
            child: ShimmerLoading(
              child: ProfileSkeleton(),
            ),
          ),
          errorWidget: (_, __, ___) => const Icon(Icons.error),
        ));
  }
}
