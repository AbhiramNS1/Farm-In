import 'package:farm_in/Pages/home_page.dart';
import 'package:farm_in/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _pcontroller = TextEditingController(text: "");
  final _ucontroller = TextEditingController(text: "");
  var isPasswordVisible = false;
  var isLoading = false;
  void signIn(Object payload, BuildContext context) async {
    try {
      setState(() {
        isLoading = true;
      });

      final url = Uri.parse('http://$server/users/login');
      final res = await http.post(url, body: payload);

      if (res.statusCode == 200) {
        Map<String, dynamic> data = json.decode(res.body);
        if (data["token"] != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('jwtToken', data["token"]);
          await prefs.setBool('isLoggedIn', true);
          print(data);
          await prefs.setInt('myid', data["id"]);
          myid = data["id"];
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Invalid request')));
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to reach server')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 107, 191, 110),
      body: SingleChildScrollView(
        child: Center(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 80),
            child: Column(
              children: [
                Image.asset(
                  "assets/app/icon.png",
                  width: 200,
                  height: 200,
                ),
                const Text(
                  "Farm In",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 40,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(228, 251, 253, 255),
                ),
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.account_circle_outlined),
                    ),
                    Expanded(
                        child: TextField(
                      controller: _ucontroller,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "Email"),
                    ))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromARGB(228, 251, 253, 255),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.lock),
                    ),
                    Expanded(
                        child: TextField(
                      obscureText: !isPasswordVisible,
                      controller: _pcontroller,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "Password"),
                    )),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      child: isPasswordVisible
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
                onPressed: () {
                  signIn({
                    "username": _ucontroller.text,
                    "password": _pcontroller.text
                  }, context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 20),
                  ),
                )),
          ),
          if (isLoading)
            Container(
              width: 300,
              height: 300,
              child: Center(child: CircularProgressIndicator()),
            )
        ])),
      ),
    );
  }
}
