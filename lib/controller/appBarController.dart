import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/ModelLogIn.dart';
class AppBarController extends GetxController{
  String? userName;
  String? userEmail;
  String? userImage;

  initData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('user') != null){
      ModelLogInData? user = ModelLogInData.fromJson(jsonDecode(pref.getString('user')!));
      userName = user.user!.username;
      userEmail = user.user!.email;
      userImage = user.user!.url;
    }
  }
  @override
  void onInit() {
    super.onInit();
    initData();
  }
}