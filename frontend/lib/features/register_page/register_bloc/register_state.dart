// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:meta/meta.dart';
// import 'package:equatable/equatable.dart';

// @immutable
// class RegisterPageState extends Equatable {
//   final String email;
//   final String password;
//   final String mobileNo;
//   final String role;

//   const RegisterPageState({
//     required this.email,
//     required this.password,
//     required this.mobileNo,
//     required this.role,
//   });

//   // Using a factory constructor for initial state
//   factory RegisterPageState.initialState() {
//     return const RegisterPageState(
//       email: '',
//       password: '',
//       mobileNo: '',
//       role: '',
//     );
//   }

//   // Copy method for updating fields
//   RegisterPageState copyWith({
//     String? email,
//     String? password,
//     String? mobileNo,
//     String? role,
//   }) {
//     return RegisterPageState(
//       email: email ?? this.email,
//       password: password ?? this.password,
//       mobileNo: mobileNo ?? this.mobileNo,
//       role: role ?? this.role,
//     );
//   }

//   @override
//   List<Object?> get props => [email, password, mobileNo, role];
// }

// class RegisterPageErrorState extends Equatable {
//   final String emailError;
//   final String passwordError;
//   final String mobileNoError;
//   final String roleError;
//   final bool isValid;

//   // Constructor with initialization of final fields
//   const RegisterPageErrorState({
//     required this.emailError,
//     required this.passwordError,
//     required this.mobileNoError,
//     required this.roleError,
//     this.isValid = false, // Initialize with default value here
//   });

//   // Using a factory constructor for initial state
//   factory RegisterPageErrorState.initialState() {
//     return const RegisterPageErrorState(
//       emailError: '',
//       passwordError: '',
//       mobileNoError: '',
//       roleError: '',
//       isValid: false,
//     );
//   }

//   // Copy method for updating fields
//   RegisterPageErrorState copyWith({
//     String? emailError,
//     String? passwordError,
//     String? mobileNoError,
//     String? roleError,
//     bool? isValid, // Changed to nullable for proper copying
//   }) {
//     return RegisterPageErrorState(
//       emailError: emailError ?? this.emailError,
//       passwordError: passwordError ?? this.passwordError,
//       mobileNoError: mobileNoError ?? this.mobileNoError,
//       roleError: roleError ?? this.roleError,
//       isValid: isValid ?? this.isValid, // Fixed syntax error
//     );
//   }

//   @override
//   List<Object?> get props =>
//       [emailError, passwordError, mobileNoError, roleError, isValid];
// }

// // Define a combined state
// class RegisterPageCombinedState extends Equatable {
//   final RegisterPageState state;
//   final RegisterPageErrorState errorState;

//   const RegisterPageCombinedState({
//     required this.state,
//     required this.errorState,
//   });

//   // Using a factory constructor for initial state
//   factory RegisterPageCombinedState.initialState() {
//     return RegisterPageCombinedState(
//       state: RegisterPageState.initialState(),
//       errorState: RegisterPageErrorState.initialState(),
//     );
//   }

//   // Copy with new states
//   RegisterPageCombinedState copyWith({
//     RegisterPageState? state,
//     RegisterPageErrorState? errorState,
//   }) {
//     return RegisterPageCombinedState(
//       state: state ?? this.state,
//       errorState: errorState ?? this.errorState,
//     );
//   }

//   @override
//   List<Object?> get props => [state, errorState];
// }

// class RegisterServiceLoading  {
//   RegisterPageCombinedState obj = RegisterPageCombinedState(state: , errorState: )
// }

// class RegisterServiceSuccess extends RegisterPageCombinedState {
//   RegisterServiceSuccess({required super.state, required super.errorState});
// }

// class RegisterServiceError extends RegisterPageCombinedState {
//   RegisterServiceError({required super.state, required super.errorState});
// }
