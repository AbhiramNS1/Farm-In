import 'package:farm_in/Pages/home_page.dart';
import 'package:farm_in/Pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var server = "192.168.31.100:5000";
var updateBlockChain = true;
int? myid = null;

void main() {
  runApp(FarmIn());
}

class FarmIn extends StatelessWidget {
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    myid = prefs.getInt('myid');
    print(myid);
    // await prefs.setBool('isLoggedIn', false);
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: FutureBuilder<bool>(
      future: isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data!) {
            return HomePage();
          } else {
            return LoginPage();
          }
        } else
          return Center(child: CircularProgressIndicator());
      },
    ));
  }
}
