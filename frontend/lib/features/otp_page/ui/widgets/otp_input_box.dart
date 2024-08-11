import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/features/login_page.dart';

Widget buildOtpInputBox(BuildContext context, int index, List<String> otp) {
  return Container(
    height: 50,
    width: 50,
    // margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
    color: Colors.cyan,
    child: TextFormField(
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: (value) {
        if (value.length == 1) {
          FocusScope.of(context).nextFocus();
        } else if (value.isEmpty) {
          FocusScope.of(context).previousFocus();
        } else {
          FocusScope.of(context).previousFocus();
        }
        otp[index] = value.toString();
      },
      style: const TextStyle(
          fontFamily: 'NunitoSans', fontSize: 20, fontWeight: FontWeight.w600),
      decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          counterText: "",
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
      keyboardType:
          TextInputType.numberWithOptions(signed: false, decimal: false),
      maxLength: 1,
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
    ),
  );
}
