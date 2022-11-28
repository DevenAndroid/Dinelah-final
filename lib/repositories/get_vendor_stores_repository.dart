import 'dart:convert';
import 'dart:io';

import 'package:dinelah/models/ModelVendorStore.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../utils/ApiConstant.dart';

Future<ModelVendorStores> getVendorStores(map) async {
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
  http.Response response = await http.post(Uri.parse(ApiUrls.vendorStoresUrl),
      body: jsonEncode(map), headers: headers);

  debugPrint('REQUEST PARAMETER :: ${jsonEncode(map)}');
  debugPrint('REQUEST PARAMETER ::11 ${response.body}');
  if (response.statusCode == 200) {
    return ModelVendorStores.fromJson(json.decode(response.body));
  } else {
    Get.offAndToNamed(MyRouter.serverErrorUi, arguments: [response.body.toString(), response.statusCode.toString()]);
    throw Exception(response.body);
  }
}
