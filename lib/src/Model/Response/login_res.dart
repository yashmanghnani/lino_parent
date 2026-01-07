class LoginResponse {
  final bool success;
  final String msg;
  final dynamic data;

  LoginResponse({
    required this.success,
    required this.msg,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json["success"] ?? false,
      msg: json["msg"] ?? "",
      data: json["data"],
    );
  }
}
