import 'package:news_app_xcenter_tech/core/handlers/network/parshed_response.dart';

import '../models/news_source.dart';

abstract class NewsSourcesRepository {
  /// Method to fetch the list of news sources
  Future<ParsedResponse<List<NewsSource>?>> fetchNewsSources(
      {Map<String, dynamic>? params});
}
