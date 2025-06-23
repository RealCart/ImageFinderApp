import 'package:flutter/material.dart';
import 'package:image_finder_app/core/constants/app_assets.dart';
import 'package:image_finder_app/features/home/presentation/widgets/search_app_bar_widger.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    super.key,
    required this.onChanged,
  });

  final void Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 230.0,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              AppAssets.image.background,
              fit: BoxFit.cover,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SearchAppBarWidget(
                  onChanged: onChanged,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
