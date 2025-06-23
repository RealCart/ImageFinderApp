import 'package:flutter/material.dart';

class ImageSkeleton extends StatelessWidget {
  const ImageSkeleton({super.key});

  @override
  Widget build(BuildContext context) => Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey.shade300,
        ),
      );
}