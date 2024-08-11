import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/register_page/register_bloc/register_bloc.dart';
import 'package:frontend/features/register_page/register_bloc/register_event.dart';
import 'package:frontend/features/register_page/register_bloc/register_service_state.dart';

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(
          fontFamily: 'NunitoSans',
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 17,
        ),
      ),
    );

Widget buildRolesDropDown(BuildContext context) {
  final roles = ['Distributor', 'Wholesaler', 'Retailer', 'Reseller'];
  final currentState = context.read<RegisterBloc>().state;

  return BlocBuilder<RegisterBloc, RegisterPageState>(
    builder: (context, state) {
      String? selectedRole;
      if (state is RegisterState) {
        selectedRole =
            state.role; // assuming role is a property in RegisterState
      }
      debugPrint("selected role from line 33 : $selectedRole");
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              // Uncomment the border if you want to show validation errors
              // border: Border.all(
              //     color: state.errorState.roleError == null
              //         ? Colors.black
              //         : Colors.red,
              //     width: 1),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                padding: const EdgeInsets.only(left: 15),
                value: selectedRole == null || selectedRole.isEmpty
                    ? null
                    : selectedRole,
                hint: const Text("Choose a role"),
                dropdownColor: Colors.white,
                iconSize: 30,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
                isExpanded: true,
                items: roles.map(buildMenuItem).toList(),
                onChanged: (value) {
                  debugPrint(
                      "selected role from on changed func : $selectedRole");
                  if (currentState is RegisterState) {
                    context.read<RegisterBloc>().add(
                          RegisterPageInputChangedEvent(
                            currentState.email, // Update email
                            currentState.password,
                            currentState.mobileNo,
                            value!,
                          ),
                        );
                  }
                },
              ),
            ),
          ),
          // Uncomment the following if you want to show validation errors
          // if (state.errorState.roleError != null)
          //   Padding(
          //     padding: const EdgeInsets.only(left: 10, top: 5),
          //     child: Text(
          //       state.errorState.roleError,
          //       style: const TextStyle(color: Colors.red, fontSize: 12),
          //     ),
          //   ),
        ],
      );
    },
  );
}
