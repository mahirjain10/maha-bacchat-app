import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class PostDataUIModel {
  final String email;
  final String password;
  final String mobileNo;
  final String role;
  PostDataUIModel({
    required this.email,
    required this.password,
    required this.mobileNo,
    required this.role,
  });

  //converting object into map like json
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'mobile_no': mobileNo,
      'role': role
    };
  }

  // converting the map to json
  String toJson() => json.encode(toMap());
}
