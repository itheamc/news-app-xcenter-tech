import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_xcenter_tech/ui/shared/loading_indicator.dart';
import 'package:news_app_xcenter_tech/ui/shared/no_data_container.dart';
import 'package:news_app_xcenter_tech/ui/shared/responsive_ui.dart';
import 'package:news_app_xcenter_tech/ui/views/news/controller/news_controller.dart';
import 'package:news_app_xcenter_tech/ui/views/news/models/news.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailsScreen extends StatefulWidget {
  // It is not best practice to pass object itself here
  // Instead we have to pass the id and from the id we can fetch details
  // But in the API that i am using here, there is no endpoint to fetch details
  // by id
  final News? news;

  const NewsDetailsScreen({Key? key, this.news}) : super(key: key);

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen>
    with ResponsiveUiMixin<NewsController> {
  /// Getter for news object
  News? get news => widget.news;

  /// WebViewController
  late WebViewController _webViewController;

  /// Boolean for loading progress monitor
  final _loading = true.obs;

  bool get loading => _loading.value;

  /// Error
  final _error = "".obs;

  String? get error => _error.value.isEmpty ? null : _error.value;

  @override
  void initState() {
    super.initState();

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {

          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              _loading.value = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            _loading.value = false;
            _error.value = error.description;
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(news?.url ?? ""));
  }

  @override
  Widget build(BuildContext context) {
    return buildUi(context);
  }

  @override
  Widget ui4Phone({Key? key}) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(controller.title),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: Obx(() {
          if (loading) {
            return const LoadingIndicator(
              label: "Wait...",
              size: 36.0,
            );
          }

          if (error != null) {
            return NoDataContainer(
              message: error ?? "",
              onReload: () {
                _webViewController.reload();
              },
            );
          }
          return WebViewWidget(controller: _webViewController);
        }),
      ),
    );
  }

  @override
  Widget? ui4Desktop({Key? key}) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title),
        centerTitle: true,
      ),
    );
  }

  @override
  Widget? ui4Tablet({Key? key}) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title),
        centerTitle: true,
      ),
    );
  }

  @override
  Widget? ui4Watch({Key? key}) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.orange,
        child: const Center(
          child: Text("I am watch"),
        ),
      ),
    );
  }
}
