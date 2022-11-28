import 'dart:convert';
import 'dart:io';

import 'package:dinelah/routers/my_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/ModelLogIn.dart';
import '../models/ModelSingleOrder.dart';
import '../utils/ApiConstant.dart';

Future<ModelSingleOrderData> getSingleOrderData(orderId) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelLogInData? user =
      ModelLogInData.fromJson(jsonDecode(pref.getString('user')!));
  var map = <String, dynamic>{};
  map['cookie'] = user.cookie;
  map['order_id'] = orderId;

  debugPrint('SINGLE ORDER RESPONSE :: ${jsonEncode(map)}');
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  http.Response response = await http.post(Uri.parse(ApiUrls.getSingleOrderUrl),
      body: jsonEncode(map), headers: headers);

  debugPrint('SINGLE ORDER RESPONSE :: ${response.body}');
  if (response.statusCode == 200) {
    return ModelSingleOrderData.fromJson(json.decode(response.body));
  } else {
    Get.offAndToNamed(MyRouter.serverErrorUi, arguments: [response.body.toString(), response.statusCode.toString()]);
    throw Exception(response.body);
  }
}
