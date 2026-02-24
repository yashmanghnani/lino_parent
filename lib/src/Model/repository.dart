import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lino_parents/src/Controller/localDb.dart';
import 'package:lino_parents/src/Model/Request/login_req.dart';
import 'package:lino_parents/src/Model/Request/time_change_req.dart';
import 'package:lino_parents/src/Model/Response/chat_hostory_res.dart';
import 'package:lino_parents/src/Model/Response/login_res.dart';

final ValueNotifier<Localdb> localDb = ValueNotifier<Localdb>(Localdb());
// String baseUrl = "http://linobud.cloud:1234";
String baseUrl = "http://192.168.1.39:1234";
final headers = {
  "Content-Type": "application/json",
  "Authorization":
      'Basic ${base64Encode(utf8.encode('Q29hY2hpbmdBcHBEZXZlbG9wZWRCeVlhc2hNYW5naG5hbmk=:VGhpc1NlY3VyaXR5SXNPbnRlc3RpbmdQaGFzZQ=='))}',
};

Future<LoginResponse> loginRepo(LoginRequest request) async {
  final url = Uri.parse("$baseUrl/api/users/login");
  final response = await http.post(
    url,
    headers: headers,
    body: jsonEncode(request),
  );

  return LoginResponse.fromJson(jsonDecode(response.body));
}

Future<bool> updateTimeDurationRepo(TimeChangeReq request) async {
  try {
    final url = Uri.parse("$baseUrl/api/users/addTimeDuration");
    final response = await http.patch(
      url,
      headers: headers,
      body: jsonEncode(request),
    );
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}

Future<int?> getTimeDurationRepo(String userId) async {
  try {
    final url = Uri.parse("$baseUrl/api/users/getTimeDuration?userId=$userId");
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data["success"] == true) {
        return data["data"];
      }
    }
    return null;
  } catch (e) {
    return null;
  }
}

Future<ChatHistoryRes?> getUserChatLogsRepo(String userId) async {
  try {
    final Uri url = Uri.parse("$baseUrl/api/users/getUserChatLogs?userId=$userId");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return ChatHistoryRes.fromJson(jsonData);
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}
