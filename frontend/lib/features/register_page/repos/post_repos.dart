import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:frontend/features/register_page/models/api_response.dart';
import 'package:frontend/features/register_page/register_bloc/register_service_state.dart';
import 'package:frontend/features/register_page/utils/response.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/features/register_page/models/post_model.dart';

class PostRepos {
  static Future<RegisterResponse?> addPost(
      String email, String password, String mobileNo, String role) async {
    var client = http.Client();

    PostDataUIModel postDataUIModel = PostDataUIModel(
        email: email, password: password, mobileNo: mobileNo, role: role);
    Map<String, dynamic> json = postDataUIModel.toMap();

    var url = 'http://192.168.238.128:8000/register';

    try {
      print("servuce loading emitted");

      print(jsonEncode(json));

      await Future.delayed(const Duration(seconds: 5), () {
        print("delaying");
      });

      var response = await client.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(json));

      print("Request sent");
      print('Status code: ${response.statusCode}');
      print('Response headers: ${response.headers}');
      print('Response body: ${response.body}');

      Map<String, dynamic> jsonMap = jsonDecode(response.body);
      RegisterResponse apiResponse = RegisterResponse.fromJson(jsonMap);
      return apiResponse;
    } catch (e, stackTrace) {
      debugPrint('Exception caught: $e');
      debugPrint('Stack trace: $stackTrace');
    } finally {
      client.close(); // Ensure the client is closed to free resources
      print("HTTP client closed");
    }
    return null;
  }
}
