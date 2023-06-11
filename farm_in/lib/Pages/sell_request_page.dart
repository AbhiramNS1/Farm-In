import 'package:farm_in/Models/Picks.dart';
import 'package:farm_in/Widgets/quantity_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../main.dart';

class SellRequestPage extends StatefulWidget {
  final Picks pick;
  SellRequestPage({super.key, required this.pick});

  @override
  State<SellRequestPage> createState() => _SellRequestPageState();
}

class _SellRequestPageState extends State<SellRequestPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 12),
            child: Text(
              "Selling Request",
              style: TextStyle(fontSize: 30),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Color.fromARGB(209, 0, 0, 0), width: 0.3))),
          ),
          Box(
              context,
              "Adding sell request will not guarentee that the pick will be sold before the harvesting time.Some Intreseted investers may buy this pick."
              "If the Pick is not sold .The value corresponding to this pick at the harvest time will be credited to your bank accout ",
              () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Our support team will contact you soon")));
          }),
          SizedBox(
            height: 100,
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: QuantitySelector(
                onValueChanged: (val) {}, controller: _controller),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.5 - 80),
            child: ElevatedButton(
              child: Text("Make Sell Request"),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? token = prefs.getString('jwtToken');
                final url = Uri.parse('http://$server/picks/sell');
                final res = await http.post(url, body: {
                  "token": token,
                  'h_id': widget.pick.holdingsId.toString()
                });
                if (res.statusCode == 200) {
                  var jsondata = json.decode(res.body);
                }

                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Sell request recived ")));
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          )
        ]),
      ),
    );
  }
}

Widget Box(BuildContext context, String text, void Function() onClick) {
  return Container(
    padding: EdgeInsets.all(14),
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black, width: 0.4))),
    child: Text(
      text,
      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
    ),
  );
}
