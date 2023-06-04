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
              "Adding sell request will not guarentee that the pick will be sold before the harvesting time.Some Intreseted investers may by this pick."
              "If the Pick is not sold .The value corresponding to this pick at the harvest time will be credited to your bacnk accout ",
              () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Our support team will contact you soon")));
          }),
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.5 - 80),
            child: ElevatedButton(
              child: Text("Make Sell Request"),
              onPressed: () {
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
