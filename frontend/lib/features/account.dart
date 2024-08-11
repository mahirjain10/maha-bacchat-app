import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:frontend/features/login_page.dart';
import 'package:frontend/features/orders.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/image_picker.dart'; // Make sure this imports your custom pickImage function

class OrderOption {
  final String iconPath;
  final String headerText;
  final String subText;

  OrderOption({
    required this.iconPath,
    required this.headerText,
    required this.subText,
  });
}

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AccountPageState();
  }
}

class _AccountPageState extends State<AccountPage> {
  Uint8List? _image;

  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Profile",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 35,
          )),
      toolbarHeight: MediaQuery.sizeOf(context).height * 0.1,
    );
  }

  Widget buildImagePicker() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: _image != null
              ? MemoryImage(_image!) // Display selected image
              : const AssetImage("assets/icons/grocery_store.jpg")
                  as ImageProvider,
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              onPressed: selectImage, // Open image picker on press
              icon: const Icon(Icons.add_a_photo),
            ))
      ],
    );
  }

  Widget profileCard(BuildContext context) {
    return Center(
      child: Card(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(15.0), // Optional: adds rounded corners
            side: const BorderSide(
              color: Colors.black, // Border color
              width: 2.0, // Border width
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 15, bottom: 20),
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.95,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pramanik Stores",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Row(
                    children: [
                      buildImagePicker(),
                      const Padding(padding: EdgeInsets.only(left: 15)),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mahir Jain",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "+91 9012525741",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "mahirjain@pramanik.com",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget optionsWidget(OrderOption option) {
    return Column(
      children: [
        const Divider(
          color: Colors.black,
          thickness: 2,
        ),
        TextButton(
          onPressed: () {
            // Navigate to Screen2 when the button is tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OrdersPage()),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(left: 20)),
              Image.asset(option.iconPath),
              const Padding(padding: EdgeInsets.only(left: 15)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option.headerText,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      option.subText,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildBody(BuildContext context) {
    final options = [
      OrderOption(
        iconPath: "assets/icons/paper.png",
        headerText: "Your Orders",
        subText: "View all past orders",
      ),
      OrderOption(
        iconPath: "assets/icons/user_add.png",
        headerText: "Your Bacchat Requests",
        subText: "View all past bacchat requests",
      ),
      OrderOption(
        iconPath: "assets/icons/store.png",
        headerText: "Store Status And Business Hours",
        subText: "View and edit store status and business hours",
      ),
      OrderOption(
        iconPath: "assets/icons/faq.png",
        headerText: "Support/FAQs",
        subText: "Frequently asked questions",
      ),
    ];

    return Column(
      children: [
        profileCard(context),
        const Padding(padding: EdgeInsets.only(top: 50)),
        Expanded(
          child: ListView(
            children: options.map((option) => optionsWidget(option)).toList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }
}
