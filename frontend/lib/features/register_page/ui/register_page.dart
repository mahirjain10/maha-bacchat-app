import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/login_page.dart';
import 'package:frontend/features/register_page/register_bloc/register_bloc.dart';
import 'package:frontend/features/register_page/register_bloc/register_event.dart';
import 'package:frontend/features/register_page/register_bloc/register_service_state.dart';

import 'package:frontend/features/register_page/ui/widgets/dropdown_menu.dart';
import 'package:frontend/features/register_page/ui/widgets/mobile_no_input.dart';
import 'package:frontend/features/common/page_text.dart';
import 'package:frontend/features/common/app_title.dart';
import 'package:frontend/features/common/input_bar.dart';
import 'package:frontend/features/common/register_login_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FocusNode _phoneFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isPhoneFocused = _phoneFocusNode.hasFocus;

    return BlocConsumer<RegisterBloc, RegisterPageState>(
      listener: (context, state) {
        if (state is RegisterState) {
          _emailController.text = state.email;
          print("rebuilding");
          _passwordController.text = state.password;
        }
        if (state is RegisterServiceError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage as String)),
          );
          print("service error state listener");
        }
      },
      builder: (context, state) {
        print("rebuilder ");
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
                      const SizedBox(height: 50),
                      buildPageText(context),
                      const SizedBox(height: 50),
                      // Email input bar
                      buildInputBar(
                        context,
                        InputOption(
                          obscureText: false,
                          controller: _emailController,
                          hintText: "Enter your email",
                          iconPath: "assets/icons/mail_30.png",
                          onChanged: (value) {
                            context.read<RegisterBloc>().add(
                                  RegisterPageInputChangedEvent(
                                    value,
                                    _passwordController.text,
                                    (state as RegisterState).mobileNo,
                                    state.role,
                                  ),
                                );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Password input bar
                      buildInputBar(
                        context,
                        InputOption(
                          obscureText: true,
                          controller: _passwordController,
                          hintText: "Enter your password",
                          iconPath: "assets/icons/password_20.png",
                          onChanged: (value) {
                            context.read<RegisterBloc>().add(
                                  RegisterPageInputChangedEvent(
                                    _emailController.text,
                                    value,
                                    (state as RegisterState).mobileNo,
                                    state.role,
                                  ),
                                );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      // buildMobileNoInput(
                      //     context, _phoneFocusNode, isPhoneFocused, null),
                      const SizedBox(height: 10),
                      buildRolesDropDown(context),
                      const SizedBox(height: 20),
                      state is RegisterServiceLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                              backgroundColor: backgroundColor,
                            )
                          : buildRegisterLoginButton(context, "Register"),
                      const SizedBox(height: 50),
                      buildDividerPrivacyText(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
