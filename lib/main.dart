import 'package:flutter/material.dart';
import 'package:shopsmart/pages/home.dart';
import 'package:shopsmart/pages/login.dart';
import 'package:shopsmart/pages/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      debugShowCheckedModeBanner: false ,
      home:  LoginPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}

