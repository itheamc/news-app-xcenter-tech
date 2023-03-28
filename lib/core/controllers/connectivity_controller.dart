import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../../utils/dialog_utils.dart';
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
    await Future.delayed(
        const Duration(milliseconds: 3500), _showNoInternetDialog);
  }

  /// Function to update internet status
  Future<void> _updateInternetStatus(ConnectivityResult result) async {
    final status = await _getStatus(result);
    if (_hasInternet.value != status) {
      _hasInternet.value = status;
      _showNoInternetDialog();
    }
  }

  /// Function to get internet status from the connectivity result
  Future<bool> _getStatus(ConnectivityResult result) async {
    final activeConnection = await _handler.hasActiveConnection();

    return result != ConnectivityResult.none && activeConnection;
  }

  /// Private method to show the no internet connection dialog
  Future<void> _showNoInternetDialog() async {
    // No internet connectivity dialog
    if (!hasInternet) {
      await DialogUtils.showNoInternetConnectionDialog();
    }
  }

  /// Cancelling the subscription on close
  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
