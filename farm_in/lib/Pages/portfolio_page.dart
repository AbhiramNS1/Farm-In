import 'dart:convert';

import 'package:farm_in/Pages/detailed_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Models/Picks.dart';
import '../main.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<StatefulWidget> createState() => PortfolioState();
}

class PortfolioState extends State<Portfolio> {
  String totalGainpercentage = "0";
  String totalGainAmount = "0";
  String totalInvestedAmount = "0";
  bool isloading = true, nodata = false;
  List<Picks> picks = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    // try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwtToken');
    final url = Uri.parse('http://$server/picks/my_holdings');
    final res = await http.post(url, body: {"token": token});

    if (res.statusCode == 200) {
      List<dynamic> data = json.decode(res.body);

      int totalAmount = 0;
      double totalgain = 0;
      if (data.isNotEmpty) {
        for (int i = 0; i < data.length; i++) {
          picks.add(Picks.holdingsFromJson(data[i]));
          totalAmount += ((picks[i].price) * (picks[i].quantity ?? 1)) ?? 0;
        }
        totalInvestedAmount = totalAmount.toString();
      } else {
        nodata = true;
      }
      isloading = false;
      setState(() {});
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Unexpected error")));
      print("Error =================");
    }
    // } catch (e) {
    //   print(e);
    //   print("klwkm-----------------------");
    // }
    isloading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(17),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My holdings",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "${totalGainpercentage}% ▲",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total invested : $totalInvestedAmount ₹"),
                  Text("Total profit : $totalGainAmount ₹")
                ],
              )
            ],
          ),
        ),
        Flexible(
          child: isloading
              ? (Center(
                  child: (nodata)
                      ? Text("No Picks in your Holdings")
                      : CircularProgressIndicator()))
              : ListView.builder(
                  itemCount: picks.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailedScreen(
                              pick: picks[index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.5,
                            color: const Color.fromARGB(73, 0, 0, 0),
                          ),
                        ),
                        child: ListTile(
                          isThreeLine: true,
                          title: Text(picks[index].name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(picks[index].category ?? ""),
                              Text("Qty ${picks[index].quantity ?? 0}"),
                            ],
                          ),
                          trailing: Column(
                            children: [
                              Text("${picks[index].price} ₹"),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
