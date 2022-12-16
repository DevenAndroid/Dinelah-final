import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dinelah/routers/my_router.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../helper/Helpers.dart';
import '../models/ModelLogIn.dart';
import '../models/ModelStoreInfo.dart';
import '../utils/ApiConstant.dart';

Future<ModelStoreInfoData> getStoreInfo(storeId, {
  required perPage,
  required pageCount,
  BuildContext? context
}) async {

  OverlayEntry loader = Helpers.overlayLoader(context);
  if(context != null){
    Overlay.of(context)!.insert(loader);
  }
  try {
    var map = <String, dynamic>{};
    SharedPreferences pref = await SharedPreferences.getInstance();
    // ModelLogInData? user = ModelLogInData.fromJson(jsonDecode(pref.getString('user')!));
    map['cookie'] = pref.getString('user') != null ? ModelLogInData
        .fromJson(jsonDecode(pref.getString('user')!))
        .cookie : pref.getString('deviceId');
    map['store_id'] = storeId;
    map['per_page'] = perPage;
    map['page'] = pageCount;

    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };

    log("host api map...  $map");
    http.Response response = await http.post(Uri.parse(ApiUrls.getStoreInfoUrl),
        body: jsonEncode(map), headers: headers);

    log("host api response ${response.body}");

    Helpers.hideLoader(loader);

    if (response.statusCode == 200) {
      return ModelStoreInfoData.fromJson(json.decode(response.body));
    } else {
      Get.offAndToNamed(MyRouter.serverErrorUi, arguments: [
        response.body.toString(),
        response.statusCode.toString()
      ]);
      throw Exception(response.body);
    }
  } on SocketException{
    Helpers.hideLoader(loader);
    showToast("No Internet Connection");
    throw Exception();
  } catch (e){
    Helpers.hideLoader(loader);
    showToast("Something went wrong... try again later");
    throw Exception(e);
  }
}