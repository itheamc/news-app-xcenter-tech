import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app_xcenter_tech/core/handlers/session/session_handler.dart';
import 'package:news_app_xcenter_tech/core/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _waitAndNavigate2Home();
    super.initState();
  }

  /// Method to wait for few second and navigate to home screen
  void _waitAndNavigate2Home() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      // Here we are going to store the api token to the session handler
      // Since we are not handling user login in this app

      // Storing token to the session handler
      final sessionHandler = Get.find<SessionHandler>();
      sessionHandler
          .storeToken("62dd8b7808664b94ab5ad1e718069ded")
          .then((value) {
        // Navigate top news page
        context.go(Routes.news);

        // if (context.canPop()) {
        //   context.pop();
        // }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                "News App",
                style: context.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Code with ❤ for ",
                    style: context.textTheme.bodySmall,
                  ),
                  TextSpan(
                    text: "Xcenter Technologies",
                    style: context.textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
