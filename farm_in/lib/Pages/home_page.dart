import 'package:farm_in/Widgets/appbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const FarmInAppBar(),
        body: Center(
            child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 159, 237, 162)),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Trending picks",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "5%  ▲",
                      style: TextStyle(
                          color: Color.fromARGB(255, 95, 156, 255),
                          fontSize: 25),
                    )
                  ]),
            ),
            Flexible(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("RKVS"),
                      subtitle: Text("CARROT"),
                      trailing: Column(
                        children: const [
                          Text(
                            "250 ₹",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text("2% ▲")
                        ],
                      ),
                    );
                  }),
            ),
          ],
        )));
  }
}
