import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app_xcenter_tech/core/controllers/connectivity_controller.dart';
import 'package:news_app_xcenter_tech/core/handlers/session/session_handler.dart';
import 'package:news_app_xcenter_tech/ui/shared/loading_indicator.dart';
import 'package:news_app_xcenter_tech/ui/shared/no_data_or_error_container.dart';
import 'package:news_app_xcenter_tech/ui/shared/no_internet.dart';
import 'package:news_app_xcenter_tech/ui/shared/responsive_ui.dart';
import 'package:news_app_xcenter_tech/ui/views/sources/controller/news_sources_controller.dart';

import '../../../core/notification/fcm_notification_handler.dart';
import '../../../utils/log_utils.dart';

class NewsSourcesScreen extends StatefulWidget {
  const NewsSourcesScreen({Key? key}) : super(key: key);

  @override
  State<NewsSourcesScreen> createState() => _NewsSourcesScreenState();
}

class _NewsSourcesScreenState extends State<NewsSourcesScreen>
    with ResponsiveUiMixin<NewsSourcesController> {
  /// Connectivity Controller
  final _connectivityController = Get.find<ConnectivityController>();

  /// Session Handler
  final _sessionHandler = Get.find<SessionHandler>();

  @override
  void initState() {
    super.initState();

    // Requesting Notification Permission
    // For android devices running on android 13 or more
    FCMNotificationHandler.requestPermission().then((granted) {
      if (granted) {
        // Initialize Firebase Notification
        FCMNotificationHandler.initialize(
          onTokenRefreshed: _onTokenRefreshListener,
          onMessageOpenedApp: _handleOnMessageOpenedApp,
          onMessage: _onNotificationReceive,
        );
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadNewsSources();
    });
  }

  /// Method to load news sources
  Future<void> _loadNewsSources() async {
    if (_connectivityController.hasInternet) {
      if (controller.listOfNewsSources.isEmpty) {
        await controller.fetchNewsSources();
      }
    }
  }

  ///------------------------------FOR NOTIFICATION------------------------
  /// OnTokenRefresh Listener
  Future<void> _onTokenRefreshListener(String token) async {
    // Checking user login status
    final isLoggedIn = _sessionHandler.loggedIn;

    if (!isLoggedIn) return;

    // Checking internet connection status
    if (_connectivityController.hasInternet) {
      // Save the initial token to the database
      LogUtil.debug(
        message: token,
        functionName: '_onTokenRefreshListener',
        className: runtimeType.toString(),
      );
    }
  }

  /// Method to handle message
  Future<void> _handleOnMessageOpenedApp(RemoteMessage message) async {
    /// Handle routing as per the notification data
  }

  /// Store notification to the database
  Future<void> _onNotificationReceive(RemoteMessage message) async {}

  @override
  Widget build(BuildContext context) {
    return buildUi(context);
  }

  @override
  Widget ui4Phone({Key? key}) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title),
        centerTitle: true,
      ),
      body: _ui4Body(),
    );
  }

  /// UI for body
  Widget _ui4Body() {
    return Obx(() {
      if (controller.fetchingNewsSources) {
        return const LoadingIndicator(
          size: 36.0,
          lineWidth: 3.0,
          label: "Loading Sources...",
        );
      }

      if (controller.error != null) {
        return NoDataOrErrorContainer(
          message: controller.error,
        );
      }

      if (controller.listOfNewsSources.isEmpty &&
          !_connectivityController.hasInternet) {
        return NoInternet(
          onReload: _loadNewsSources,
        );
      }

      if (controller.listOfNewsSources.isEmpty &&
          _connectivityController.hasInternet) {
        return NoDataOrErrorContainer(
          message: "No News Sources Found!!!",
          onReload: _loadNewsSources,
        );
      }

      return ListView.builder(
        itemCount: controller.listOfNewsSources.length,
        itemBuilder: (BuildContext context, int index) {
          final source = controller.listOfNewsSources[index];
          return InkWell(
            onTap: () {
              context.push('/news/${source.id}');
            },
            child: Ink(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                source.name ?? "",
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
