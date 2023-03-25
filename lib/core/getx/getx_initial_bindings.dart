import 'package:get/get.dart';
import 'package:news_app_xcenter_tech/ui/views/news/controller/news_controller.dart';

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

    /// Putting NewsController to the getx
    Get.lazyPut<NewsController>(() => NewsController(), fenix: true);
  }
}
