import 'package:news_app_xcenter_tech/core/handlers/network/parshed_response.dart';
import 'package:news_app_xcenter_tech/ui/views/news/models/news_response_entity.dart';

abstract class NewsRepository {
  /// Method to fetch the list of news
  Future<ParsedResponse<NewsResponseEntity?>> fetchNews({
    Map<String, dynamic>? params,
    bool onlyTopHeadlines = false,
  });
}
