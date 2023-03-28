import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoInternet extends StatelessWidget {
  final VoidCallback? onReload;

  const NoInternet({Key? key, this.onReload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "No active internet connection!!",
              style: context.textTheme.headlineSmall,
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
              child: const Text("Reload"),
            ),
          ],
        ),
      ),
    );
  }
}
