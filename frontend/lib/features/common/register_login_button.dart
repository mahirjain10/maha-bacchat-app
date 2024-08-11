import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/register_page/register_bloc/register_bloc.dart';
import 'package:frontend/features/register_page/register_bloc/register_event.dart';
import 'package:frontend/features/register_page/register_bloc/register_state.dart';
import 'package:frontend/features/register_page/utils/validation.dart';

Widget buildRegisterLoginButton(BuildContext context, String btnText) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.8,
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
          backgroundColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      onPressed: () {
        final currentState = context.read<RegisterBloc>().state;
        // emailValidation(currentState.state.email, context);
        // passwordValidation(currentState.state.password, context);
        // print(currentState.errorState);
        print(currentState);
        context.read<RegisterBloc>().add(PostDataEvent());
      },
      child: Text(
        btnText,
        style: const TextStyle(
          fontFamily: 'NunitoSans',
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 15,
        ),
      ),
    ),
  );
}
