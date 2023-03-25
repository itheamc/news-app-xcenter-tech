import 'package:get/get.dart';
import 'package:news_app_xcenter_tech/ui/views/news/models/news.dart';
import 'package:news_app_xcenter_tech/ui/views/news/repository/news_repository.dart';
import 'package:news_app_xcenter_tech/ui/views/news/repository/news_repository_impl.dart';

import '../../../../utils/log_utils.dart';

class NewsController extends GetxController {
  String get title => "News";

  /// News Repository
  late NewsRepository _newsRepository;

  /// List of Banners
  final _listOfNews = List<News>.empty(growable: true).obs;

  List<News> get listOfBanners => _listOfNews;

  @override
  void onInit() {
    super.onInit();

    _newsRepository = NewsRepositoryImpl();
  }

  @override
  void onReady() {
    super.onReady();

    fetchNews();
  }

  /// Method to fetch the news from the api
  Future<void> fetchNews({Map<String, dynamic>? params}) async {
    try {
      final responseEntity = await _newsRepository.fetchNews(params: params);
    } catch (e) {
      LogUtil.debug(
        message: e.toString(),
        functionName: 'fetchNews',
        className: runtimeType.toString(),
      );
    }
  }
}
