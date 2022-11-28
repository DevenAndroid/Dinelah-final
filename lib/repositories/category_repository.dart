import 'dart:convert';
import 'dart:io';

import 'package:dinelah/routers/my_router.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../models/ModelCategoryData.dart';
import '../utils/ApiConstant.dart';

Future<ModelCategoryData> getCategoryData( ) async {
  var map = <String, dynamic>{};
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  http.Response response = await http.post(Uri.parse(ApiUrls.getCategoryUrl),
      body: jsonEncode(map), headers: headers);

  if (response.statusCode == 200) {
    return ModelCategoryData.fromJson(json.decode(response.body));
  } else {
    Get.offAndToNamed(MyRouter.serverErrorUi, arguments: [response.body.toString(), response.statusCode.toString()]);
    throw Exception(response.body);
  }
}