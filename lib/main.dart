import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_web_view_proj/screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      debugShowCheckedModeBanner: false, // Removes the debug banner.
      theme: ThemeData(
        primarySwatch: Colors.blue, // Sets the primary color of the app.
      ),
      home:const HomeScreen(), // Sets the home page of the app.
    );
  }
}


