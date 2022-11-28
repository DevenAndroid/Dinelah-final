import 'dart:convert';

import 'package:dinelah/helper/Helpers.dart';
import 'package:dinelah/models/ModelResponseCommon.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../utils/ApiConstant.dart';

Future<ModelResponseCommon> updatePassword(
    email, newPassword, confirmPassword, BuildContext context) async {
  var map = <String, dynamic>{};
  map["email"] = email;
  map["new_password"] = newPassword;
  map["confirm_password"] = confirmPassword;

  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  http.Response response = await http.post(Uri.parse(ApiUrls.updatePasswordUrl),
      body: jsonEncode(map), headers: headers);

  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    return ModelResponseCommon.fromJson(json.decode(response.body));
  } else {
    Get.offAndToNamed(MyRouter.serverErrorUi, arguments: [response.body.toString(), response.statusCode.toString()]);
    Helpers.createSnackBar(context, response.statusCode.toString());
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}
