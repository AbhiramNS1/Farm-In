import 'package:farm_in/Pages/login_page.dart';
import 'package:farm_in/Pages/verify_blockchain.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 179, 255, 181),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Padding(
            padding: EdgeInsets.only(top: 8.0, left: 12),
            child: Text(
              "Settings",
              style: TextStyle(fontSize: 30),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Color.fromARGB(209, 0, 0, 0), width: 0.3))),
          ),
          Button(context, "add a farmer", () {
            launchUrl(Uri.parse(
                "https://abhiramns1.github.io/Farm-In/server/public/"));
          }),
          Button(context, "verify blockchain assets", () {
            Navigator.push(context,
                MaterialPageRoute(builder: (ctx) => AssetVerificationPage()));
          }),
          Button(context, "help", () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Our support team will contact you soon")));
          }),
          Button(context, "report an issue", () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Our support team will contact you soon")));
          }),
          Button(context, "logout", () {
            SharedPreferences.getInstance().then((value) {
              value.setBool('isLoggedIn', false);
              value.setString('jwtToken', '');
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => LoginPage()));
            });
          })
        ]),
      ),
    );
  }
}

Widget Button(BuildContext context, String text, void Function() onClick) {
  return InkWell(
    child: Container(
      padding: EdgeInsets.all(14),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black, width: 0.4))),
      child: Text(
        text,
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
      ),
    ),
    onTap: onClick,
  );
}
