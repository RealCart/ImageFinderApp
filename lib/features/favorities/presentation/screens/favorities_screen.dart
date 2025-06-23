import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_finder_app/core/presentation/routes/app_router/app_router.gr.dart';
import 'package:image_finder_app/core/presentation/widgets/main_app_bar/main_app_bar.dart';
import 'package:image_finder_app/core/presentation/widgets/refresh_indicator/custom_refresh_indicator.dart';
import 'package:image_finder_app/core/presentation/widgets/skeletons/skeleton_sliver_list.dart';
import 'package:image_finder_app/core/utils/status_enum/status_enum.dart';
import 'package:image_finder_app/features/favorities/presentation/bloc/favorities_bloc/favorities_bloc.dart';
import 'package:image_finder_app/core/presentation/widgets/photo_widget.dart';
import 'package:image_finder_app/service_locator.dart';

@RoutePage()
class FavoritiesScreen extends StatelessWidget implements AutoRouteWrapper {
  const FavoritiesScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<FavoritiesBloc>()..add(GetFavoritiesEvent()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomRefreshIndicator(
        onRefresh: () async {
          Completer<void> completer = Completer();
          context.read<FavoritiesBloc>().add(GetFavoritiesEvent(completer: completer));
          return completer.future;
        },
        child: CustomScrollView(
          slivers: [
            MainAppBar(),
            SliverToBoxAdapter(
              child: const SizedBox(height: 40.0),
            ),
            BlocBuilder<FavoritiesBloc, FavoritiesState>(
              builder: (context, state) {
                if (state.status == StatusEnum.loading) {
                  return const SliverPadding(
                    padding: EdgeInsets.fromLTRB(19, 45, 19, 10),
                    sliver: SkeletonSliverList(itemCount: 6),
                  );
                }
                return SliverPadding(
                  padding: const EdgeInsets.fromLTRB(19, 45, 19, 10),
                  sliver: SliverList.separated(
                    itemCount: state.favorities.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final item = state.favorities[index];

                      return PhotoWidget(
                        url: item.pathUrl,
                        onPressed: () => context.router.push(
                          PhotoRoute(entity: item),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
