import 'package:flutter/material.dart';
import 'package:lino_parents/src/Model/Request/login_req.dart';
import 'package:lino_parents/src/Model/Request/time_change_req.dart';
import 'package:lino_parents/src/Model/Response/login_res.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:state_extended/state_extended.dart';
import 'package:lino_parents/src/Model/repository.dart';

class AllController extends StateXController {
  factory AllController() => _this ??= AllController._();
  AllController._();

  static AllController? _this;

  Future<LoginResponse> loginContro(LoginRequest data) async {
    LoginResponse response = await loginRepo(data);
    if (response.success!) {
      localDb.value.uid = response.data!.sId;
      localDb.value.mobile = response.data!.mobile;
      localDb.value.password = response.data!.password;
      localDb.value.parentName = response.data!.name;
      localDb.value.childName = response.data!.kidsName;
      storeDataLocally();
    }
    return response;
  }

  Future<void> storeDataLocally() async {
    SharedPreferences? sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("uid", localDb.value.uid!);
    sharedPreferences.setString("mobile", localDb.value.mobile!);
    sharedPreferences.setString("password", localDb.value.password!);
    sharedPreferences.setString("parentName", localDb.value.parentName!);
    sharedPreferences.setString("childName", localDb.value.childName!);
  }

  Future<void> getDataLocally() async {
    SharedPreferences? sharedPreferences =
        await SharedPreferences.getInstance();
    try {
      localDb.value.uid = sharedPreferences.getString("uid")!;
      localDb.value.mobile = sharedPreferences.getString("mobile")!;
      localDb.value.password = sharedPreferences.getString("password")!;
      localDb.value.parentName = sharedPreferences.getString("parentName")!;
      localDb.value.childName = sharedPreferences.getString("childName")!;
    } catch (e) {
      localDb.value.uid = "";
      localDb.value.mobile = "";
      localDb.value.password = "";
      localDb.value.parentName = "";
      localDb.value.childName = "";
    }
  }

  Future<void> clearDataLocally() async {
    SharedPreferences? sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.clear();
    localDb.value.uid = "";
    localDb.value.mobile = "";
    localDb.value.password = "";
    localDb.value.parentName = "";
    localDb.value.childName = "";
  }

  Future<bool> saveTimeDurationContro(int hour, int minute) async {
    final int totalMinutes = (hour * 60) + minute;
    TimeChangeReq request = TimeChangeReq(
      userId: localDb.value.uid!,
      minutes: totalMinutes,
    );
    final success = await updateTimeDurationRepo(request);
    return success;
  }
}
