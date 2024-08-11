import 'package:flutter/material.dart';
import 'package:frontend/features/login_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _DashboardPageState();
  }
}

class _TScard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.95,
        height: 150,
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  "assets/icons/credit_card.png",
                  height: 42,
                  width: 42,
                ),
                const Text(
                  "Transaction Summary",
                  style: TextStyle(
                      fontFamily: 'NunitoSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 25),
                )
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Total Order : 50,000",
                  style: TextStyle(
                      fontFamily: 'NunitoSans',
                      fontWeight: FontWeight.w700,
                      fontSize: 14),
                ),
                Text("Total Savings : ₹ 10,000",
                    style: TextStyle(
                        fontFamily: 'NunitoSans',
                        fontWeight: FontWeight.w700,
                        fontSize: 14))
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Your Order : 50,000",
                  style: TextStyle(
                      fontFamily: 'NunitoSans',
                      fontWeight: FontWeight.w700,
                      fontSize: 14),
                ),
                Text("Your Savings : ₹ 10,000",
                    style: TextStyle(
                        fontFamily: 'NunitoSans',
                        fontWeight: FontWeight.w700,
                        fontSize: 14))
              ],
            ),
          ],
        ));
  }
}

class _ROcard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.95,
        height: 150,
        child: const Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Image.asset(
                //   "assets/icons/credit_card.png",
                //   height: 42,
                //   width: 42,
                // ),
                Text(
                  "Recent Order",
                  style: TextStyle(
                      fontFamily: 'NunitoSans',
                      fontWeight: FontWeight.w400,
                      fontSize: 25),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Order ID : 74822",
                  style: TextStyle(
                      fontFamily: 'NunitoSans',
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                Text("Date : 27/3/24",
                    style: TextStyle(
                        fontFamily: 'NunitoSans',
                        fontWeight: FontWeight.w400,
                        fontSize: 14))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Total Amount : ₹ 5,000",
                  style: TextStyle(
                      fontFamily: 'NunitoSans',
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                Text("Status :  Delivered",
                    style: TextStyle(
                        fontFamily: 'NunitoSans',
                        fontWeight: FontWeight.w400,
                        fontSize: 14))
              ],
            ),
          ],
        ));
  }
}

Widget buildBody() {
  return Center(
    child: Flex(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      direction: Axis.vertical,
      children: [
        Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          color: backgroundColor,
          child: _TScard(),
        ),
        Card(
          color: backgroundColor,
          child: _ROcard(),
        ),
        Card(
          color: backgroundColor,
          child: _TScard(),
        ),
      ],
    ),
  );
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // child: Text("hello"),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          toolbarHeight: MediaQuery.sizeOf(context).height * 0.10,
          title: Flex(
            direction: Axis.horizontal,
            children: [
              Card(
                child: Image.asset("assets/icons/location_icon.png"),
              ),
              const SizedBox(
                  width: 8), // Adds spacing between the icon and text
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Dongri",
                    style: TextStyle(
                        fontFamily: 'NunitoSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  Text(
                    "Mumbai",
                    style: TextStyle(
                        fontFamily: 'NunitoSans',
                        fontWeight: FontWeight.normal,
                        fontSize: 10),
                  )
                ],
              ),
            ],
          ),
        ),
        body: buildBody(),
      ),
    );
  }
}
