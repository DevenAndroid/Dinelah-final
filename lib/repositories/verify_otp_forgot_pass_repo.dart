import 'dart:convert';

import 'package:dinelah/models/model_verify_otp_forgot_password.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:dinelah/utils/ApiConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../helper/Helpers.dart';

Future<ModelVerifyOTPForgotPassword> verifyOTPPassword(
    userEmail, otp, BuildContext context) async {
  var map = <String, dynamic>{};
  map["user_login"] = userEmail;
  map["otp"] = otp;

  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  http.Response response = await http.post(
      Uri.parse(ApiUrls.forgotPasswordOTPVerifyUrl),
      body: jsonEncode(map),
      headers: headers);
  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    return ModelVerifyOTPForgotPassword.fromJson(json.decode(response.body));
  } else {
    Get.offAndToNamed(MyRouter.serverErrorUi,
        arguments: [response.body.toString(), response.statusCode.toString()]);
    Helpers.createSnackBar(context, response.statusCode.toString());
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}
