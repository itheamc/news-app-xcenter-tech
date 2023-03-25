import 'package:flutter/foundation.dart';

class LogUtil {
  static void debug({
    required String message,
    String? functionName,
    String? className,
  }) {
    if (kDebugMode) {
      print(
          "[${className != null ? '$className: ' : ''}${functionName ?? ''}] ---> $message");
    }
  }
}
