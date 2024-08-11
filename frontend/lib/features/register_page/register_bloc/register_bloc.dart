import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/register_page/models/api_response.dart';
import 'package:frontend/features/register_page/register_bloc/register_event.dart';
import 'package:frontend/features/register_page/register_bloc/register_service_state.dart';
import 'package:frontend/features/register_page/repos/post_repos.dart';
import 'package:frontend/features/register_page/utils/response.dart';

class RegisterBloc extends Bloc<RegisterPageEvent, RegisterPageState> {
  RegisterBloc() : super(RegisterState.initialState()) {
    on<RegisterPageInputChangedEvent>(_onInputChanged);
    // on<RegisterPageValidationEvent>(_onValidation);
    on<PostDataEvent>(postDataEvent);
  }

  FutureOr<void> _onInputChanged(
    RegisterPageInputChangedEvent event,
    Emitter<RegisterPageState> emit,
  ) {
    final currentState = state;
    if (currentState is RegisterState) {
      final newState = currentState.copyWith(
        email: event.email,
        password: event.password,
        mobileNo: event.mobileNo,
        role: event.role,
      );
      debugPrint("current state from on oninputchanged : $newState");
      emit(newState);
      debugPrint("current state from on oninputchanged after emit : $newState");
    }
  }

  // void _onValidation(RegisterPageValidationEvent event,
  //     Emitter<RegisterPageCombinedState> emit) {
  //   emit(state.copyWith(
  //     errorState: state.errorState.copyWith(
  //       emailError: event.emailError,
  //       passwordError: event.passwordError,
  //       mobileNoError: event.mobileNoError,
  //       roleError: event.roleError,
  //       isValid: event.isValid,
  //     ),
  //   ));
  // }

  // void _onSubmit(RegisterPageEvent event, Emitter<RegisterPageState> emit) {
  //   // Handle form submission logic here
  //   // Check if the form is valid and then proceed with submission

  // }
  FutureOr<void> postDataEvent(
      PostDataEvent event, Emitter<RegisterPageState> emit) async {
    final currentState = state;
    print("in post event");

    RegisterResponse? response;

    if (currentState is RegisterState) {
      // Ensuring current state is of type RegisterState
      emit(RegisterServiceLoading());
      response = await PostRepos.addPost(
        currentState.email,
        currentState.password,
        currentState.mobileNo,
        currentState.role.toLowerCase(),
      );
      print('Status Code: ${response?.statusCode}');
      print('Message: ${response?.message}');
      print('data: ${response?.data}');
      print('Success: ${response?.success}');
      print('errors: ${response?.errors}');
      if (response?.success == false) {
        emit(RegisterServiceError(response?.errors ?? {}));
        print("service error emitted");
      } else {
        emit(RegisterServiceSuccess());
        print("service success emitted");
      }
    }

    // if (response.body.)
    //   emit(RegisterServiceSuccess());
    // } else {
    //   emit(const RegisterServiceError("message error"));
    // }
  }
}
