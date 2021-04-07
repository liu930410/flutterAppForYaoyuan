import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'Screens/Home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static var dio = Dio();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
