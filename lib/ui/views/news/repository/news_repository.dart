
import 'package:news_app_xcenter_tech/ui/views/news/models/news_response_entity.dart';

abstract class NewsRepository {

  /// Method to fetch the news list
  Future<NewsResponseEntity> fetchNews({Map<String, dynamic>? params});
}