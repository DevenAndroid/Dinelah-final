import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/Helpers.dart';
import '../models/ModelLogIn.dart';
import '../models/ModelResponseCommon.dart';
import '../utils/ApiConstant.dart';

Future<ModelResponseCommon> getBookableAddToCartData(
  BuildContext context,
  productId,
  quantity,
  dateYear,
  dateMonth,
  dateDay,
  dateTime,
  value_1_id,
  value_1_qty,
  value_2_id,
  value_2_qty,
  startTime,
  endTime,
  resourcesId,
    monthsFieldDuration,
    dateYearMonth
) async {
  var map = <String, dynamic>{};
  SharedPreferences pref = await SharedPreferences.getInstance();
  if (pref.getString('user') != null) {
    ModelLogInData? user =
        ModelLogInData.fromJson(jsonDecode(pref.getString('user')!));
    map['cookie'] = user.cookie;
  } else {
    map['cookie'] = pref.getString('deviceId');
  }

  map['product_id'] = productId;
  map['quantity'] = quantity;
  map['date_year'] = dateYear;
  map['date_month'] = dateMonth;
  map['date_day'] = dateDay;
  map['date_time'] = dateTime;
  map['value_1_id'] = value_1_id;
  map['value_1_qty'] = value_1_qty;
  map['value_2_id'] = value_2_id;
  map['value_2_qty'] = value_2_qty;
  map['value_2_qty'] = value_2_qty;
  map['start_time'] = startTime;
  map['end_time'] = endTime;
  map['resource_id'] = resourcesId.toString().replaceAll("#", '').split('-')[0];
  map['months_field_duration'] = monthsFieldDuration;
  map['date_yearmonth'] = dateYearMonth;


  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);

  http.Response response = await http.post(
      Uri.parse(ApiUrls.getBookableAddToCart),
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
