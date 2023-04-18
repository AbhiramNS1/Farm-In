import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _pcontroller = TextEditingController();
  final _ucontroller = TextEditingController();
  var isPasswordVisible = false;
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
                      child: Icon(Icons.contact_emergency),
                    ),
                    Expanded(
                        child: TextField(
                      controller: _ucontroller,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "Username"),
                    ))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(228, 251, 253, 255),
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
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 20),
                  ),
                )),
          )
        ])),
      ),
    );
  }
}
