import '../../../../utils/log_utils.dart';
import '../../sources/models/news_source.dart';

class News {
  final String? id;
  final String? title;
  final String? description;
  final String? author;
  final NewsSource? source;
  final String? url;
  final String? coverUrl;
  final DateTime? publishedAt;
  final String? content;

  /// Constructor
  News({
    this.id,
    this.title,
    this.description,
    this.author,
    this.source,
    this.url,
    this.coverUrl,
    this.publishedAt,
    this.content,
  });

  /// Factory method to convert json data to news object
  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      author: json['author'],
      source:
          json['source'] != null ? NewsSource.fromJson(json['source']) : null,
      url: json['url'],
      coverUrl: json['urlToImage'],
      publishedAt: json['publishedAt'] != null
          ? DateTime.tryParse(json['publishedAt'])
          : null,
      content: json['content'],
    );
  }

  /// static method to build query params for news
  static Map<String, dynamic>? queryParams({
    String? query, // Search Query
    String? searchIn, // The possible options are: title, description, content
    String? sources,
    String? domains, // eg bbc.co.uk, techcrunch.com
    String? excludeDomains, // bbc.co.uk
    DateTime? from,
    DateTime? to,
    String? language, // ar, de, en, es, fr, he, etc
    String? sortBy,
    int? pageSize,
    int? page,
  }) {
    final params = <String, dynamic>{};

    if (query != null) {
      params['q'] = query;
    }

    if (searchIn != null) {
      params['searchIn'] = searchIn;
    }

    if (sources != null) {
      params['sources'] = sources;
    }

    if (domains != null) {
      params['domains'] = domains;
    }

    if (excludeDomains != null) {
      params['excludeDomains'] = excludeDomains;
    }

    if (from != null) {
      params['from'] = from.toIso8601String();
    }

    if (to != null) {
      params['to'] = to.toIso8601String();
    }

    if (language != null) {
      params['language'] = language;
    }

    if (sortBy != null) {
      params['sortBy'] = sortBy;
    }

    if (pageSize != null) {
      params['pageSize'] = pageSize;
    }

    if (page != null) {
      params['page'] = page;
    }

    return params.isNotEmpty ? params : null;
  }
}

/// Method to parse the news json data
Future<List<News>?> parseNewsJsonData(dynamic data) async {
  if (data == null || data is! List) return null;

  final temp = List<News>.empty(growable: true);
  for (final json in data) {
    try {
      temp.add(News.fromJson(json));
    } catch (e) {
      LogUtil.debug(
        message: e.toString(),
        functionName: 'parseNewsJsonData',
        className: "Global",
      );
      continue;
    }
  }

  return temp;
}
