import 'package:flutter/material.dart';
import 'package:forestfire_frontend/screens/product/product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "FireWatch",
      theme: ThemeData(
        fontFamily: "Google Sans",
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.black,
            fontSize: 200,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        // primaryColor: primaryColor,
        // accentColor: secondaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Product(),
    );
  }
}
