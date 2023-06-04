import 'package:farm_in/Models/picks.dart';
import 'package:farm_in/Widgets/success.dart';
import 'package:farm_in/Widgets/time_line.dart';
import 'package:farm_in/blockchain/web3main.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:http/http.dart' as http;
import 'package:farm_in/Widgets/appbar.dart';
import 'package:farm_in/Widgets/quantity_selector.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import '../main.dart';

class BuyingPage extends StatefulWidget {
  final Picks pick;

  const BuyingPage({super.key, required this.pick});

  @override
  State<StatefulWidget> createState() => BuyingState();
}

class BuyingState extends State<BuyingPage> {
  int totalCropQtyAvailable = 10;
  int totalAmountRequested = 100000;
  int totalArea = 1000;
  String address = "";
  String latitude = "9";
  String longitude = "78";
  int qty = 1;
  int totalPrice = 0;
  final TextEditingController _controller = TextEditingController(text: "1");

  @override
  void initState() {
    totalPrice = widget.pick.todaysPrice;
    super.initState();
    (() async {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('jwtToken');
        final url = Uri.parse('http://$server/picks/summary');
        final res = await http.post(url,
            body: {"token": token, 'pick_id': widget.pick.id.toString()});
        if (res.statusCode == 200) {
          var jsondata = json.decode(res.body);

          Map<String, dynamic> data = jsondata?[0] ?? {};

          setState(() {
            totalArea = data["area"];
            address = data["address"];
            totalCropQtyAvailable = data["total_qty"];
            totalAmountRequested = data["total_amount"];
            latitude = data["latitude"];
            longitude = data["longitude"];
          });
        }
      } catch (e) {
        print(e);
      }
    })();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const FarmInAppBar(),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Color.fromARGB(119, 208, 255, 188),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 13.0),
                child: Text(
                  "${widget.pick.name} (${widget.pick.symbol})",
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 13.0),
                child: Text(
                  "${widget.pick.todaysPrice}₹ (${widget.pick.todaysChange}▲)",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 163, 224, 165),
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                        child: const Text("Show location in GMap")),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: QuantitySelector(
                        controller: _controller,
                        onValueChanged: (val) {
                          setState(() {
                            qty = val;
                            totalPrice = val * widget.pick.todaysPrice;
                          });
                        }),
                  ),
                  Text(
                    "Total : $totalPrice₹",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width / 2,
                height: 45,
                child: ElevatedButton(
                    onPressed: () {
                      var di = AlertDialog(
                        title: Text('Confirmation'),
                        content: SizedBox(
                          height: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Do yout want to buy ${qty} quantities of ${widget.pick.name}?",
                                style: TextStyle(fontSize: 18),
                              ),
                              Container(
                                margin: EdgeInsets.all(8),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(color: Colors.green),
                                child: Column(
                                  children: [
                                    Text(
                                      "${widget.pick.symbol}",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Text("Total quantity : $qty"),
                                    Text("Total price : $totalPrice₹"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Confirm'),
                            onPressed: () async {
                              try {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                String? token = prefs.getString('jwtToken');
                                final url =
                                    Uri.parse('http://$server/picks/buy');
                                final res = await http.post(url, body: {
                                  "token": token,
                                  "qty": qty.toString(),
                                  "pick_id": widget.pick.id.toString()
                                });
                                Navigator.of(context).pop();
                                if (res.statusCode == 200) {
                                  Map result = json.decode(res.body);
                                  if (updateBlockChain && myid != null) {
                                    var blockchain = BlockChainAsset();
                                    await blockchain.connect();
                                    await blockchain.addAsset(AssetInBlockChain(
                                        10, myid!, 10, qty, totalPrice));
                                  }

                                  if (result["status"] != null) {
                                    showDialog(
                                        context: context,
                                        builder: (ctx) => SuccessDialog(
                                            message: "Order added to portfolio",
                                            onOkPressed: () {
                                              Navigator.of(context).pop();

                                              setState(() {
                                                qty = 1;
                                                _controller.text = "1";
                                                totalPrice =
                                                    widget.pick.todaysPrice;
                                              });
                                            }));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Error buyying pick")));
                                }
                              } catch (e) {
                                print(e);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Unable to reach server")));
                              }
                            },
                          ),
                        ],
                      );
                      showDialog(context: context, builder: (cxt) => di);
                    },
                    child: const Text("Buy now")),
              ),
              SizedBox(
                height: 70,
              ),
              Text(
                "Farmer's statistics",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: Text(
                    "This char shows the yearly profit earned(in lakhs) by the farmer for the last few years"),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                height: 300,
                child: chartToRun(),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Crop timeline",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              CropTimeLineWidget(),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
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
}

Widget chartToRun() {
  LabelLayoutStrategy? xContainerLabelLayoutStrategy;
  ChartData chartData;
  ChartOptions chartOptions = const ChartOptions();
  // Set chart options to show no labels
  chartOptions = const ChartOptions();

  chartData = ChartData(
    dataRows: const [
      [4.5, 4.0, 2.0, 3.1, 4.5],
      [3.5, 4.5, 2.5, 3.2, 4.5],
      [4.0, 4.5, 3.0, 3.5, 4.1],
      [3.8, 4.0, 2.0, 3.5, 4.2],
    ],
    xUserLabels: const ['2018', '2019', '2020', '2021', '2022'],
    dataRowsLegends: const [
      'Carrot',
      'Beetroot',
      'Radish',
      'Rice',
    ],
    chartOptions: chartOptions,
  );
  var verticalBarChartContainer = VerticalBarChartTopContainer(
    chartData: chartData,
    xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
  );

  var verticalBarChart = VerticalBarChart(
    painter: VerticalBarChartPainter(
      verticalBarChartContainer: verticalBarChartContainer,
    ),
  );
  return verticalBarChart;
}
