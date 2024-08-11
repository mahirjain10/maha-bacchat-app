import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:frontend/features/common/app_title.dart';
import 'package:frontend/features/login_page.dart';
import 'package:frontend/features/otp_page/ui/widgets/otp_input_box.dart';
import 'package:frontend/features/otp_page/ui/widgets/verification_code.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<StatefulWidget> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  var timeLeft = 0;
  late Timer _timer;

  final List<String> otp = List.filled(5, '');
  final List<FocusNode> focusNodes = List.generate(5, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    // _buildTimerFunc();
  }

  void _buildTimerFunc() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  buildAppTitle(),
                  const SizedBox(height: 60),
                  buildVerificationCode(context),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(5, (index) {
                      return buildOtpInputBox(
                        context,
                        index,
                        otp,
                      );
                    }),
                  ),
                  SizedBox(height: 15),
                  const Text(
                    "Invalid otp",
                    style: TextStyle(
                        fontFamily: 'NunitoSans',
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 45,
                    width: MediaQuery.sizeOf(context).width * .90,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        onPressed: () {
                          print(otp);
                        },
                        child: const Text(
                          "Verify",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'NunitoSans',
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Didn't receive the OTP? ",
                          style: TextStyle(
                              fontFamily: 'NunitoSans',
                              color: Colors.white,
                              fontSize: 15)),
                      InkWell(
                        onTap: timeLeft == 0
                            ? () {
                                timeLeft = 59;
                                _buildTimerFunc();
                              }
                            : null, // Add your resend functionality here
                        child: Text(
                          timeLeft == 0
                              ? "Resend"
                              : "Resend in 00:${timeLeft.toString().padLeft(2, '0')}",
                          style: TextStyle(
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w700,
                              color: timeLeft == 0
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                              fontSize: 15),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
