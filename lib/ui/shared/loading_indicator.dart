import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_xcenter_tech/ui/shared/spinning_lines.dart';

class LoadingIndicator extends StatelessWidget {
  final String? label;
  final double size;
  final int lineCount;
  final double lineWidth;
  final Color? color;
  final Duration? duration;

  const LoadingIndicator({
    Key? key,
    this.label,
    this.size = 50.0,
    this.lineCount = 1,
    this.lineWidth = 4.0,
    this.color,
    this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: label != null && label!.isNotEmpty
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _spinningLines(context.theme),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  "${label?.tr}",
                  style: context.textTheme.bodySmall,
                )
              ],
            )
          : _spinningLines(context.theme),
    );
  }

  /// Spinner
  Widget _spinningLines(ThemeData theme) => SpinningLines(
        color: color ?? theme.colorScheme.primary,
        itemCount: lineCount,
        lineWidth: lineWidth,
        size: size,
        duration: duration ?? const Duration(milliseconds: 1500),
      );
}
