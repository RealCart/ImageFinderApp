// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:image_finder_app/core/domain/entities/photo/photo_entity.dart'
    as _i7;
import 'package:image_finder_app/features/favorities/presentation/screens/favorities_screen.dart'
    as _i1;
import 'package:image_finder_app/features/home/presentation/screens/home_screen.dart'
    as _i3;
import 'package:image_finder_app/features/photo/presentation/screen/full_photo_screen.dart'
    as _i2;
import 'package:image_finder_app/features/photo/presentation/screen/photo_screen.dart'
    as _i4;

/// generated route for
/// [_i1.FavoritiesScreen]
class FavoritiesRoute extends _i5.PageRouteInfo<void> {
  const FavoritiesRoute({List<_i5.PageRouteInfo>? children})
      : super(FavoritiesRoute.name, initialChildren: children);

  static const String name = 'FavoritiesRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return _i5.WrappedRoute(child: const _i1.FavoritiesScreen());
    },
  );
}

/// generated route for
/// [_i2.FullPhotoRoute]
class FullPhotoRoute extends _i5.PageRouteInfo<FullPhotoRouteArgs> {
  FullPhotoRoute({
    _i6.Key? key,
    required String tag,
    required String url,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          FullPhotoRoute.name,
          args: FullPhotoRouteArgs(key: key, tag: tag, url: url),
          initialChildren: children,
        );

  static const String name = 'FullPhotoRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FullPhotoRouteArgs>();
      return _i2.FullPhotoRoute(key: args.key, tag: args.tag, url: args.url);
    },
  );
}

class FullPhotoRouteArgs {
  const FullPhotoRouteArgs({this.key, required this.tag, required this.url});

  final _i6.Key? key;

  final String tag;

  final String url;

  @override
  String toString() {
    return 'FullPhotoRouteArgs{key: $key, tag: $tag, url: $url}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FullPhotoRouteArgs) return false;
    return key == other.key && tag == other.tag && url == other.url;
  }

  @override
  int get hashCode => key.hashCode ^ tag.hashCode ^ url.hashCode;
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return _i5.WrappedRoute(child: const _i3.HomeScreen());
    },
  );
}

/// generated route for
/// [_i4.PhotoScreen]
class PhotoRoute extends _i5.PageRouteInfo<PhotoRouteArgs> {
  PhotoRoute({
    _i6.Key? key,
    required _i7.PhotoEntity entity,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          PhotoRoute.name,
          args: PhotoRouteArgs(key: key, entity: entity),
          initialChildren: children,
        );

  static const String name = 'PhotoRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PhotoRouteArgs>();
      return _i5.WrappedRoute(
        child: _i4.PhotoScreen(key: args.key, entity: args.entity),
      );
    },
  );
}

class PhotoRouteArgs {
  const PhotoRouteArgs({this.key, required this.entity});

  final _i6.Key? key;

  final _i7.PhotoEntity entity;

  @override
  String toString() {
    return 'PhotoRouteArgs{key: $key, entity: $entity}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PhotoRouteArgs) return false;
    return key == other.key && entity == other.entity;
  }

  @override
  int get hashCode => key.hashCode ^ entity.hashCode;
}
