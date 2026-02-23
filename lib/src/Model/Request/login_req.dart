class LoginRequest {
  String? mobile;
  String? password;

  LoginRequest({this.mobile, this.password});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobile'] = mobile;
    data['password'] = password;
    return data;
  }
}
