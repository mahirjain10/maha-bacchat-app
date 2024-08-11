import 'package:flutter/material.dart';

class InputOption {
  final String hintText;
  final String iconPath;
  final ValueChanged<String> onChanged;
  late TextEditingController controller;
  bool obscureText = false;

  InputOption(
      {required this.hintText,
      required this.iconPath,
      required this.onChanged,
      required TextEditingController controller,
      required this.obscureText});
}

// Widget buildInputBar(TextEditingController myController, BuildContext context,
//     InputOption option, String? errorText, bool isValid) {
Widget buildInputBar(BuildContext context, InputOption option) {
  return Column(
    mainAxisSize: MainAxisSize.min, // Minimize height to fit content
    children: [
      Container(
        color: Colors.amber,
        width: MediaQuery.of(context).size.width * 0.8,
        height: 40,
        child: TextFormField(
          obscureText: option.obscureText,
          validator: (value) {
            debugPrint(value);
          },
          onChanged: option.onChanged,
          decoration: InputDecoration(
            errorText: null,
            // No error text here, handled separately
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.black),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none,
            ),
            hintText: option.hintText,
            filled: true,
            fillColor: Colors.white,
            suffixIcon: ImageIcon(AssetImage(option.iconPath)),
          ),
        ),
      ),
      // if ((errorText != null || errorText != "") &&
      //     !isValid) // Only show error text if it exists
      //   Padding(
      //     padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      //     child: Align(
      //       alignment: Alignment.topLeft,
      //       child: Text(
      //         errorText!,
      //         style: const TextStyle(
      //           color: Colors.white,
      //           fontFamily: 'NunitoSans',
      //           fontWeight: FontWeight.w100,
      //         ),
      //       ),
      //     ),
      //   ),
    ],
  );
}
