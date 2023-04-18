import 'package:farm_in/Models/realtime.dart';
import 'package:flutter/material.dart';

class DetailedScreen extends StatelessWidget {
  const DetailedScreen({super.key});

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
          title: Text("Carrot (RKVS)"),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Summary'),
              Tab(text: 'indicators'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SummaryView(),
            Indicators(),
          ],
        ),
      ),
    );
  }
}

class SummaryView extends StatelessWidget {
  SummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
          child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
            padding: const EdgeInsets.all(20),
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 167, 255, 199)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Details ",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                const Text(
                    "Carrot farming is a highly profitable and risk free investment choice."
                    "Mr. Patel, a dedicated farmer from a village in Maharashtra."
                    " He has been farming for over a decade and has mastered the art of cultivating carrot."),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                      onPressed: () {},
                      child: const Text("Visit farmer's profile")),
                )
              ],
            ),
          ),
          const Text(
            "Your Investment",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          InfoRow("Total Quantity  :  ", "200"),
          InfoRow("Total Amount Invested  :  ", "12,000 ₹"),
          InfoRow("Total Profit  :  ", "3400 ₹"),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
            padding: EdgeInsets.all(20),
            decoration:
                BoxDecoration(color: Color.fromARGB(255, 167, 255, 199)),
            child: Column(
              children: [
                const Text(
                  "Crop's Statistics",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                InfoRow("Total Quantity Avilable :  ", "32000"),
                InfoRow("Total Amount requested  :  ", "340,000₹"),
                InfoRow("Total Area  :  ", "1200 Sqkm"),
                InfoRow("Location  :  ", "Rajpur,Maharashtra - 411023"),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                    onPressed: () {},
                    child: const Text("Show location in GMap"))
              ],
            ),
          ),
          InfoRow("Other Similar picks", ""),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(10, (index) => ScrollCard()),
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
    child: Row(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
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
  const ScrollCard({super.key});

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
          const Text(
            "Tinder Carrot",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "24% ▲",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
            ),
          ),
          Image.asset(
            "assets/images/items/carrot.png",
            width: 100,
          ),
          const Text(
              "Carrot cultivation in Bihar by Patel Ravi.Moderate profit and low risk investment")
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
  const Indicators({super.key});

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
      decoration: BoxDecoration(color: Color.fromARGB(255, 167, 255, 199)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Text(
            heading ?? "",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          Text(value ?? ""),
        ],
      ),
    );
  }
}
