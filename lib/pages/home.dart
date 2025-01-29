import 'package:flutter/material.dart';
import 'package:shopsmart/widget/navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Navbar()
    );
  }
}