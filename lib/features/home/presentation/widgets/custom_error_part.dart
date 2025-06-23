import 'package:flutter/material.dart';
import 'package:image_finder_app/core/constants/app_assets.dart';
import 'package:image_finder_app/core/utils/error/failure.dart';
import 'package:image_finder_app/features/home/presentation/widgets/custom_error_widget.dart';

class CustomErrorPart extends StatelessWidget {
  const CustomErrorPart({
    super.key,
    required this.errorType,
  });

  final Failure errorType;

  @override
  Widget build(BuildContext context) {
    return switch (errorType) {
      BadResponseFailure() => CustomErrorWidget(
          errorPicture: AppAssets.image.badResponseFailure,
          reason: errorType.errorMessage,
        ),
      NetworkFailure() => CustomErrorWidget(
          errorPicture: AppAssets.image.networkFailure,
          reason: errorType.errorMessage,
        ),
      TimeoutFailure() => CustomErrorWidget(
          errorPicture: AppAssets.image.timeOutFailure,
          reason: errorType.errorMessage,
        ),
      UnexpectedFailure() => CustomErrorWidget(
          errorPicture: AppAssets.image.networkFailure,
          reason: errorType.errorMessage,
        ),
      _ => CustomErrorWidget(
          errorPicture: AppAssets.image.badResponseFailure,
          reason: "Try again later...",
        ),
    };
  }
}
