import 'dart:convert';

import 'package:farm_in/Pages/buying_page.dart';
import 'package:farm_in/Pages/portfolio_page.dart';
import 'package:farm_in/Widgets/appbar.dart';
import 'package:farm_in/blockchain/web3main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/picks.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomepageState();
}

class HomepageState extends State<HomePage> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FarmInAppBar(),
      body: (_index == 0)
          ? Center(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 159, 237, 162)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                  const Expanded(
                      // height: MediaQuery.of(context).size.height,
                      child: MyTabbedView())
                ],
              ),
            )
          : Portfolio(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (val) => {
          setState(() {
            if (_index == 0)
              _index++;
            else
              _index = 0;
          })
        },
        fixedColor: Colors.green,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_rounded), label: "holdings")
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        var storage = Storage();
        await storage.init();
        await storage.setNumber(300);
        var a = await storage.getNumber();
        print(a);
      }),
    );
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
  return FutureBuilder<List<Picks>>(future: (() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('jwtToken');
      final url = Uri.parse('http://$server/picks/home_page_picks');
      final res = await http.post(url, body: {"token": token});

      if (res.statusCode == 200) {
        List<dynamic> data = json.decode(res.body);
        List<Picks> list = [];
        for (int i = 0; i < data.length; i++) {
          list.add(Picks.fromJson(data[i]));
        }
        print(list);
        return list;
      } else {
        print("errrorrr=================");
      }
    } catch (e) {
      print(e);
      print("klwkm--------------------");
    }

    return [] as List<Picks>;
  })(), builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BuyingPage(pick: snapshot.data![index])));
              },
              child: Card(
                elevation: 1,
                child: ListTile(
                  title: Text(snapshot.data![index].symbol),
                  subtitle: Text(snapshot.data![index].name),
                  trailing: Column(
                    children: [
                      Text(
                        "${snapshot.data![index].todaysPrice} ₹",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text("${snapshot.data![index].todaysChange}% ▲")
                    ],
                  ),
                ),
              ),
            );
          });
    } else
      return const Center(
        child: CircularProgressIndicator(),
      );
  });
}
