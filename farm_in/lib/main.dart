import 'package:farm_in/Pages/detailed_screen.dart';
import 'package:farm_in/Pages/farmers_profile.dart';
import 'package:farm_in/Pages/login_page.dart';
import 'package:flutter/material.dart';

import 'Pages/home_page.dart';

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
