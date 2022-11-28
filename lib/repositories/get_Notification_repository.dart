import 'dart:convert';
import 'dart:io';

import 'package:dinelah/models/ModelNotification.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/ModelLogIn.dart';
import '../utils/ApiConstant.dart';

Future<ModelNotificationData> getNotificationData() async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  var map = <String, dynamic>{};
  if (pref.getString('user') != null) {
    ModelLogInData? user =
        ModelLogInData.fromJson(jsonDecode(pref.getString('user')!));
    map['cookie'] = user.cookie;
  }
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  http.Response response = await http.post(
      Uri.parse(ApiUrls.getNotificationUrl),
      body: jsonEncode(map),
      headers: headers);

  if (response.statusCode == 200) {
    return ModelNotificationData.fromJson(json.decode(response.body));
  } else {
    Get.offAndToNamed(MyRouter.serverErrorUi,
        arguments: [response.body.toString(), response.statusCode.toString()]);
    throw Exception(response.body);
  }
}
