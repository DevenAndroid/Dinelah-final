import 'dart:convert';
import 'dart:io';

import 'package:dinelah/routers/my_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../helper/Helpers.dart';
import '../models/ModelResponseCommon.dart';
import '../utils/ApiConstant.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ModelResponseCommon> register(
    email,
    mobileNumber,
    password,
    String socialLoginId,
    socialType,
    BuildContext context) async {

  var map = <String, dynamic>{};
  SharedPreferences pref = await SharedPreferences.getInstance();
  map['email'] = email;
  map['phone'] = mobileNumber;
  map['password'] = password;
  map['social_login_id'] = socialLoginId;
  map['social_type'] = socialType;

  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);

  print('PARAM :: 11 ${jsonEncode(map)}');

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  http.Response response = await http.post(Uri.parse(ApiUrls.registerUrl),
      body: jsonEncode(map), headers: headers);

  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    return ModelResponseCommon.fromJson(json.decode(response.body));
  } else {
    Get.offAndToNamed(MyRouter.serverErrorUi, arguments: [response.body.toString(), response.statusCode.toString()]);
    Helpers.hideLoader(loader);
    Helpers.createSnackBar(context, response.statusCode.toString());
    throw Exception(response.body);
  }
}
