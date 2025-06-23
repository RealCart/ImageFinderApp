import 'dart:async';
import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_finder_app/core/presentation/routes/app_router/app_router.gr.dart';
import 'package:image_finder_app/core/presentation/widgets/main_app_bar/main_app_bar.dart';
import 'package:image_finder_app/core/presentation/widgets/refresh_indicator/custom_refresh_indicator.dart';
import 'package:image_finder_app/core/presentation/widgets/skeletons/skeleton_sliver_list.dart';
import 'package:image_finder_app/core/utils/status_enum/status_enum.dart';
import 'package:image_finder_app/features/home/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:image_finder_app/features/home/presentation/widgets/custom_error_part.dart';
import 'package:image_finder_app/core/presentation/widgets/photo_widget.dart';
import 'package:image_finder_app/features/home/presentation/widgets/search_app_bar.dart';
import 'package:image_finder_app/service_locator.dart';

@RoutePage()
class HomeScreen extends StatefulWidget implements AutoRouteWrapper {
  const HomeScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider(
        create: (_) => sl<HomeBloc>()..add(const GetRandomPhotosEvent()),
        child: this,
      );

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final bloc = context.read<HomeBloc>();
    if (bloc.state.searchIsEmpty) return;

    final maxExtent = _scrollController.position.maxScrollExtent;
    final current = _scrollController.position.pixels;
    if (maxExtent - current <= 300) {
      log("EVENT SED", name: "BLOC EVENTT");
      bloc.add(GetMorePhotoEvent());
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomRefreshIndicator(
        onRefresh: () {
          final completer = Completer<void>();
          context
              .read<HomeBloc>()
              .add(PullToRefreshEvent(completer: completer));
          return completer.future;
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            const MainAppBar(),
            SearchAppBar(
              onChanged: (value) =>
                  context.read<HomeBloc>().add(SearchPhotoEvent(value: value)),
            ),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                final isFirstLoading = state.status == StatusEnum.loading &&
                    (state.photo?.isEmpty ?? true);

                if (state.status == StatusEnum.error && state.error != null) {
                  return SliverPadding(
                    padding: const EdgeInsets.only(top: 30),
                    sliver: SliverToBoxAdapter(
                      child: CustomErrorPart(errorType: state.error!),
                    ),
                  );
                }

                if (isFirstLoading) {
                  return const SliverPadding(
                    padding: EdgeInsets.fromLTRB(19, 45, 19, 10),
                    sliver: SkeletonSliverList(itemCount: 6),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.fromLTRB(19, 45, 19, 10),
                  sliver: SliverList.separated(
                    itemCount: state.photo!.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final item = state.photo![index];
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
            BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (p, c) => p.loadingMore != c.loadingMore,
              builder: (context, state) {
                if (state.loadingMore != StatusEnum.loading) {
                  return const SliverToBoxAdapter(child: SizedBox());
                }
                return const SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 19),
                  sliver: SkeletonSliverList(itemCount: 3),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
