import 'dart:convert';
import 'dart:io';

import 'package:dinelah/models/ModelResponseCommon.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../helper/Helpers.dart';
import '../models/ModelLogIn.dart';
import '../utils/ApiConstant.dart';

Future<ModelResponseCommon> updateAddress(
    BuildContext context,
    firstName,
    lastName,
    billingAddress1,
    billingAddress2,
    billingPostcode,
    billingCity,
    billingPhone,
    billingEmail,
    shippingFirstname,
    shippingLastname,
    shippingAddress1,
    shippingAddress2,
    shippingPostcode,
    shippingCity) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelLogInData? user =
      ModelLogInData.fromJson(jsonDecode(pref.getString('user')!));
  var map = <String, dynamic>{};
  map['cookie'] = user.cookie;
  map['billing_first_name'] = firstName;
  map['billing_last_name'] = lastName;
  map['billing_address_1'] = billingAddress1;
  map['billing_address_2'] = billingAddress2;
  map['billing_postcode'] = billingPostcode;
  map['billing_city'] = billingCity;
  map['billing_phone'] = billingPhone;
  map['billing_email'] = billingEmail;
  map['shipping_first_name'] = shippingFirstname;
  map['shipping_last_name'] = shippingLastname;
  map['shipping_address_1'] = shippingAddress1;
  map['shipping_address_2'] = shippingAddress2;
  map['shipping_postcode'] = shippingPostcode;
  map['shipping_city'] = shippingCity;

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);

  http.Response response = await http.post(Uri.parse(ApiUrls.updateAddressUrl),
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
