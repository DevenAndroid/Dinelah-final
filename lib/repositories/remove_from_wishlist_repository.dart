import 'dart:convert';
import 'dart:io';

import 'package:dinelah/models/ModelResponseCommon.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper/Helpers.dart';
import '../models/ModelLogIn.dart';
import '../utils/ApiConstant.dart';

Future<ModelResponseCommon> removeFromWishlist(BuildContext context, productId ) async {

  var map = <String, dynamic>{};
  SharedPreferences pref = await SharedPreferences.getInstance();
  if(pref.getString('user')!=null){
    ModelLogInData? user = ModelLogInData.fromJson(jsonDecode(pref.getString('user')!));
    map['cookie'] = user.cookie;
  }else {
    map['cookie'] = pref.getString('deviceId');
  }
  map['product_id'] = productId;

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);

  http.Response response = await http.post(Uri.parse(ApiUrls.removeFromWishListUrl),
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