class LoginResponse {
  bool? success;
  String? msg;
  User? data;

  LoginResponse({this.success, this.msg, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json["success"],
      msg: json["msg"],
      data: json["data"] != null ? User.fromJson(json["data"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {"success": success, "msg": msg, "data": data?.toJson()};
  }
}

class User {
  String? guardianType;
  String? name;
  String? country;
  String? city;
  String? mobile;
  String? email;
  String? password;
  String? kidsName;
  String? gender;
  String? month;
  String? year;
  bool? learnLock;
  bool? playLock;
  Otp? emailOtp;
  Otp? phoneOtp;
  String? createdAt;
  String? loginLogsId;
  String? sId;
  int? iV;

  User({
    this.guardianType,
    this.name,
    this.country,
    this.city,
    this.mobile,
    this.email,
    this.password,
    this.kidsName,
    this.gender,
    this.month,
    this.year,
    this.learnLock,
    this.playLock,
    this.emailOtp,
    this.phoneOtp,
    this.createdAt,
    this.loginLogsId,
    this.sId,
    this.iV,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      guardianType: json["guardianType"],
      name: json["name"],
      country: json["country"],
      city: json["city"],
      mobile: json["mobile"],
      email: json["email"],
      password: json["password"],
      kidsName: json["kidsName"],
      gender: json["gender"],
      month: json["month"],
      year: json["year"],
      learnLock: json["learnLock"],
      playLock: json["playLock"],
      emailOtp: json["emailOtp"] != null
          ? Otp.fromJson(json["emailOtp"])
          : null,
      phoneOtp: json["phoneOtp"] != null
          ? Otp.fromJson(json["phoneOtp"])
          : null,
      createdAt: json["createdAt"],
      loginLogsId: json["loginLogsId"],
      sId: json["_id"],
      iV: json["__v"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "guardianType": guardianType,
      "name": name,
      "country": country,
      "city": city,
      "mobile": mobile,
      "email": email,
      "password": password,
      "kidsName": kidsName,
      "gender": gender,
      "month": month,
      "year": year,
      "playLock": playLock,
      "learnLock": learnLock,
      "emailOtp": emailOtp?.toJson(),
      "phoneOtp": phoneOtp?.toJson(),
      "createdAt": createdAt,
      "loginLogsId": loginLogsId,
      "_id": sId,
      "__v": iV,
    };
  }
}

class Otp {
  String? otp;
  bool? isVerified;
  int? expiresAt;

  Otp({this.otp, this.isVerified, this.expiresAt});

  factory Otp.fromJson(Map<String, dynamic> json) {
    return Otp(
      otp: json["otp"],
      isVerified: json["isVerified"],
      expiresAt: json["expiresAt"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"otp": otp, "isVerified": isVerified, "expiresAt": expiresAt};
  }
}
