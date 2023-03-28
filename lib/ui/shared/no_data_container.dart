import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoDataContainer extends StatelessWidget {
  final String? message;
  final VoidCallback? onReload;

  const NoDataContainer({
    Key? key,
    this.message,
    this.onReload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message ?? "No data found!!",
            style: context.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 8.0,
          ),
          OutlinedButton(
            onPressed: onReload,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 36.0,
              ),
            ),
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}
