import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app_xcenter_tech/ui/views/sources/news_sources_screen.dart';

import '../../ui/views/error/error_screen.dart';
import '../../ui/views/news/news_screen.dart';
import '../../ui/views/splash/splash_screen.dart';

class Routes {
  static const splash = "/";
  static const news = "/news";
  static const newsDetail = "$news/:newsId";
  static const sources = "/sources";

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
      GoRoute(
        path: newsDetail,
        builder: (context, state) => const NewsScreen(),
      ),
      GoRoute(
        path: sources,
        builder: (context, state) => const NewsSourcesScreen(),
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
    GetPage(
      name: sources,
      page: () => const NewsSourcesScreen(),
    ),
  ];
}
