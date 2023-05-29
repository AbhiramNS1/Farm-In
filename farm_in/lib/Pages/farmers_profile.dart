import 'dart:ui';

import 'package:farm_in/Pages/buying_page.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FarmersProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FarmersProfileState();
}

class _FarmersProfileState extends State<FarmersProfile> {
  static const int avatharSize = 140;
  String text = "follow";
  int followers = 100;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 120 + avatharSize / 2,
                          child: Stack(clipBehavior: Clip.none, children: [
                            Image.asset(
                              'assets/images/items/bg.png',
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                            ),
                            Positioned(
                                top: 50,
                                left: MediaQuery.of(context).size.width / 2 -
                                    avatharSize / 2,
                                child: Avatar(
                                  image: "assets/images/items/farmer.png",
                                  width: avatharSize.toDouble(),
                                ))
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 13, right: 13),
                          child: Column(
                            children: [
                              const Text(
                                "Raju patel",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 26,
                                ),
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 15),
                                  child: Text(
                                    "I am a farmer who lives in a small village in Maharashtra. ",
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center,
                                  )),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                      width: 130,
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Color.fromARGB(
                                                          255, 17, 191, 104))),
                                          onPressed: () {
                                            setState(() {
                                              if (text == "follow") {
                                                text = "following";
                                                followers++;
                                              } else {
                                                text = "follow";
                                                followers--;
                                              }
                                            });
                                          },
                                          child: Text(
                                            text,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17),
                                          )))
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 12),
                                child: Text(
                                  "$followers followers",
                                  style: TextStyle(fontSize: 16, shadows: [
                                    Shadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.45),
                                        blurRadius: 6,
                                        offset: Offset(0, 3))
                                  ]),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 145, 255, 222),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.2),
                                        blurRadius: 2,
                                        offset: Offset(0, 4),
                                      )
                                    ]),
                                child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "About Raju",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.start,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Text(
                                          "Raju inherited his love for farming from his father, who was a successful farmer himself."
                                          " Raju always knew that he wanted to continue his family's legacy"
                                          " and decided to focus on growing carrots on his farm."
                                          "Raju uses traditional farming methods, and he takes great"
                                          " care to ensure that his crops are grown without the use of harmful chemicals."
                                          " He uses natural fertilizers and pesticides to protect his plants from pests and diseases."
                                          " Raju's hard work and dedication pay off, and he is able to harvest a bountiful crop of carrots every year.",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                        SfCartesianChart(
                          margin: EdgeInsets.only(top: 30, left: 10),
                          primaryXAxis: CategoryAxis(),
                          // Chart title
                          title: ChartTitle(
                              text: 'Profit Analysis of Patels Farming'),
                          // Enable legend
                          legend: Legend(isVisible: true),
                          // Enable tooltip
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<Data, int>>[
                            LineSeries<Data, int>(
                                dataSource: data,
                                xValueMapper: (Data sales, _) => sales.x,
                                yValueMapper: (Data sales, _) => sales.y,
                                name: 'Profit',
                                // Enable data label
                                dataLabelSettings:
                                    DataLabelSettings(isVisible: true))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            "Profit Ananlysis based on Crops ",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                            child: chartToRun())
                      ],
                    )))));
  }
}

class Avatar extends StatelessWidget {
  final double width;
  final Border? border;
  final String image;
  const Avatar({super.key, this.width = 140, this.border, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: width,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: border ??
                Border.all(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  width: 3,
                ),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.2),
                blurRadius: 2,
                offset: Offset(0, 4),
              )
            ]),
        child: ClipOval(
          child: Image.asset(image, fit: BoxFit.cover),
        ));
  }
}

class Data {
  int x;
  int y;
  Data(this.x, this.y);
}

final data = [
  Data(2010, 3),
  Data(2013, 4),
  Data(2016, 5),
  Data(2020, 3),
  Data(2023, 6),
];
