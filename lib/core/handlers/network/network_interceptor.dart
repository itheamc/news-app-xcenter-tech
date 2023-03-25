import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../utils/log_utils.dart';
import 'network_response.dart';

///--------------------------------@mit------------------------------
/// Custom Network Interceptor Class to Handle the errors
class NetworkInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    LogUtil.debug(
      message: options.uri.toString(),
      functionName: 'onRequest',
      className: runtimeType.toString(),
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final success = (response.statusCode ?? 0) ~/ 200 == 1;
    if (success) {
      return handler.next(
        SuccessResponse(
          data: response.data,
          requestOptions: response.requestOptions,
          headers: response.headers,
          isRedirect: response.isRedirect,
          statusCode: response.statusCode,
          statusMessage:
              response.statusMessage ?? "Data fetched successfully!!",
          redirects: response.redirects,
          extra: response.extra,
        ),
      );
    } else {
      LogUtil.debug(
        message: response.data,
        functionName: 'onResponse',
        className: runtimeType.toString(),
      );

      return handler.next(
        FailureResponse(
          data: response.data,
          requestOptions: response.requestOptions,
          headers: response.headers,
          isRedirect: response.isRedirect,
          statusCode: response.statusCode,
          statusMessage: "Request Failed",
          redirects: response.redirects,
          extra: response.extra,
        ),
      );
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    LogUtil.debug(
      message: err.message ?? err.type.name,
      functionName: 'onError',
      className: runtimeType.toString(),
    );

    switch (err.type) {
      case DioErrorType.connectionTimeout:
        return handler.resolve(
          ErrorResponse(
              requestOptions: err.requestOptions,
              statusMessage: "Connection timeout with server"),
        );
      case DioErrorType.receiveTimeout:
        return handler.resolve(
          ErrorResponse(
              requestOptions: err.requestOptions,
              statusMessage: "Response timeout with server"),
        );
      case DioErrorType.sendTimeout:
        return handler.resolve(
          ErrorResponse(
              requestOptions: err.requestOptions,
              statusMessage: "Send timeout with server"),
        );
      case DioErrorType.badResponse:
        if (kDebugMode) {
          print(err.response?.data);
        }
        return handler.resolve(
          FailureResponse(
            data: err.response?.data,
            requestOptions: err.requestOptions,
            headers: err.response?.headers,
            isRedirect: err.response?.isRedirect ?? false,
            statusCode: err.response?.statusCode,
            statusMessage: "Request Failed",
            redirects: err.response?.redirects ?? [],
            extra: err.response?.extra ?? {},
          ),
        );
      case DioErrorType.cancel:
        return handler.resolve(
          ErrorResponse(
              requestOptions: err.requestOptions,
              statusMessage: "Request is cancelled"),
        );
      default:
        return handler.resolve(
          ErrorResponse(
              requestOptions: err.requestOptions,
              statusMessage: "Something went wrong"),
        );
    }
  }
}
