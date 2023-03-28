import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

import '../../../utils/log_utils.dart';

/// Connectivity Handler
class ConnectivityHandler {
  Connectivity? _connectivity;

  /// private Constructor
  ConnectivityHandler._();

  /// Static Function to initialize the Connectivity Handler
  factory ConnectivityHandler.initialize() {
    ConnectivityHandler handler = ConnectivityHandler._();
    handler._connectivity = Connectivity();
    return handler;
  }

  /// Checking Internet Connectivity
  Future<bool> hasConnection() async {
    try {
      ConnectivityResult result =
          await (_connectivity ?? Connectivity()).checkConnectivity();

      final activeConnection = await hasActiveConnection();

      return (result == ConnectivityResult.wifi ||
              result == ConnectivityResult.mobile ||
              result == ConnectivityResult.ethernet ||
              result == ConnectivityResult.bluetooth) &&
          activeConnection;
    } on PlatformException catch (e) {
      LogUtil.debug(
        message: e.message ?? e.code,
        functionName: 'hasConnection',
        className: runtimeType.toString(),
      );
      return false;
    }
  }

  /// Listening the connectivity change status
  Stream<ConnectivityResult> get onConnectivityChanged {
    return (_connectivity ?? Connectivity()).onConnectivityChanged;
  }

  /// Method to check if has active internet connection
  Future<bool> hasActiveConnection() async {
    bool connected = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connected = true;
      }
    } on SocketException catch (e) {
      LogUtil.debug(
        message: e.toString(),
        functionName: 'hasActiveConnection',
        className: runtimeType.toString(),
      );
    }
    return connected;
  }
}
