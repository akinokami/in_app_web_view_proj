import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/instance_manager.dart';
import '../controller/web_view_screen_controller.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({super.key, required this.baseUrl});
final String baseUrl ;

  @override
  Widget build(BuildContext context) {
final webScreenController = Get.put(WebViewScreenController());
    return Scaffold(
      body: InAppWebView(
        // Initial URL request for the web view.
        initialUrlRequest: URLRequest(
          url: Uri.parse(baseUrl),
        ),

        // Initial options for the web view, configuring platform-specific and cross-platform settings.
        initialOptions: InAppWebViewGroupOptions(
          android: AndroidInAppWebViewOptions(
            cacheMode: AndroidCacheMode.LOAD_DEFAULT,
            useHybridComposition: true,
            useShouldInterceptRequest: true,
          ),
          crossPlatform: InAppWebViewOptions(
            cacheEnabled: true,
            useShouldOverrideUrlLoading: true,
            javaScriptEnabled: true,
          ),
        ),
        // javascriptChannels: <JavascriptChannel>{
        //   // Set up a JavaScript channel that the web view can use to communicate with the Flutter app.
        //   JavascriptChannel(
        //     name: 'Print',
        //     onMessageReceived: (JavascriptMessage message) {
        //       print('Message from JavaScript: ${message.message}');
        //     },
        //   ),
        // },
        // Callback for when the web view is created, setting up JavaScript handlers.
        onWebViewCreated: webScreenController.onWebViewCreated,

      ),
    );

  }
}
