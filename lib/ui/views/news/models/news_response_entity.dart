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
