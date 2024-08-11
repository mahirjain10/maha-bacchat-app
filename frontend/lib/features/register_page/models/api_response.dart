class ResponseData {
  final String email;
  final String mobileNo;
  final String role;

  ResponseData({
    required this.email,
    required this.mobileNo,
    required this.role,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      email: json['email'],
      mobileNo: json['mobile_no'],
      role: json['role'],
    );
  }
}

class RegisterResponse {
  final int statusCode;
  final String message;
  final ResponseData? data;
  final Map<String, String>? errors;
  final bool success;

  RegisterResponse({
    required this.statusCode,
    required this.message,
    this.data,
    this.errors,
    required this.success,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      statusCode: json['status'],
      message: json['message'],
      data: json['data'] != null ? ResponseData.fromJson(json['data']) : null,
      errors: json['errors'] != null
          ? Map<String, String>.from(json['errors'])
          : null,
      success: json['success'],
    );
  }
}
