import 'package:farm_in/Models/Picks.dart';
import 'package:farm_in/Models/realtime.dart';
import 'package:farm_in/Pages/farmers_profile.dart';
import 'package:farm_in/Pages/sell_request_page.dart';
import 'package:farm_in/Widgets/time_line.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../main.dart';

class DetailedScreen extends StatefulWidget {
  final Picks pick;
  const DetailedScreen({super.key, required this.pick});

  @override
  State<StatefulWidget> createState() => DetailedState();
}

class DetailedState extends State<DetailedScreen> {
  int avgTemp = 0;
  int avgPre = 0;
  int avgHum = 0;
  int avgMoist = 0;
  int windSpeed = 0;

  void setIndicators() {}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: Image.asset(
            "assets/app/icon.png",
            width: 50,
          ),
          title: Text("${widget.pick.name}(${widget.pick.symbol})"),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Summary'),
              Tab(text: 'indicators'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SummaryView(
              pick: widget.pick,
            ),
            Indicators(
              avgTemp,
              avgPre,
              avgHum,
              avgMoist,
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryView extends StatefulWidget {
  final Picks pick;
  const SummaryView({super.key, required this.pick});

  @override
  State<StatefulWidget> createState() => StateSummary();
}

enum SummaryState { loading, finished, failed }

class StateSummary extends State<SummaryView> {
  SummaryState mystate = SummaryState.loading;
  int totalInvestedQty = 0;
  int totalInvestedAmount = 0;
  int totalProfit = 0;

  String farmer = "";
  int totalArea = 0;
  String address = "";
  int totalCropQtyAvailable = 0;
  int totalAmountRequested = 0;
  String latitude = "0";
  String longitude = "0";
  List<Picks> similarPicks = [];

  Widget? analyse() {
    if (mystate == SummaryState.loading) {
      (() async {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? token = prefs.getString('jwtToken');
          final url = Uri.parse('http://$server/picks/summary');
          final res = await http.post(url,
              body: {"token": token, 'pick_id': widget.pick.id.toString()});
          if (res.statusCode == 200) {
            var jsondata = json.decode(res.body);
            print(jsondata);
            for (var i in jsondata?[1]) {
              similarPicks.add(Picks.holdingsFromJson(i));
            }
            Map<String, dynamic> data = jsondata?[0] ?? {};
            if (data != null) {
              setState(() {
                mystate = SummaryState.finished;
                farmer = data["farmer"];
                totalArea = data["area"];
                address = data["address"];
                totalCropQtyAvailable = data["total_qty"];
                totalAmountRequested = data["total_amount"];
                latitude = data["latitude"];
                longitude = data["longitude"];
              });
            }
          } else {
            setState(() {
              mystate = SummaryState.failed;
            });
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Invalid request')));
          }
        } catch (e) {
          print(e);
          setState(() {
            mystate = SummaryState.failed;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unable to reach server')),
          );
        }
      })();

      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (mystate == SummaryState.failed) {
      return const Center(
        child: Text("Failed to load Summary view"),
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return analyse() ??
        SingleChildScrollView(
          child: Center(
              child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 167, 255, 199),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(2, 2),
                          color: Color.fromARGB(24, 0, 0, 0),
                          blurRadius: 2),
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Details ",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    Text(
                        "${widget.pick.name} farming is a highly profitable and risk free investment choice."
                        "$farmer, a dedicated farmer from a village ."
                        " He has been farming for over a decade and has mastered the art of cultivating ${widget.pick.name}."),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FarmersProfile()));
                          },
                          child: const Text("Visit farmer's profile")),
                    )
                  ],
                ),
              ),
              const Text(
                "Your Investment",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              InfoRow("Total Quantity  :  ", widget.pick.quantity.toString()),
              InfoRow("Total Amount Invested  :  ",
                  "${widget.pick.totalInvested} ₹"),
              InfoRow("Total Profit  :  ", "${widget.pick.totalProfit} ₹"),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                padding: EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 167, 255, 199),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(2, 2),
                          color: Color.fromARGB(24, 0, 0, 0),
                          blurRadius: 2),
                    ]),
                child: Column(
                  children: [
                    const Text(
                      "Crop's Statistics",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    InfoRow("Total Quantity Avilable :  ",
                        totalCropQtyAvailable.toString()),
                    InfoRow("Total Amount requested  :  ",
                        "$totalAmountRequested₹"),
                    InfoRow("Total Area  :  ", "$totalArea Sqkm"),
                    InfoRow("Location  :  ", address),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green)),
                        onPressed: () async {
                          final url = Uri(
                            scheme: 'https',
                            host: 'www.google.com',
                            path: '/maps/search/',
                            queryParameters: {
                              'api': '1',
                              'query': '$latitude,$longitude'
                            },
                          );
                          await launchUrl(url);
                        },
                        child: const Text("Show location in GMap"))
                  ],
                ),
              ),
              InfoRow("Crop's Timeline", ""),
              Container(
                  margin: EdgeInsets.all(13), child: CropTimeLineWidget()),
              SizedBox(
                width: 200,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (cxt) => SellRequestPage()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.sell,
                          color: Colors.red,
                        ),
                        Text(
                          "Make a sell request",
                          style: TextStyle(color: Colors.red),
                        )
                      ],
                    )),
              ),
              InfoRow("Other Similar picks", ""),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(similarPicks.length,
                      (index) => ScrollCard(pick: similarPicks[index])),
                ),
              )
            ],
          )),
        );
  }
}

Widget InfoRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Wrap(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 17,
          ),
        )
      ],
    ),
  );
}

class RealtimeMonitor extends StatefulWidget {
  const RealtimeMonitor({super.key});

  @override
  State<StatefulWidget> createState() => RealTimeState();
}

class RealTimeState extends State<RealtimeMonitor> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 400,
        child: GridView.count(
          crossAxisCount: 2,
          children: RealTimeValues.values
              .map((e) => InfoCard(title: e.attribute, value: e.value))
              .toList(),
        ));
  }
}

class ScrollCard extends StatelessWidget {
  final Picks pick;
  const ScrollCard({super.key, required this.pick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 250,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 188, 255, 218),
            boxShadow: [
              BoxShadow(color: Color.fromARGB(55, 0, 0, 0), blurRadius: 5)
            ],
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text(
            "${pick.name}",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "${pick.todaysChange}% ▲",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 26),
            ),
          ),
          Text(
            "${pick.name} cultivation in Bihar by Patel Ravi.Moderate profit and low risk investment",
          )
        ]),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  const InfoCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.only(top: 14),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 167, 255, 199),
          boxShadow: [
            BoxShadow(blurRadius: 2, color: Color.fromARGB(63, 0, 0, 0))
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 19),
          ),
          Flexible(
              child: Center(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
            ),
          ))
        ],
      ),
    );
  }
}

class Indicators extends StatelessWidget {
  const Indicators(temp, pre, hum, moist, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
                child: Text(
              "Realtime monitoring",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            )),
          ),
          const RealtimeMonitor(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
                child: Text(
              "Climatic condition",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            )),
          ),
          Text("(specific to the farmland location)"),
          Column(
            children: [
              OptionsCard(
                  "Temperature",
                  " Annual average temperature is around 25°C (77°F)."
                      " Hottest months are May and June, with average daily temperatures"
                      " ranging from 35°C to 40°C (95°F to 104°F). Coldest months are December"
                      " and January, with average daily temperatures ranging from 7°C to 20°C (45°F to 68°F)."),
              OptionsCard(
                  "Humidity",
                  " During monsoon season (June to September), average relative humidity "
                      "(RH) is around 70% to 80%. During the rest of the year, it is around 30% to 50%."),
              OptionsCard(
                  "Precipitation",
                  " Semi-arid climate with a monsoon season from June to September. "
                      "Average annual precipitation of around 650mm (25 inches)."),
              OptionsCard(
                  "Wind speed", " Average wind speed is around 7 km/h."),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                      onPressed: () {},
                      child: Text("Learn about carrot cultivation"))),
            ],
          )
        ],
      ),
    );
  }
}

class OptionsCard extends StatelessWidget {
  final String? value;
  final String? heading;
  const OptionsCard(this.heading, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 167, 255, 199),
          boxShadow: [
            BoxShadow(blurRadius: 2, color: Color.fromARGB(63, 0, 0, 0))
          ]),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Text(
            heading ?? "",
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          Text(value ?? ""),
        ],
      ),
    );
  }
}
