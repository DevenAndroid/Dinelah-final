import 'dart:convert';
import 'dart:io';

import 'package:dinelah/helper/Helpers.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/ModelBookableEndDate.dart';
import '../utils/ApiConstant.dart';

Future<ModelBookableEndDateData> getBookableEndDate(BuildContext context,
    productId, dateYear, dateMonth, dateDay, dateTime) async {
  var map = <String, dynamic>{};
  map['product_id'] = productId;
  map['date_year'] = dateYear;
  map['date_month'] = dateMonth;
  map['date_day'] = dateDay;
  map['date_time'] = dateTime;

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  http.Response response = await http.post(
      Uri.parse(ApiUrls.getBookableEndTime),
      body: jsonEncode(map),
      headers: headers);

  print("<<<<<<<getBookableEndTime from repository=======>" +
      response.body.toString());
  if (response.statusCode == 200) {
    return ModelBookableEndDateData.fromJson(json.decode(response.body));
  } else {

    // Get.offAndToNamed(MyRouter.serverErrorUi, arguments: [response.body.toString(), response.statusCode.toString()]);
    // Helpers.hideLoader(loader);
    // Helpers.createSnackBar(context, response.body.toString());
    throw Exception(response.body);
  }
}
