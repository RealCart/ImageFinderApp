import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_finder_app/core/constants/app_assets.dart';
import 'package:image_finder_app/core/domain/entities/photo/photo_entity.dart';
import 'package:image_finder_app/core/presentation/routes/app_router/app_router.gr.dart';
import 'package:image_finder_app/core/presentation/widgets/main_app_bar/main_app_bar.dart';
import 'package:image_finder_app/core/presentation/widgets/shimmer/image_shimmer_widget.dart';
import 'package:image_finder_app/core/presentation/widgets/shimmer/profile_shimmer_widget.dart';
import 'package:image_finder_app/core/utils/status_enum/status_enum.dart';
import 'package:image_finder_app/core/utils/toastification/custom_toastification.dart';
import 'package:image_finder_app/features/photo/presentation/bloc/photo_bloc/photo_bloc.dart';
import 'package:image_finder_app/service_locator.dart';

@RoutePage()
class PhotoScreen extends StatelessWidget implements AutoRouteWrapper {
  const PhotoScreen({
    super.key,
    required this.entity,
  });

  final PhotoEntity entity;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<PhotoBloc>()..add(CheckFavoriteStatusEvent(id: entity.id)),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<PhotoBloc, PhotoState>(
        listener: (context, state) {
          if (state.downloadStatus == StatusEnum.successfulll) {
            context.showSuccessToast('Downloaded successfully');
          } else if (state.downloadStatus == StatusEnum.error) {
            context.showErrorToast('Download failed');
          }
        },
        child: CustomScrollView(
          slivers: [
            MainAppBar(),
            SliverToBoxAdapter(
              child: const SizedBox(height: 40.0),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsetsGeometry.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ProfileShimmerWidget(
                          url: entity.profileImage,
                        ),
                        const SizedBox(width: 11.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                entity.authorName,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.black),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                              Text(
                                '@${entity.authorUsername}',
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.grey),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        BlocBuilder<PhotoBloc, PhotoState>(
                          builder: (context, state) {
                            return InkWell(
                              onTap: () {
                                context.read<PhotoBloc>().add(
                                      ToggleFavoriteEvent(photo: entity),
                                    );
                              },
                              highlightColor: Colors.black.withAlpha(50),
                              borderRadius: BorderRadius.circular(16.0),
                              radius: 16.0,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 11.0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withAlpha(50),
                                      blurRadius: 10.0,
                                    ),
                                  ],
                                ),
                                child: SvgPicture.asset(
                                  state.isLiked
                                      ? AppAssets.svg.likedHeart
                                      : AppAssets.svg.blackHeart,
                                ),
                              ),
                            );
                          },
                        ),
                        BlocBuilder<PhotoBloc, PhotoState>(
                          builder: (context, state) {
                            return IconButton(
                              onPressed: () => context.read<PhotoBloc>().add(
                                    DownloadPhotoEvent(photo: entity),
                                  ),
                              icon: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 11.0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: const Color(0xffFFF200),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withAlpha(100),
                                    ),
                                  ],
                                ),
                                child: state.isDownloading
                                    ? SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            Colors.black,
                                          ),
                                        ),
                                      )
                                    : SvgPicture.asset(AppAssets.svg.download),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 32.0),
                    Stack(
                      children: [
                        Hero(
                          tag: 'photo-${entity.id}',
                          child: ImageShimmerWidget(
                            url: entity.pathUrl,
                          ),
                        ),
                        Positioned(
                          bottom: 10.0,
                          right: 10.0,
                          child: IconButton(
                            onPressed: () => context.router.push(
                              FullPhotoRoute(
                                tag: 'photo-${entity.id}',
                                url: entity.pathUrl,
                              ),
                            ),
                            icon: SvgPicture.asset(AppAssets.svg.photoView),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
