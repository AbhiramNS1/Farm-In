import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class AssetVerificationPage extends StatefulWidget {
  AssetVerificationPage();

  @override
  State<StatefulWidget> createState() => _AssetVerifiState();
}

class _AssetVerifiState extends State<AssetVerificationPage> {
  final List<Asset> assets = [];

  void getAssets() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('jwtToken');
      final url = Uri.parse('http://$server/picks/my_holdings');
      final res = await http.post(url, body: {"token": token});

      if (res.statusCode == 200) {
        List<dynamic> data = json.decode(res.body);
        for (int i = 0; i < data.length; i++) {
          assets.add(Asset(
            name: data[i]['name'],
            quantity: data[i]['qty'],
            buyingPrice: data[i]['todays_price'],
          ));
        }
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getAssets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 58, 187, 62),
      appBar: AppBar(
        title: const Text('Asset Verification'),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: assets.length,
            itemBuilder: (BuildContext context, int index) {
              Asset asset = assets[index];
              return ListTile(
                leading: Icon(Icons.attach_money),
                title: Text(asset.name, style: TextStyle(fontSize: 20)),
                subtitle: Text(
                  'Quantity: ${asset.quantity} Buying price:${asset.buyingPrice}',
                  style: TextStyle(fontSize: 18),
                ),
              );
            },
          ),
          Positioned(
              bottom: 50,
              right: 50,
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Ok"))
                            ],
                            content: const Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.verified,
                                    color: Colors.green, size: 100),
                                Text("All assets are verified"),
                              ],
                            ),
                          ));
                },
                child: Container(
                  decoration:
                      const BoxDecoration(color: Colors.amber, boxShadow: [
                    BoxShadow(offset: Offset(0, 3), color: Color(0xFF000000))
                  ]),
                  padding: const EdgeInsets.all(10),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [Icon(Icons.verified), Text("Verify")],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

class Asset {
  final String name;
  final int quantity;
  final int buyingPrice;
  Asset(
      {required this.name, required this.quantity, required this.buyingPrice});
}
