import 'dart:convert';
import 'dart:io';

import 'package:dinelah/models/ModelCartQuantity.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/ModelLogIn.dart';
import '../utils/ApiConstant.dart';

Future<ModelCartQuantity> getCartCount() async {
  var map = <String, dynamic>{};
  SharedPreferences pref = await SharedPreferences.getInstance();
  if (pref.getString('user') != null) {
    ModelLogInData? user =
        ModelLogInData.fromJson(jsonDecode(pref.getString('user')!));
    map['cookie'] = user.cookie;
  } else {
    map['cookie'] = pref.getString('deviceId');
  }

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  http.Response response = await http.post(Uri.parse(ApiUrls.getCartCountUrl),
      body: jsonEncode(map), headers: headers);

  if (response.statusCode == 200) {
    return ModelCartQuantity.fromJson(json.decode(response.body));
  } else {
    Get.offAndToNamed(MyRouter.serverErrorUi, arguments: [response.body.toString(), response.statusCode.toString()]);
    throw Exception(response.body);
  }
}
