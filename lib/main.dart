import 'package:flutter/material.dart';
import 'pages/login/login.dart';

void main() {
  runApp(const QQApp());
}

class QQApp extends StatelessWidget {
  const QQApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'QQ',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Scaffold(body: Login()));
  }
}
