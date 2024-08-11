import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:frontend/features/register_page/register_bloc/register_bloc.dart';
// import 'package:frontend/features/register_page/register_bloc/register_event.dart';
// import 'package:frontend/features/register_page/register_bloc/register_service_state.dart';

Widget buildMobileNoInput(BuildContext context, FocusNode phoneFocusNode,
    bool isPhoneFocused, String? errorText) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.8,
    height: 40,
    child: Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            border: Border.all(
              color: isPhoneFocused ? Colors.black : Colors.transparent,
              width: 1.0,
            ),
          ),
          width: MediaQuery.sizeOf(context).width * 0.20,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "assets/icons/in-flag.png",
                height: 33.6,
                width: 25,
              ),
              const Text(
                "+91",
                style: TextStyle(
                  fontFamily: 'NunitoSans',
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.60,
          height: 40,
          child: TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 10,
            focusNode: phoneFocusNode,
            decoration: InputDecoration(
              counterText: "",
              errorText: null,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 10,
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                borderSide: BorderSide(
                  color: isPhoneFocused ? Colors.black : Colors.transparent,
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                borderSide: BorderSide.none,
              ),
              hintText: "Enter your mobile number",
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value) {
              // final currentState = context.read<RegisterBloc>().state;
              // if (currentState is RegisterState) {
              //   // Add event to update the bloc state
              //   context.read<RegisterBloc>().add(
              //         RegisterPageInputChangedEvent(
              //           currentState.email, // Update email
              //           currentState.password, // Update email
              //           value,
              //           currentState.role,
              //         ),
              //       );
              // }
            },
          ),
        ),
        // if (errorText != null) // Only show error text if it exists
        //   Padding(
        //     padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
        //     child: Align(
        //       alignment: Alignment.topLeft,
        //       child: Text(
        //         errorText,
        //         style: const TextStyle(
        //           color: Colors.white,
        //           fontFamily: 'NunitoSans',
        //           fontWeight: FontWeight.w100,
        //         ),
        //       ),
        //     ),
        //   ),
      ],
    ),
  );
}
  // final currentState = context.read<RegisterBloc>().state;
