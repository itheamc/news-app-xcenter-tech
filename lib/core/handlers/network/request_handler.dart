import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:news_app_xcenter_tech/core/api/endpoints.dart';

import '../session/session_handler.dart';
import 'network_interceptor.dart';
import 'network_response.dart';

///--------------------------------@mit------------------------------
/// RequestHandler class to handle network requests
class RequestHandler {
  static _defaultHeaders(contentType) => {
        HttpHeaders.contentTypeHeader: contentType,
      };

  ///-----------------------GET REQUEST-------------------------------
  /// Method to make get request
  static Future<NetworkResponse> get(
    String endpoint, {
    bool authenticate = true,
    Map<String, dynamic>? extraHeaders,
    String contentType = "application/json",
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    bool forceRefresh = false,
  }) async {
    SessionHandler session = Get.find();

    try {
      if (authenticate && !session.loggedIn) {
        throw Exception("Login to access the services!");
      }
      Map<String, dynamic> headers = {};
      if (authenticate) {
        headers = _defaultHeaders(contentType);
        headers.putIfAbsent("Authorization", () => "Token ${session.token}");
      }

      if (extraHeaders != null) {
        headers.addAll(extraHeaders);
      }

      var dio = Dio(
        BaseOptions(
          baseUrl: baseUrl ?? EndPoints.baseUrl,
          headers: headers,
          queryParameters: queryParameters,
        ),
      )..interceptors.add(NetworkInterceptor());

      var res = await dio.get(endpoint);
      return res.toNetworkResponse();
    } catch (e) {
      return NetworkResponse(
        ErrorResponse(
          requestOptions: RequestOptions(path: endpoint),
          statusMessage: e.toString(),
        ),
      );
    }
  }

  ///-----------------------POST REQUEST-------------------------------
  /// Method to make post request
  static Future<NetworkResponse> post(
    String endpoint, {
    bool authenticate = true,
    Map<String, dynamic>? extraHeaders,
    String contentType = "application/json",
    String? baseUrl,
    dynamic body,
    bool forceRefresh = false,
  }) async {
    SessionHandler session = Get.find();

    try {
      if (authenticate && !session.loggedIn) {
        throw Exception("Login to access the services!");
      }
      Map<String, dynamic> headers = {};
      if (authenticate) {
        headers = _defaultHeaders(contentType);
        headers.putIfAbsent("Authorization", () => "Token ${session.token}");
      }

      if (extraHeaders != null) {
        headers.addAll(extraHeaders);
      }

      var dio = Dio(
        BaseOptions(baseUrl: baseUrl ?? EndPoints.baseUrl, headers: headers),
      )..interceptors.add(NetworkInterceptor());

      var res = await dio.post(endpoint, data: body);
      return res.toNetworkResponse();
    } catch (e) {
      return NetworkResponse(
        ErrorResponse(
          requestOptions: RequestOptions(path: endpoint),
          statusMessage: e.toString(),
        ),
      );
    }
  }

  ///-----------------------PUT REQUEST-------------------------------
  /// Method to make put request
  static Future<NetworkResponse> put(
    String endpoint, {
    bool authenticate = true,
    Map<String, dynamic>? extraHeaders,
    String contentType = "application/json",
    String? baseUrl,
    dynamic body,
    bool forceRefresh = false,
  }) async {
    SessionHandler session = Get.find();

    try {
      if (authenticate && !session.loggedIn) {
        throw Exception("Login to access the services!");
      }
      Map<String, dynamic> headers = {};
      if (authenticate) {
        headers = _defaultHeaders(contentType);
        headers.putIfAbsent("Authorization", () => "Token ${session.token}");
      }

      if (extraHeaders != null) {
        headers.addAll(extraHeaders);
      }

      var dio = Dio(
        BaseOptions(baseUrl: baseUrl ?? EndPoints.baseUrl, headers: headers),
      )..interceptors.add(NetworkInterceptor());

      var res = await dio.put(endpoint, data: body);
      return res.toNetworkResponse();
    } catch (e) {
      return NetworkResponse(
        ErrorResponse(
          requestOptions: RequestOptions(path: endpoint),
          statusMessage: e.toString(),
        ),
      );
    }
  }

  ///-----------------------DELETE REQUEST-------------------------------
  /// Method to make put request
  static Future<NetworkResponse> delete(
    String endpoint, {
    bool authenticate = true,
    Map<String, dynamic>? extraHeaders,
    String contentType = "application/json",
    String? baseUrl,
    bool forceRefresh = false,
  }) async {
    SessionHandler session = Get.find();

    try {
      if (authenticate && !session.loggedIn) {
        throw Exception("Login to access the services!");
      }
      Map<String, dynamic> headers = {};
      if (authenticate) {
        headers = _defaultHeaders(contentType);
        headers.putIfAbsent("Authorization", () => "Token ${session.token}");
      }

      if (extraHeaders != null) {
        headers.addAll(extraHeaders);
      }

      var dio = Dio(
        BaseOptions(baseUrl: baseUrl ?? EndPoints.baseUrl, headers: headers),
      )..interceptors.add(NetworkInterceptor());

      var res = await dio.delete(endpoint);
      return res.toNetworkResponse();
    } catch (e) {
      return NetworkResponse(
        ErrorResponse(
          requestOptions: RequestOptions(path: endpoint),
          statusMessage: e.toString(),
        ),
      );
    }
  }
}
