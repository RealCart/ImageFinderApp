import 'package:flutter/material.dart';
import 'package:image_finder_app/core/config/app_theme.dart';
import 'package:image_finder_app/core/presentation/routes/app_router/app_router.dart';
import 'package:image_finder_app/service_locator.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  serviceLoactor();
  await sl.allReady();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppRouter router = AppRouter();


    return ToastificationWrapper(
      config: ToastificationConfig(
        maxToastLimit: 1,
      ),
      child: MaterialApp.router(
        title: 'Image Fined App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        routerConfig: router.config(),
      ),
    );
  }
}
