import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../models/ModelCategoryProducts.dart';
import '../routers/my_router.dart';
import '../utils/ApiConstant.dart';

Future<ModelCategoryProductData> getCategoryProductData(categoryId ) async {
  var map = <String, dynamic>{};
  map['category'] = categoryId;
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  http.Response response = await http.post(Uri.parse(ApiUrls.getCategoryProductUrl),
      body: jsonEncode(map), headers: headers);

  if (response.statusCode == 200) {
    return ModelCategoryProductData.fromJson(json.decode(response.body));
  } else {
    Get.offAndToNamed(MyRouter.serverErrorUi, arguments: [response.body.toString(), response.statusCode.toString()]);
    throw Exception(response.body);
  }
}