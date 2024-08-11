import 'package:flutter/material.dart';

Color backgroundColor = const Color(0xffdc84f3);
Color buttonColor = const Color(0xFF90EE90);

class OrderAndRequest extends StatefulWidget {
  const OrderAndRequest({super.key});
  @override
  State<StatefulWidget> createState() => _OrderAndRequestState();
}

AppBar buildAppBar(TabController tabController) {
  return AppBar(
    backgroundColor: backgroundColor,
    title: const Text(
      "Request And Order",
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),
    ),
    bottom: TabBar(
      controller: tabController,
      labelColor: Colors.black,
      indicatorColor: backgroundColor,
      // unselectedLabelColor: Colors.grey,
      unselectedLabelStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
      labelStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
      tabs: const [
        Tab(
          child: Text(
            "Create a new order request",
            textAlign: TextAlign.center,
          ),
        ),
        Tab(
          child: Text(
            "Order from requests",
            textAlign: TextAlign.center,
          ),
        )
      ],
    ),
  );
}

// Widget buildCanorScreen(BuildContext context, double deviceWidth) {
//   return SizedBox(
//     child: Container(
//       padding: EdgeInsets.all(10),
//       color: backgroundColor,
//       width: deviceWidth * 0.50,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Product Name",
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               fontSize: 15,
//             ),
//           ),
//           const SizedBox(height: 5),
//           SizedBox(
//             height: 35,
//             width: deviceWidth * 0.90,
//             child: TextFormField(
//               textAlignVertical: TextAlignVertical.center,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(5)),
//                 ),
//                 hintText: 'Enter product name',
//                 contentPadding:
//                     EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

Widget temp(
    String label, String hintText, double? inputFieldWidth, double? padding) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      const SizedBox(height: 5),
      SizedBox(
        height: 35,
        width: inputFieldWidth,
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            hintText: hintText,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          ),
        ),
      ),
    ],
  );
}

Widget buildCanorScreen(BuildContext context, double deviceWidth) {
  return Center(
    child: FractionallySizedBox(
      widthFactor: 0.95,
      heightFactor: 0.97, // Takes up 90% of the device width
      child: Card(
          // color: Colors.blue, // Use a visible color for debugging
          // child: Padding(
          // padding: EdgeInsets.all(16.0),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          temp("Product name", 'Enter product name', null, null),
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                temp("Choose a dealer", "Choose a dealer ", deviceWidth * 0.65,
                    null),
                temp("Bought QTY", "QTY", deviceWidth * 0.25, 15)
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                temp("Min Qty", "QTY", deviceWidth * 0.20, null),
                temp("Purchasing Qty", "QTY", deviceWidth * 0.30, 15),
                temp("Remaining Qty", "QTY", deviceWidth * 0.30, 15)
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                temp("MRP", "Amount", deviceWidth * 0.23, null),
                temp("Cost", "Amount", deviceWidth * 0.23, 15),
                temp("Total Payable Amount", "Amount", deviceWidth * 0.40, 15)
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: Flex(
              direction: Axis.horizontal,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                temp("Request's expiry date and time", "Date and time",
                    deviceWidth * 0.80, null),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.only(top: 20),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: buttonColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {},
                          child: const Text(
                            "Create Request",
                            style: TextStyle(
                                fontFamily: 'NunitoSans',
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 15),
                          )))
                ],
              ))
        ],
      )),
      // ),
    ),
  );
}

// ignore: non_constant_identifier_names
class _OrderAndRequestState extends State<OrderAndRequest>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(tabController),
      body: TabBarView(
        controller: tabController,
        children: [
          buildCanorScreen(context, deviceWidth),
          const Text("order from requests")
        ],
      ),
    );
  }
}
