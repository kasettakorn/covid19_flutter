import 'package:covid19/pages/Homepage.dart';
import 'package:covid19/pages/Index.dart';
import 'package:covid19/pages/Login.dart';
import 'package:covid19/pages/Register.dart';
import 'package:covid19/pages/Summary7days.dart';
import 'package:flutter/material.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid19 Tracker',
      home: Index(),

      theme: ThemeData(
        fontFamily: 'Prompt',

      ),
      routes: {
        '/chart': (context) => HomePage(),
        '/register': (context) => Register(),
        '/summary7days': (context) => SummaryState(),
      },
    );
  }
}
