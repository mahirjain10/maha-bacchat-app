import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class RegisterPageState extends Equatable {
  const RegisterPageState();
}

class RegisterState extends RegisterPageState {
  final String email;
  final String password;
  final String mobileNo;
  final String role;

  const RegisterState({
    required this.email,
    required this.password,
    required this.mobileNo,
    required this.role,
  });

  factory RegisterState.initialState() {
    return const RegisterState(
      email: '',
      password: '',
      mobileNo: '',
      role: '',
    );
  }

  RegisterState copyWith({
    String? email,
    String? password,
    String? mobileNo,
    String? role,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      mobileNo: mobileNo ?? this.mobileNo,
      role: role ?? this.role,
    );
  }

  @override
  List<Object?> get props => [email, password, mobileNo, role];
}

class RegisterServiceLoading extends RegisterPageState {
  @override
  List<Object?> get props => [];
}

class RegisterServiceSuccess extends RegisterPageState {
  @override
  List<Object?> get props => [];
}

class RegisterServiceError extends RegisterPageState {
  final Map<String, String> errorMessage;

  const RegisterServiceError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
