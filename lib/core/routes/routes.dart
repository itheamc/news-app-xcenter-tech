import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:go_router/go_router.dart';

import '../../ui/views/error/error_screen.dart';
import '../../ui/views/news/news_screen.dart';
import '../../ui/views/splash/splash_screen.dart';

class Routes {
  static const splash = "/";
  static const home = "/home";
  static const news = "/news";
  static const newsDetail = "$news/:newsId";

  /// GoROuter
  /// For routes handling
  static final goRouter = GoRouter(
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: news,
        builder: (context, state) => const NewsScreen(),
      ),
    ],
    errorBuilder: (context, state) => ErrorScreen(err: state.error),
  );

  /// List of get pages to map routes with specific screens
  /// It hasn't used for this project
  static final getxRoutes = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: news,
      page: () => const NewsScreen(),
    ),
  ];
}
