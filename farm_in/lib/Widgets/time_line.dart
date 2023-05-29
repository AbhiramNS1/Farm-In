import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class CropTimeLineWidget extends StatelessWidget {
  List Heading = [
    'Seed Selection',
    'Soil Preparation',
    'Sowing',
    'Watering and Fertilizing',
    'Harvesting'
  ];
  List Dates = [
    'June 1, 2023 - June 10, 202',
    'June 11, 2023 - July 10, 2023',
    'July 11, 2023 - August 10, 2023',
    'August 11, 2023 - September 30, 2023',
    'October 1, 2023 - November 30, 2023'
  ];
  List Detailed = [
    "During this phase, farmers select high-quality carrot seeds that are suited for their specific cultivation requirements. The process involves choosing seeds that have good germination rates and desirable characteristics.",
    "In this stage, the soil is prepared to create an optimal growing environment for carrots. Farmers may perform tasks such as tilling, removing weeds, and adding organic matter or fertilizers to improve soil fertility and structure",
    "During this period, the carrot seeds are sown in the prepared soil. Farmers carefully plant the seeds at the right depth and spacing to ensure proper growth and development of the carrot plants.",
    "Carrot plants require adequate water and nutrients to thrive. During this phase, farmers regularly water the crops, ensuring the soil remains consistently moist but not waterlogged. They also apply appropriate fertilizers to provide essential nutrients for healthy carrot growth.",
    "The final stage of carrot cultivation is harvesting. This occurs when the carrot roots have reached maturity and are ready for consumption. Farmers carefully pull the mature carrots from the ground, remove any excess foliage, and prepare them for storage or market"
  ];

  @override
  Widget build(BuildContext context) {
    return FixedTimeline.tileBuilder(
      builder: TimelineTileBuilder.connectedFromStyle(
        contentsAlign: ContentsAlign.alternating,
        oppositeContentsBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(Heading[index]),
        ),
        contentsBuilder: (context, index) => Card(
          child: InkWell(
            onTap: () => showDialog(
                context: context,
                builder: (cxt) => AlertDialog(
                      title: Text(Heading[index]),
                      content: Text(Detailed[index]),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("ok"))
                      ],
                    )),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8),
              child: Text(Dates[index]),
            ),
          ),
        ),
        connectorStyleBuilder: (context, index) => ConnectorStyle.solidLine,
        indicatorStyleBuilder: (context, index) => IndicatorStyle.dot,
        itemCount: Heading.length,
      ),
    );
  }
}
