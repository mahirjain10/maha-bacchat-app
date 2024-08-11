// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:frontend/features/register_page/register_bloc/register_bloc.dart';
// import 'package:frontend/features/register_page/register_bloc/register_event.dart';

// void emailValidation(String email, BuildContext context) {
//   final currentState = context.read<RegisterBloc>().state;
//   debugPrint("email validation fired");
//   final emailRegex = RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$");
//   if (currentState.state.email == null || currentState.state.email == "") {
//     debugPrint("email in validation : ${currentState.state.email}");
//     BlocProvider.of<RegisterBloc>(context).add(RegisterPageValidationEvent(
//         "Email field should not be empty",
//         currentState.errorState.passwordError,
//         currentState.errorState.mobileNoError,
//         currentState.errorState.roleError,
//         false));
//   } else if (!emailRegex.hasMatch(currentState.state.email)) {
//     BlocProvider.of<RegisterBloc>(context).add(RegisterPageValidationEvent(
//         "Invalid email",
//         currentState.errorState.passwordError,
//         currentState.errorState.mobileNoError,
//         currentState.errorState.roleError,
//         false));
//   }
//   debugPrint(
//       "email error in validation func : ${currentState.errorState.emailError}");
// }

// void passwordValidation(String password, BuildContext context) {
//   final currentState = context.read<RegisterBloc>().state;

//   if (password.length < 8) {
//     BlocProvider.of<RegisterBloc>(context).add(RegisterPageValidationEvent(
//         currentState.errorState.emailError,
//         "Password should not be less than 8 charachters",
//         currentState.errorState.mobileNoError,
//         currentState.errorState.roleError,
//         false));
//   } else if (password.length > 10) {
//     BlocProvider.of<RegisterBloc>(context).add(RegisterPageValidationEvent(
//         currentState.errorState.emailError,
//         "Password should not be greater than 10 charachters",
//         currentState.errorState.mobileNoError,
//         currentState.errorState.roleError,
//         false));
//   } else if (password == null || password == "") {
//     BlocProvider.of<RegisterBloc>(context).add(RegisterPageValidationEvent(
//         currentState.errorState.emailError,
//         "Password field should not be empty",
//         currentState.errorState.mobileNoError,
//         currentState.errorState.roleError,
//         false));
//   }
// }

// void mobileNoValidation(String mobileNo, BuildContext context) {
//   final currentState = context.read<RegisterBloc>().state;
//   if (mobileNo.length != 10) {
//     BlocProvider.of<RegisterBloc>(context).add(RegisterPageValidationEvent(
//         currentState.errorState.emailError,
//         currentState.errorState.passwordError,
//         "Mobile Number should be of 10 digits",
//         currentState.errorState.roleError,
//         false));
//   }
// }

// void roleValidation(String role, BuildContext context) {
//   final currentState = context.read<RegisterBloc>().state;
//   if (role == null || role == "") {
//     BlocProvider.of<RegisterBloc>(context).add(RegisterPageValidationEvent(
//         currentState.errorState.emailError,
//         currentState.errorState.passwordError,
//         currentState.errorState.mobileNoError,
//         "Select any one role",
//         false));
//   }
// }
