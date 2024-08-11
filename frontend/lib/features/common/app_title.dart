import 'package:flutter/material.dart';

Widget buildAppTitle() {
  return const Column(
    children: [
      Text(
        "Maha Bacchat",
        style: TextStyle(
            fontFamily: 'NunitoSans',
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 30),
      ),
      Text(
        "Local Saving App",
        style: TextStyle(
            fontFamily: 'NunitoSans',
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 15),
      ),
    ],
  );
}
