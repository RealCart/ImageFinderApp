import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

@RoutePage()
class FullPhotoRoute extends StatelessWidget {
  const FullPhotoRoute({
    super.key,
    required this.tag,
    required this.url,
  });

  final String tag;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => context.router.pop(),
        child: Center(
          child: PhotoView(
            imageProvider: NetworkImage(url),
            loadingBuilder: (context, event) {
              return CircularProgressIndicator(
                color: const Color(0xffFFF200),
                backgroundColor: Colors.black,
              );
            },
            heroAttributes: PhotoViewHeroAttributes(tag: tag),
            backgroundDecoration:
                const BoxDecoration(color: Colors.transparent),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          ),
        ),
      ),
    );
  }
}
