import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../helper/Helpers.dart';
import '../models/ModelCategoryProducts.dart';
import '../routers/my_router.dart';
import '../utils/ApiConstant.dart';

Future<ModelCategoryProductData> getCategoryProductData(categoryId, {
  required perPage,
  required pageCount,
  BuildContext? context
} ) async {

  OverlayEntry loader = Helpers.overlayLoader(context);
  if(context != null){
    Overlay.of(context)!.insert(loader);
  }

  try {
    var map = <String, dynamic>{};
    map['category'] = categoryId;
    map['per_page'] = perPage;
    map['page'] = pageCount;

    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };

    log("Products Category... Map... $map");

    http.Response response = await http.post(
        Uri.parse(ApiUrls.getCategoryProductUrl),
        body: jsonEncode(map), headers: headers);

    log("Products Category... Response... ${response.body}");
    Helpers.hideLoader(loader);

    if (response.statusCode == 200) {
      return ModelCategoryProductData.fromJson(json.decode(response.body));
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