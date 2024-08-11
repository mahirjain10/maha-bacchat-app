import 'package:flutter/material.dart';

Widget buildPageText(BuildContext context) {
  return Column(
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.90,
        child: const Text(
          textAlign: TextAlign.center,
          "Hey, what's your personal details?",
          style: TextStyle(
            fontFamily: 'NunitoSans',
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
      ),
      const SizedBox(height: 10),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.90,
        child: const Text(
          textAlign: TextAlign.center,
          "Don't worry, we will never make your personal details public",
          style: TextStyle(
            fontFamily: 'NunitoSans',
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    ],
  );
}
