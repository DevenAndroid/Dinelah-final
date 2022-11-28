import 'dart:convert';

import 'package:dinelah/helper/Helpers.dart';
import 'package:dinelah/models/model_verify_otp_forgot_password.dart';
import 'package:dinelah/utils/ApiConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<ModelVerifyOTPForgotPassword> verifySignUpOtp(
    userEmail, otp, BuildContext context) async {
  var map = <String, dynamic>{};
  map["email"] = userEmail;
  map["otp"] = otp;

  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  http.Response response = await http.post(Uri.parse(ApiUrls.emailOTPVerifyUrl),
      body: jsonEncode(map), headers: headers);
  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    return ModelVerifyOTPForgotPassword.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, response.statusCode.toString());
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}
