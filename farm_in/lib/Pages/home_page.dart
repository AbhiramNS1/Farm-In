import 'package:farm_in/Widgets/appbar.dart';
import 'package:farm_in/Widgets/bottomnav.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const FarmInAppBar(),
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 159, 237, 162)),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Trending picks",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "5%  ▲",
                        style: TextStyle(
                            color: Color.fromARGB(255, 95, 156, 255),
                            fontSize: 25),
                      )
                    ]),
              ),
              // ListOfStockes(),
              SizedBox(height: 600, child: MyTabbedView())
            ],
          ),
        )),
        bottomNavigationBar: BottomNavigation());
  }
}

class MyTabbedView extends StatelessWidget {
  final List<Widget> tabs = const [
    Tab(text: 'High profit'),
    Tab(text: 'Latest'),
    Tab(text: 'All'),
  ];

  const MyTabbedView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: <Widget>[
          TabBar(
            indicatorColor: Colors.green,
            labelColor: Colors.black,
            tabs: tabs,
          ),
          Expanded(
            child: TabBarView(
              children: <Widget>[
                // add widgets for each tab here
                ListOfStockes(),
                ListOfStockes(),
                ListOfStockes(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget ListOfStockes() {
  return ListView.builder(
      shrinkWrap: true,
      itemCount: 20,
      itemBuilder: (context, index) {
        return Card(
          elevation: 1,
          child: ListTile(
            title: Text("RKVS"),
            subtitle: Text("CARROT"),
            trailing: Column(
              children: const [
                Text(
                  "250 ₹",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text("2% ▲")
              ],
            ),
          ),
        );
      });
}
