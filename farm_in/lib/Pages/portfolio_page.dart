import 'package:farm_in/Pages/detailed_screen.dart';
import 'package:farm_in/Widgets/appbar.dart';
import 'package:flutter/material.dart';

class Portfolio extends StatelessWidget {
  const Portfolio({super.key});

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
                children: const [
                  Text(
                    "My holdings",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "20% ▲",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Totoal invested : 20,000 ₹"),
                  Text("Total profit : 8,000 ₹")
                ],
              )
            ],
          ),
        ),
        Flexible(
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailedScreen()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 0.5, color: Color.fromARGB(73, 0, 0, 0))),
                    child: ListTile(
                      isThreeLine: true,
                      title: const Text("RVKS"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("CARROT"),
                          Text("Qty 1000"),
                        ],
                      ),
                      trailing: Column(children: [Text("240 ₹"), Text("2% ▲")]),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
