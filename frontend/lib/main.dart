import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/mobile_no_input_page/ui/mobile_no_input_page.dart';
import 'package:frontend/features/otp_page/ui/otp_page.dart';
import 'package:frontend/features/register_page/register_bloc/register_bloc.dart';
import 'package:frontend/features/register_page/ui/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return BlocProvider(
    //   create: (context) => RegisterBloc(),
    //   child: const MaterialApp(
    //     title: 'My App',
    //     home: RegisterPage(),
    //     // home: RegisterPage(),
    //     debugShowCheckedModeBanner: false,
    //   ),
    // );
    return const MaterialApp(
      title: 'My App',
      home: MobileNoInputPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
