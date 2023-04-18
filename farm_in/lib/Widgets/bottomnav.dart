import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NavState();
}

class NavState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      fixedColor: Colors.green,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle), label: "holdings")
      ],
    );
  }
}
