import 'package:get/get.dart';
import 'package:news_app_xcenter_tech/ui/views/news/models/news.dart';
import 'package:news_app_xcenter_tech/ui/views/news/repository/news_repository.dart';
import 'package:news_app_xcenter_tech/ui/views/news/repository/news_repository_impl.dart';

import '../../../../utils/log_utils.dart';

class NewsController extends GetxController {
  String get title => "News";

  /// News Repository
  late NewsRepository _newsRepository;

  /// List of News
  final _listOfNews = List<News>.empty(growable: true).obs;

  List<News> get listOfNews => _listOfNews;

  /// Error
  final _error = "".obs;

  String? get error => _error.value.isEmpty ? null : _error.value;

  /// Network request progress observer
  final _fetchingNews = false.obs;
  final _fetchingTopHeadlines = false.obs;

  bool get fetchingNews => _fetchingNews.value;

  bool get fetchingTopHeadlines => _fetchingTopHeadlines.value;

  @override
  void onInit() {
    super.onInit();

    _newsRepository = NewsRepositoryImpl();
  }

  @override
  void onReady() {
    super.onReady();

    fetchNews(
      params: News.queryParams(
        query: 'bitcoin',
        pageSize: 10,
      ),
    );
  }

  /// Method to fetch the news from the api
  Future<void> fetchNews({Map<String, dynamic>? params}) async {
    if (fetchingNews) return;

    try {
      _fetchingNews.value = true;
      _error.value = "";

      final response = await _newsRepository.fetchNews(params: params);

      if (response.isSuccess && response.data != null) {
        _listOfNews.clear();
        _listOfNews.addAll(response.data!.news);
      } else {
        _error.value = response.message ?? "";
      }
    } catch (e) {
      LogUtil.debug(
        message: e.toString(),
        functionName: 'fetchNews',
        className: runtimeType.toString(),
      );
    }

    _fetchingNews.value = false;
  }
}
