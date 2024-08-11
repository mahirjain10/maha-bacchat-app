import 'package:flutter/material.dart';

Widget buildVerificationCode(BuildContext context) {
  return const Column(
    children: [
      Text(
        "Verification code",
        style: TextStyle(
          fontFamily: 'NunitoSans',
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 20,
        ),
      ),
      Text(
        "Please enter the OTP sent to",
        style: TextStyle(
          fontFamily: 'NunitoSans',
          color: Colors.white,
          // fontWeight: FontWeight.w800,
          // fontSize: 20,
        ),
      ),
      Text(
        "9152077168",
        style: TextStyle(
          fontFamily: 'NunitoSans',
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 15,
        ),
      )
    ],
  );
}
