import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SellRequestPage extends StatefulWidget {
  const SellRequestPage({super.key});

  @override
  State<SellRequestPage> createState() => _SellRequestPageState();
}

class _SellRequestPageState extends State<SellRequestPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [Text("Sell request ")]),
      ),
    );
  }
}
