import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app_xcenter_tech/ui/shared/responsive_ui.dart';
import 'package:news_app_xcenter_tech/ui/views/news/controller/news_controller.dart';
import 'package:news_app_xcenter_tech/ui/views/news/models/news.dart';

import '../../shared/image_view.dart';
import '../../shared/loading_indicator.dart';

class NewsScreen extends StatefulWidget {
  final String? source;

  const NewsScreen({Key? key, this.source}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>
    with ResponsiveUiMixin<NewsController> {
  String get source => widget.source ?? 'bbc-news';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadNews();
    });
  }

  Future<void> _loadNews() async {
    controller.fetchNews(
      params: News.queryParams(
        sources: source,
        pageSize: 50,
      ),
    );
  }

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
        if (controller.fetchingNews) {
          return const LoadingIndicator(
            size: 36.0,
            lineWidth: 3.0,
            label: "Loading News...",
          );
        }

        return ListView.builder(
          itemCount: controller.listOfNews.length,
          itemBuilder: (BuildContext context, int index) {
            final news = controller.listOfNews[index];
            return Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
              child: InkWell(
                onTap: () {
                  context.go('/news/$source/${news.id}', extra: news);
                },
                borderRadius: BorderRadius.circular(16.0),
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 18 / 9,
                        child: NetworkImageView(
                          url: news.coverUrl ?? "",
                          fit: BoxFit.cover,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      Text(
                        news.title ?? "",
                        style: context.textTheme.titleMedium,
                      ),
                    ],
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
