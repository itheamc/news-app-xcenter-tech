import 'package:get/get.dart';
import 'package:news_app_xcenter_tech/ui/views/sources/repository/news_sources_repository_impl.dart';

import '../../../../utils/log_utils.dart';
import '../models/news_source.dart';
import '../repository/news_sources_repository.dart';

class NewsSourcesController extends GetxController {
  String get title => "News Sources";

  /// News Sources Repository
  late NewsSourcesRepository _sourcesRepository;

  /// List of News Sources
  final _listOfNewsSources = List<NewsSource>.empty(growable: true).obs;

  List<NewsSource> get listOfNewsSources => _listOfNewsSources;

  /// Network request progress observer
  final _fetchingNewsSources = false.obs;

  bool get fetchingNewsSources => _fetchingNewsSources.value;

  @override
  void onInit() {
    super.onInit();

    _sourcesRepository = NewsSourcesRepositoryImpl();
  }

  @override
  void onReady() {
    super.onReady();

    fetchNewsSources();
  }

  /// Method to fetch the news sources from the api
  Future<void> fetchNewsSources({Map<String, dynamic>? params}) async {
    if (fetchingNewsSources) return;

    try {
      _fetchingNewsSources.value = true;

      final response =
          await _sourcesRepository.fetchNewsSources(params: params);

      if (response.isSuccess && response.data != null) {
        _listOfNewsSources.clear();
        _listOfNewsSources.addAll(response.data!);
      }
    } catch (e) {
      LogUtil.debug(
        message: e.toString(),
        functionName: 'fetchNewsSources',
        className: runtimeType.toString(),
      );
    }
    _fetchingNewsSources.value = false;
  }
}
