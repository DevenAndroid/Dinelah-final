import 'dart:convert';
import 'dart:io';
import 'package:dinelah/models/ModelSocialResponse.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../helper/Helpers.dart';
import '../utils/ApiConstant.dart';

Future<ModelSocialResponse> getSocialLogin(
    BuildContext context,
    socialLoginId,
    socialType,
    device_id,
    user_mail,
    fcm_token,
    ) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
try {
  var map = <String, dynamic>{};
  map['social_login_id'] = socialLoginId;
  map['social_type'] = socialType;
  map['device_id'] = device_id;
  map['user_mail'] = user_mail;
  map['fcm_token'] = fcm_token;

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  print("map value... ${map.toString()}");

  http.Response response = await http.post(Uri.parse(ApiUrls.socialApiUrl),
      body: jsonEncode(map), headers: headers);

  print('PARAM :: ${jsonEncode(map)}');
  print('RESPONSE :: ${json.decode(response.body)}');
  Helpers.hideLoader(loader);

  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    return ModelSocialResponse.fromJson(json.decode(response.body));
  } else {
    Get.offAndToNamed(MyRouter.serverErrorUi,
        arguments: [response.body.toString(), response.statusCode.toString()]);
    Helpers.createSnackBar(context, response.statusCode.toString());
    throw Exception(response.body);
  }
} on SocketException catch(e){
  Helpers.hideLoader(loader);
  showToast("No Internet Connection");
  throw Exception(e);
} catch(e){
  Helpers.hideLoader(loader);
  showToast("Something went wrong...");
  throw Exception();
}
}