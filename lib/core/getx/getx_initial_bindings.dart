import 'package:get/get.dart';
import 'package:news_app_xcenter_tech/core/controllers/connectivity_controller.dart';
import 'package:news_app_xcenter_tech/ui/views/news/controller/news_controller.dart';

import '../../ui/views/sources/controller/news_sources_controller.dart';
import '../handlers/session/session_handler.dart';

class GetxInitialBindings extends Bindings {
  @override
  void dependencies() {
    /// Putting Session Handler on Get
    Get.putAsync<SessionHandler>(
      () async {
        final sessionHandler = await SessionHandler.getInstance();
        return sessionHandler;
      },
      permanent: true,
    );

    /// Putting Connectivity Controller
    Get.put<ConnectivityController>(ConnectivityController());

    /// Putting NewsController to the getx
    Get.lazyPut<NewsController>(
      () => NewsController(),
      fenix: true,
    );

    /// Putting NewsSourcesController to the getx
    Get.lazyPut<NewsSourcesController>(
      () => NewsSourcesController(),
      fenix: true,
    );
  }
}
