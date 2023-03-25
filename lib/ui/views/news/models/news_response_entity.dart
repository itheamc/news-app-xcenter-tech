import 'package:flutter/foundation.dart';

import '../../../../utils/log_utils.dart';
import 'news.dart';

class NewsResponseEntity {
  final String? status;
  final int? totalResults;
  final List<News> news;

  /// Constructor
  NewsResponseEntity({
    this.status,
    this.totalResults,
    this.news = const [],
  });

  /// Factory method to convert json data to the NewsResponseEntity
  factory NewsResponseEntity.fromJson(Map<String, dynamic> json) {
    return NewsResponseEntity(
      status: json['status'],
      totalResults: json['totalResults'],
      news: json['news'],
    );
  }
}

/// Method to parse the news response json data
Future<NewsResponseEntity?> parseNewsResponseJsonData(dynamic data) async {
  if (data == null) return null;

  try {
    final articles = data['articles'];
    final news = List<News>.empty(growable: true);

    if (articles != null && articles is List && articles.isNotEmpty) {
      final temp =
          await compute<dynamic, List<News>?>(parseNewsJsonData, articles);

      if (temp != null && temp.isNotEmpty) {
        news.addAll(temp);
      }
    }

    return NewsResponseEntity(
      status: data['status'],
      totalResults: data['totalResults'],
      news: news,
    );
  } catch (e) {
    LogUtil.debug(
      message: e.toString(),
      functionName: 'parseNewsResponseJsonData',
      className: "Global",
    );

    return null;
  }
}
