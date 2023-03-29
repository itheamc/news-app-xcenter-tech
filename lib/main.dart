import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_xcenter_tech/core/getx/getx_initial_bindings.dart';
import 'package:news_app_xcenter_tech/utils/log_utils.dart';

import 'core/handlers/session/session_handler.dart';
import 'core/notification/fcm_notification_service.dart';
import 'core/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();

    /// Adding listener for onBackgroundMessage callback
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    if (!kIsWeb) {
      await setupFlutterLocalNotifications();
    }
  } catch (e) {
    LogUtil.debug(
      message: e.toString(),
      functionName: 'initializeApp',
      className: "Firebase",
    );
  }

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

/// Method to handle the background notification handling and display
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp();
    if (!kIsWeb) {
      await setupFlutterLocalNotifications();
    }
    showFirebaseNotification(message);
  } catch (e) {
    LogUtil.debug(
      message: e.toString(),
      functionName: '_firebaseMessagingBackgroundHandler',
      className: "Global",
    );
  }
}
