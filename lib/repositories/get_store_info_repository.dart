import 'dart:convert';
import 'dart:io';

import 'package:dinelah/routers/my_router.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../models/ModelLogIn.dart';
import '../models/ModelStoreInfo.dart';
import '../utils/ApiConstant.dart';

Future<ModelStoreInfoData> getStoreInfo(storeId ) async {

  var map = <String, dynamic>{};
  SharedPreferences pref = await SharedPreferences.getInstance();
    // ModelLogInData? user = ModelLogInData.fromJson(jsonDecode(pref.getString('user')!));
  map['cookie'] = pref.getString('user')!=null ? ModelLogInData.fromJson(jsonDecode(pref.getString('user')!)).cookie : pref.getString('deviceId');
  map['store_id'] = storeId;

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  http.Response response = await http.post(Uri.parse(ApiUrls.getStoreInfoUrl),
      body: jsonEncode(map), headers: headers);

  if (response.statusCode == 200) {
    return ModelStoreInfoData.fromJson(json.decode(response.body));
  } else {
    Get.offAndToNamed(MyRouter.serverErrorUi, arguments: [response.body.toString(), response.statusCode.toString()]);
    throw Exception(response.body);
  }
}