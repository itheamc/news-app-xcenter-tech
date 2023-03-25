import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorScreen extends StatefulWidget {
  final Exception? err;

  const ErrorScreen({Key? key, this.err}) : super(key: key);

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page Not Found"),
        centerTitle: true,
      ),
      body: _ui4Error(),
    );
  }

  /// Common ui for page not found or error screen
  Widget _ui4Error() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Text(
          widget.err.toString(),
          style: context.theme.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
