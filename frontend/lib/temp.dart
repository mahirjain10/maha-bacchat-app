import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

void main() async {
  var client = http.Client();
  var url =
      'http://192.168.238.128:8000/register'; // Replace with your local IP address

  try {
    print("Attempting to send post request to $url");
    var response = await client.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": "testdist@gmail.com",
        "password": "testdist30",
        "mobile_no": "9152077168",
        "role": "distributor"
      }),
    );

    print("Request sent");
    print('Status code: ${response.statusCode}');
    print('Response headers: ${response.headers}');
    print('Response body: ${response.body}');
  } catch (e) {
    print(e);
    log('Exception caught: $e');
  } finally {
    client.close();
    print("HTTP client closed");
  }
}
