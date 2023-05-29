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
                  Text("Totoal invested : ${totalInvestedAmount} ₹"),
                  Text("Total profit :${totalGainAmount} ₹")
                ],
              )
            ],
          ),
        ),
        Flexible(
            child: FutureBuilder<List<Picks>>(
          future: (() async {
            try {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? token = prefs.getString('jwtToken');
              final url = Uri.parse('http://$server/picks/my_holdings');
              final res = await http.post(url, body: {"token": token});

              if (res.statusCode == 200) {
                List<dynamic> data = json.decode(res.body);
                List<Picks> list = [];
                int totalAmount = 0;
                for (int i = 0; i < data.length; i++) {
                  list.add(Picks.holdingsFromJson(data[i]));
                  totalAmount += list[i].totalInvested;
                }
                totalInvestedAmount = totalAmount.toString();

                return list;
              } else {
                print("errrorrr=================");
              }
            } catch (e) {
              print(e);
              print("klwkm-----------------------");
            }

            return [] as List<Picks>;
          })(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailedScreen(
                                    pick: snapshot.data![index])));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.5,
                                color: const Color.fromARGB(73, 0, 0, 0))),
                        child: ListTile(
                          isThreeLine: true,
                          title: Text(snapshot.data![index].symbol),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.data![index].symbol),
                              Text(
                                  "Qty ${snapshot.data![index].quantity ?? 0}"),
                            ],
                          ),
                          trailing: Column(children: [
                            Text("${snapshot.data![index].todaysPrice} ₹"),
                            Text("${snapshot.data![index].todaysChange}% ▲")
                          ]),
                        ),
                      ),
                    );
                  });
            } else {
              return const CircularProgressIndicator();
            }
          },
        ))
      ],
    );
  }
}
