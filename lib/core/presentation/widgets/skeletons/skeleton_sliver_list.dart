import 'package:flutter/material.dart';
import 'package:image_finder_app/core/presentation/widgets/shimmer/shimmer.dart';
import 'package:image_finder_app/core/presentation/widgets/skeletons/image_skeleton.dart';

class SkeletonSliverList extends StatelessWidget {
  const SkeletonSliverList({super.key, required this.itemCount});
  final int itemCount;

  @override
  Widget build(BuildContext context) => SliverList.separated(
        itemCount: itemCount,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (_, __) => const Shimmer(
          child: ShimmerLoading(
            child: ImageSkeleton(),
          ),
        ),
      );
}
