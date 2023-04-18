import 'package:farm_in/Pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(FarmIn());
}

class FarmIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}
