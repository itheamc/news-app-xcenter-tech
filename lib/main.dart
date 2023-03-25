import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_xcenter_tech/core/getx/getx_initial_bindings.dart';

import 'core/handlers/session/session_handler.dart';
import 'core/routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  /// Putting Session Handler on Get
  Get.putAsync<SessionHandler>(
    () async {
      final sessionHandler = await SessionHandler.getInstance();
      sessionHandler.storeToken("62dd8b7808664b94ab5ad1e718069ded");
      return sessionHandler;
    },
    permanent: true,
  ).then(
    (value) {
      runApp(const NewsApp());
    },
  );
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      initialBinding: GetxInitialBindings(),
      routerDelegate: Routes.goRouter.routerDelegate,
      routeInformationParser: Routes.goRouter.routeInformationParser,
      routeInformationProvider: Routes.goRouter.routeInformationProvider,
    );
  }
}
