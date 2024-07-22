import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewScreenController extends GetxController {
  InAppWebViewController? controller;
  void onWebViewCreated(InAppWebViewController webViewController) async {
    controller = webViewController;

    // Adds a JavaScript handler for opening URLs externally or in the web view.
    controller?.addJavaScriptHandler(
      handlerName: 'openAndroid',
      callback: (args) async {
        String? url;
        if(args.isNotEmpty){
           url = args[0];
          _launchUrl(url??"");


        }
        ///Do something
        print('zzz  Logs for openAndroid handler $url ');

      },
    );
    // Adds a JavaScript handler for tracking events within the web view.
    controller?.addJavaScriptHandler(
      handlerName: 'eventTracker',
      callback: (args) {
        if (args.length > 1 && args[0].isNotEmpty) {
          String eventType = args[0];
          //String eventValue = args[1];
          if (eventType == 'register') {
            print("register success");
          } else if (eventType == 'login') {
            print("login success");
          }
        }
      },
    );

    ///Executes JavaScript code to trigger the 'openAndroid' handler.
    // controller?.evaluateJavascript(
    //   source:
    //   """window.flutter_inappwebview.callHandler('openAndroid', 'https://www.google.com','2');""",
    // );
  }

  ///launch url function to open externally
  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      print("Launch success");
      await launchUrl(Uri.parse(url), mode: LaunchMode.inAppBrowserView);
    } else {
      throw 'Could not launch $url';
    }
  }
}
