import 'dart:convert';
import 'dart:io';

import 'package:dinelah/models/ModelLogIn.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/ModelGetCart.dart';
import '../routers/my_router.dart';
import '../utils/ApiConstant.dart';

Future<ModelGetCartData> getCartData() async {

   var map = <String, dynamic>{};
   SharedPreferences pref = await SharedPreferences.getInstance();
   // ModelLogInData? user = ModelLogInData.fromJson(jsonDecode(pref.getString('user')!));
   map['cookie'] = pref.getString('user')!=null ? ModelLogInData.fromJson(jsonDecode(pref.getString('user')!)).cookie : pref.getString('deviceId');


  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  http.Response response = await http.post(Uri.parse(ApiUrls.getCartUrl),
      body: jsonEncode(map), headers: headers);

  if (response.statusCode == 200) {
    return ModelGetCartData.fromJson(json.decode(response.body));
  } else {
    Get.offAndToNamed(MyRouter.serverErrorUi, arguments: [response.body.toString(), response.statusCode.toString()]);
    throw Exception(response.body);
  }
}