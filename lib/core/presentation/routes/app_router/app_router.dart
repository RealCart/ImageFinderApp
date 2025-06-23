import 'package:auto_route/auto_route.dart';
import 'package:image_finder_app/core/presentation/routes/app_router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        CupertinoRoute(page: HomeRoute.page, initial: true),
        CupertinoRoute(page: PhotoRoute.page),
        CupertinoRoute(page: FavoritiesRoute.page),
      ];
}
