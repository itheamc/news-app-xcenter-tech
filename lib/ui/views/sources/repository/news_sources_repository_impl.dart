import 'package:flutter/foundation.dart';
import 'package:news_app_xcenter_tech/core/api/endpoints.dart';
import 'package:news_app_xcenter_tech/core/handlers/network/request_handler.dart';

import '../../../../core/handlers/network/parshed_response.dart';
import '../../../../utils/log_utils.dart';
import '../models/news_source.dart';
import 'news_sources_repository.dart';

class NewsSourcesRepositoryImpl extends NewsSourcesRepository {
  /// Method to fetch the list of news sources
  @override
  Future<ParsedResponse<List<NewsSource>?>> fetchNewsSources(
      {Map<String, dynamic>? params}) async {
    try {
      final response = await RequestHandler.get(
        EndPoints.sources,
        queryParameters: params,
      );

      if (response.isSuccess) {
        final data = await compute<dynamic, List<NewsSource>?>(
          parseNewsSourcesJsonData,
          response.data,
        );

        return ParsedResponse(
          isSuccess: response.isSuccess,
          message: response.message,
          data: data,
        );
      }

      return ParsedResponse(
        isSuccess: response.isSuccess,
        message: response.message,
      );
    } catch (e) {
      LogUtil.debug(
        message: e.toString(),
        functionName: 'fetchNewsSources',
        className: runtimeType.toString(),
      );

      return ParsedResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }
}
