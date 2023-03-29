import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../handlers/connectivity/connectivity_handler.dart';

class ConnectivityController extends GetxController {
  final _hasInternet = true.obs;
  late ConnectivityHandler _handler;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  bool get hasInternet => _hasInternet.value;

  /// Initializing Late Init Var on Initialization
  @override
  void onInit() {
    _handler = ConnectivityHandler.initialize();
    _connectivitySubscription =
        _handler.onConnectivityChanged.listen(_updateInternetStatus);
    super.onInit();
  }

  @override
  void onReady() {
    _initHasInternet();
  }

  /// Init the _hasInternet
  Future<void> _initHasInternet() async {
    _hasInternet.value = await _handler.hasConnection();
  }

  /// Function to update internet status
  Future<void> _updateInternetStatus(ConnectivityResult result) async {
    final status = await _getStatus(result);
    if (_hasInternet.value != status) {
      _hasInternet.value = status;
    }
  }

  /// Function to get internet status from the connectivity result
  Future<bool> _getStatus(ConnectivityResult result) async {
    final activeConnection = await _handler.hasActiveConnection();

    return result != ConnectivityResult.none && activeConnection;
  }

  /// Cancelling the subscription on close
  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
