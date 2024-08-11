import 'package:flutter/material.dart';
import 'package:frontend/features/login_page.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _OrdersPageState();
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    title: const Text("Your Orders",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        )),
    toolbarHeight: MediaQuery.sizeOf(context).height * 0.1,
  );
}

Widget buildSavingsCard(BuildContext context) {
  return Card(
    color: backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.circular(15.0), // Optional: adds rounded corners
      side: const BorderSide(
        color: Colors.black, // Border color
        width: 1.5, // Border width
      ),
    ),
    child: Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      width: MediaQuery.sizeOf(context).width * 0.95,
      height: MediaQuery.sizeOf(context).height * 0.20,
      child: const Flex(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        direction: Axis.vertical,
        children: [
          Column(
            children: [
              Text(
                "Current Month Savings",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              Text(
                "₹ 20,000",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    "Today’s Savings",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  Text("₹ 20,000",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                      )),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Lifetime Savings",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  Text("₹ 20,000",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                      )),
                ],
              )
            ],
          )
        ],
      ),
    ),
  );
}

Widget buildSummaryCard(BuildContext context) {
  return Card(
      child: Container(
    width: MediaQuery.sizeOf(context).width * 0.95,
    child: Flex(
      direction: Axis.vertical,
      children: [
        const Row(
          children: [
            Text(
              "Varsha Distributor",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
            Text(
              "₹ 4,980 >",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          ],
        ),
        const Row(
          children: [
            Text(
              "Request’s Total",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 17,
              ),
            ),
            Text(
              "₹  20,000",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 17,
              ),
            )
          ],
        ),
        const Row(
          children: [
            Text(
              "Savings",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 17,
              ),
            ),
            Text(
              "₹  8,000",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 17,
              ),
            )
          ],
        ),
        Row(
          children: [
            const Text(
              "14th Apr ,2024",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 17,
              ),
            ),
            Row(
              children: [
                const Text(
                  "Delivered !",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 17,
                  ),
                ),
                Image.asset(
                  "assets/icons/green_tick.png",
                  width: 20,
                  height: 20,
                )
              ],
            )
          ],
        )
      ],
    ),
  ));
}

Widget buildBody(BuildContext context) {
  return Column(
    children: [buildSavingsCard(context), buildSummaryCard(context)],
  );
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }
}
