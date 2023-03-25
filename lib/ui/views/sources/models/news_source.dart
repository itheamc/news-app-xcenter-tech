import 'package:news_app_xcenter_tech/utils/log_utils.dart';

class NewsSource {
  final String? id;
  final String? name;
  final String? description;
  final String? url;
  final String? category;
  final String? language;
  final String? country;

  /// Constructor
  NewsSource({
    this.id,
    this.name,
    this.description,
    this.url,
    this.category,
    this.language,
    this.country,
  });

  /// Factory method to convert the Json data to the NewsSource object
  factory NewsSource.fromJson(Map<String, dynamic> json) {
    return NewsSource(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      url: json['url'],
      category: json['category'],
      language: json['language'],
      country: json['country'],
    );
  }
}

/// Method to parse the news sources json data
Future<List<NewsSource>?> parseNewsSourcesJsonData(dynamic data) async {
  if (data == null) return null;

  final sources = data['sources'];

  if (sources == null || sources is! List) return null;

  final temp = List<NewsSource>.empty(growable: true);
  for (final json in sources) {
    try {
      temp.add(NewsSource.fromJson(json));
    } catch (e) {
      LogUtil.debug(
        message: e.toString(),
        functionName: 'parseNewsSourcesJsonData',
        className: "Global",
      );
      continue;
    }
  }

  return temp;
}
