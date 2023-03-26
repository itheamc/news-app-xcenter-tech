import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app_xcenter_tech/ui/shared/loading_indicator.dart';
import 'package:news_app_xcenter_tech/ui/shared/responsive_ui.dart';
import 'package:news_app_xcenter_tech/ui/views/sources/controller/news_sources_controller.dart';

class NewsSourcesScreen extends StatefulWidget {
  const NewsSourcesScreen({Key? key}) : super(key: key);

  @override
  State<NewsSourcesScreen> createState() => _NewsSourcesScreenState();
}

class _NewsSourcesScreenState extends State<NewsSourcesScreen>
    with ResponsiveUiMixin<NewsSourcesController> {
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
      body: Obx(() {
        if (controller.fetchingNewsSources) {
          return const LoadingIndicator(
            size: 36.0,
            lineWidth: 3.0,
            label: "Loading Sources...",
          );
        }

        return ListView.builder(
          itemCount: controller.listOfNewsSources.length,
          itemBuilder: (BuildContext context, int index) {
            final source = controller.listOfNewsSources[index];
            return InkWell(
              onTap: () {
                context.go('/news/${source.id}');
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
      }),
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
