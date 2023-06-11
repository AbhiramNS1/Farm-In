import 'dart:convert';
import 'dart:io';
import 'package:farm_in/Pages/home_page.dart';
import 'package:farm_in/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Future<void> _uploadFile() async {
    if (_selectedFile == null) {
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 60,
                  ),
                  content: const Text("Please upload your pan card"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Ok"))
                  ],
                ));
      }
      return;
    }

    // Create a multipart request
    var request =
        http.MultipartRequest('POST', Uri.parse("http://$server/users/signup"));

    // Add the file to the request
    var fileStream = http.ByteStream(_selectedFile!.openRead());
    var fileLength = await _selectedFile!.length();
    var multipartFile = http.MultipartFile('file', fileStream, fileLength,
        filename: _selectedFile!.path.split('/').last);
    request.files.add(multipartFile);
    request.fields['name'] = _name;
    request.fields['address'] = _address;
    request.fields['email'] = _email;
    request.fields['password'] = _password;
    request.fields['adhar'] = _adhar;

    // Send the request
    var response = await request.send();

    // Check the response status code
    if (response.statusCode == 200) {
      if (context.mounted) {
        Navigator.of(context).pop();
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Icon(
                    Icons.check_circle_outline_outlined,
                    color: Color.fromARGB(255, 105, 224, 7),
                    size: 70,
                  ),
                  content: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Welcome to FarmIn."),
                      Text(
                          "You are niw part of the farmIn investment family.Invest in farmers and earn decent returns and grow with India")
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () async {
                          response.stream
                              .transform(utf8
                                  .decoder) // Decode the stream using UTF-8 decoder
                              .transform(
                                  json.decoder) // Decode the stream as JSON
                              .listen((dynamic data) async {
                            print("Response decoding ....");
                            print(data);
                            data = data["result"];
                            if (data["token"] != null) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setString('jwtToken', data["token"]);
                              await prefs.setBool('isLoggedIn', true);
                              print(data);
                              await prefs.setInt('myid', data["id"]);
                              myid = data["id"];
                              if (context.mounted) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (ctx) => const HomePage()));
                              } else {
                                print("context not mounted");
                              }
                            } else
                              print("No token found");
                          });
                        },
                        child: Text("Ok"))
                  ],
                ));
      }
    } else {
      print(
          'Error uploading file${response.statusCode} ${response.reasonPhrase}');
    }
  }

  final _formKey = GlobalKey<FormState>();
  String _name = "", _address = "", _email = "", _password = "", _adhar = "";
  File? _selectedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/app/icon.png"),
                ),
                const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 30),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Address',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _address = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Adhar number',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Adhar number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _adhar = value!;
                  },
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedFile?.path.split("/").last ??
                            "No file selected",
                        overflow: TextOverflow.fade,
                      ),
                      TextButton(
                        onPressed: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();
                          if (result != null &&
                              result.files.single.path != null) {
                            setState(() {
                              _selectedFile = File(result.files.single.path!);
                            });
                          }
                        },
                        child: Text('Upload'),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                                  title: const Row(
                                    children: [
                                      Icon(
                                        Icons.warning,
                                        color: Colors.amber,
                                      ),
                                      Text(' Warning'),
                                    ],
                                  ),
                                  content: const Text(
                                      "Investment in farmIn are subjected to farming risk .Please read the related documents carefully before investing."),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          _formKey.currentState?.save();
                                          _uploadFile();
                                          return;
                                        },
                                        child: Text("i understand"))
                                  ],
                                ));
                      }
                    },
                    child: Text("Sign up"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
