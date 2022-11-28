import 'dart:convert';
import 'dart:io';

import 'package:dinelah/helper/Helpers.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/ApiConstant.dart';
import '../models/ModelLogIn.dart';
import '../models/ModelResponseCommon.dart';

Future<ModelResponseCommon> cancelMyBooking(BuildContext context, bookingId) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelLogInData? user =
      ModelLogInData.fromJson(jsonDecode(pref.getString('user')!));

  var map = <String, dynamic>{};
  map['cookie'] = user.cookie;
  map['booking_id'] = bookingId;

  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
  http.Response response = await http.post(
      Uri.parse(ApiUrls.cancelMyBookingUrl),
      body: jsonEncode(map),
      headers: headers);

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
