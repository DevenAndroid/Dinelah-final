import 'dart:convert';
import 'dart:io';

import 'package:dinelah/routers/my_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../helper/Helpers.dart';
import '../models/ModelGetProductVariation.dart';
import '../utils/ApiConstant.dart';

Future<ModelGetProductVariationData> getProductVariationsData(BuildContext context, productId ) async {
  var map = <String, dynamic>{};
  map['product_id'] = productId;

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  http.Response response = await http.post(Uri.parse(ApiUrls.getProductVariationUrl),
      body: jsonEncode(map), headers: headers);

  if (response.statusCode == 200) {
    return ModelGetProductVariationData.fromJson(json.decode(response.body));
  } else {
    Get.offAndToNamed(MyRouter.serverErrorUi, arguments: [response.body.toString(), response.statusCode.toString()]);
    Helpers.createSnackBar(context, response.statusCode.toString());
    throw Exception(response.body);
  }
}