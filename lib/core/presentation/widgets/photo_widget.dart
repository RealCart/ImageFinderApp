import 'package:flutter/material.dart';
import 'package:image_finder_app/core/presentation/widgets/shimmer/image_shimmer_widget.dart';

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({
    super.key,
    required this.url,
    required this.onPressed,
  });

  final String url;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ImageShimmerWidget(
        url: url,
      ),
    );
  }
}
