import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogUtils {
  /// Method to show the general confirmation warning dialog
  static Future<dynamic> showNoInternetConnectionDialog({
    VoidCallback? onOkClick,
  }) async {
    Get.defaultDialog(
      title: "No Internet",
      titleStyle: Get.context?.textTheme.titleMedium,
      middleText: "Check your internet connection and try again!!",
      middleTextStyle: Get.context?.textTheme.bodyMedium,
      titlePadding: const EdgeInsets.only(top: 20.0),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      barrierDismissible: false,
      actions: [
        OutlinedButton(
          onPressed: () {
            onOkClick?.call();
            Get.back();
          },
          child: const Text("Ok"),
        ),
      ],
      radius: 20,
    );
  }
}
