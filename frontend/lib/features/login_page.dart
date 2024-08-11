import 'package:flutter/material.dart';
// import 'package:frontend/pages/widgets/app_title.dart';
// import 'package:frontend/pages/widgets/input_bar.dart';
// import 'package:frontend/pages/widgets/register_login_button.dart';

Color backgroundColor = const Color(0xffdc84f3);

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//   @override
//   State<StatefulWidget> createState() {
//     return _LoginPageState();
//   }
// }

// Widget buildPageText(BuildContext context) {
//   return Column(
//     children: [
//       const Text(
//         "Hey, what’s your email ?",
//         style: TextStyle(
//             fontFamily: 'NunitoSans',
//             color: Colors.white,
//             fontWeight: FontWeight.w800,
//             fontSize: 20),
//       ),
//       const SizedBox(height: 10),
//       SizedBox(
//         width: MediaQuery.of(context).size.width * 0.90,
//         child: const Text(
//           textAlign: TextAlign.center,
//           "Don't worry, we will never make your email public",
//           style: TextStyle(
//             fontFamily: 'NunitoSans',
//             color: Colors.white,
//             fontWeight: FontWeight.w600,
//             fontSize: 15,
//           ),
//         ),
//       ),
//     ],
//   );
// }

Widget buildDividerPrivacyText(BuildContext context) {
  return Column(
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: const Divider(
          color: Colors.white,
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.60,
        child: const Text(
          textAlign: TextAlign.center,
          "By clicking login, you accept our Privacy Policy",
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

// Widget buildRegisterText(BuildContext context) {
//   return SizedBox(
//     width: MediaQuery.of(context).size.width * 0.8,
//     child: TextButton(
//       onPressed: () {},
//       child: const Text(
//         "Don't have a account ? register here",
//         style: TextStyle(
//           fontFamily: 'NunitoSans',
//           color: Colors.white,
//           fontWeight: FontWeight.w600,
//           fontSize: 15,
//         ),
//       ),
//     ),
//   );
// }

// class _LoginPageState extends State<LoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: backgroundColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Container(
//             alignment: Alignment.center,
//             // color: Colors.amber,
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 60),
//                   buildAppTitle(),
//                   const SizedBox(height: 100),
//                   buildPageText(context),
//                   const SizedBox(height: 20),
//                   // form
//                   Column(
//                     children: [
//                       buildInputBar(
//                           context,
//                           InputOption(
//                               hintText: "Enter your email",
//                               iconPath: "assets/icons/mail_30.png")),
//                       const SizedBox(height: 10),
//                       buildInputBar(
//                           context,
//                           InputOption(
//                               hintText: "Enter your password",
//                               iconPath: "assets/icons/password_20.png")),
//                       const SizedBox(height: 20),
//                       buildRegisterLoginButton(context, "Login"),
//                       buildRegisterText(context),
//                       const SizedBox(height: 100),
//                       buildDividerPrivacyText(context),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
