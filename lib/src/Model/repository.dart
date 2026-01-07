import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lino_parents/src/Model/Request/login_req.dart';
import 'package:lino_parents/src/Model/Response/login_res.dart';

class AuthRepository {

  Future<LoginResponse> login(LoginRequest request) async {
    final baseUrl = "http://technoparticles.cloud:1234/api";
    final url = Uri.parse("$baseUrl/users/login");

    const String basicUser = "Q29hY2hpbmdBcHBEZXZlbG9wZWRCeVlhc2hNYW5naG5hbmk=";
    const String basicPass = "VGhpc1NlY3VyaXR5SXNPbnRlc3RpbmdQaGFzZQ==";

    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$basicUser:$basicPass'))}';

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": basicAuth,
      },
      body: jsonEncode(request.toJson()),
    );

    return LoginResponse.fromJson(jsonDecode(response.body));
  }
}
