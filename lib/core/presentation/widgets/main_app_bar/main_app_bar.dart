import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_finder_app/core/constants/app_assets.dart';
import 'package:image_finder_app/core/presentation/routes/app_router/app_router.gr.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isHomeScreen = context.router.current.name == HomeRoute.name;

    return SliverAppBar(
      leading: Container(
        margin: const EdgeInsets.only(left: 18.0),
        child: SvgPicture.asset(AppAssets.svg.logo),
      ),
      actionsPadding: const EdgeInsets.only(right: 10.0),
      actions: [
        if (isHomeScreen)
          IconButton(
            onPressed: () {
              context.router.push(const FavoritiesRoute());
            },
            highlightColor: Colors.white.withAlpha(50),
            icon: SvgPicture.asset(AppAssets.svg.heart),
          )
      ],
      leadingWidth: 120.0,
      toolbarHeight: 70.0,
      pinned: true,
      snap: true,
      floating: true,
      stretch: true,
      backgroundColor: const Color(0xff000000),
    );
  }
}
