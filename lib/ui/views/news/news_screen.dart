import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app_xcenter_tech/ui/shared/no_data_or_error_container.dart';
import 'package:news_app_xcenter_tech/ui/shared/responsive_ui.dart';
import 'package:news_app_xcenter_tech/ui/views/news/controller/news_controller.dart';
import 'package:news_app_xcenter_tech/ui/views/news/models/news.dart';
import 'package:news_app_xcenter_tech/utils/extension_functions.dart';

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
  /// Getter for news source
  String get source => widget.source ?? 'bbc-news';

  /// Getter for screen title
  String? get title =>
      widget.source?.replaceAll("-", " ").capitalizeFirstOfEach;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadNews();
    });
  }

  /// Method to load news as per the given source
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
        title: Text(title ?? controller.title),
        centerTitle: true,
      ),
      body: _ui4Body(
        newsItems: ListView.builder(
          itemCount: controller.listOfNews.length,
          itemBuilder: (BuildContext context, int index) {
            final news = controller.listOfNews[index];
            return Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0.0),
              child: _ui4NewsItem(news),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget? ui4Desktop({Key? key}) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? controller.title),
        centerTitle: true,
      ),
      body: _ui4Body(
        newsItems: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 480.0,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
                childAspectRatio: 18 / 12),
            itemBuilder: (BuildContext context, int index) {
              final news = controller.listOfNews[index];
              return _ui4NewsItem(news);
            },
            itemCount: controller.listOfNews.length,
          ),
        ),
      ),
    );
  }

  @override
  Widget? ui4Tablet({Key? key}) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? controller.title),
        centerTitle: true,
      ),
      body: _ui4Body(
        newsItems: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
              childAspectRatio: 18 / 12.5,
            ),
            itemBuilder: (BuildContext context, int index) {
              final news = controller.listOfNews[index];
              return _ui4NewsItem(news);
            },
            itemCount: controller.listOfNews.length,
          ),
        ),
      ),
    );
  }

  /// UI for body
  Widget _ui4Body({
    required Widget newsItems,
  }) {
    return Obx(() {
      if (controller.fetchingNews) {
        return const LoadingIndicator(
          size: 36.0,
          lineWidth: 3.0,
          label: "Loading News...",
        );
      }

      if (controller.error != null) {
        return NoDataOrErrorContainer(
          message: controller.error,
        );
      }

      return newsItems;
    });
  }

  /// Ui for the news item
  Widget _ui4NewsItem(News news) {
    return InkWell(
      onTap: () {
        context.push('/news/$source/${news.id}', extra: news);
      },
      borderRadius: BorderRadius.circular(16.0),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 18 / 9,
              child: NetworkImageView(
                url: news.coverUrl ?? "",
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              news.title ?? "",
              style: context.textTheme.titleMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
