import 'package:captioner/main_page.dart';
import 'package:flutter/material.dart';
import 'main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Raleway',
      ),
      home: Mainpage(),
      debugShowCheckedModeBanner: false,
    );
  }

}