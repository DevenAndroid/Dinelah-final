import 'dart:convert';
import 'dart:io';

import 'package:dinelah/models/ModelAllAttributes.dart';
import 'package:dinelah/models/ModelSearchProduct.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/ModelLogIn.dart';
import '../utils/ApiConstant.dart';

Future<ModelSearchProduct> getSearchProductData(searchKeyboard, productType,
    minPrice, maxPrice, rating, sortBy, ModelAllAttributes model) async {
  var map = <String, dynamic>{};
  SharedPreferences pref = await SharedPreferences.getInstance();
  if (pref.getString('user') != null) {
    ModelLogInData? user =
        ModelLogInData.fromJson(jsonDecode(pref.getString('user')!));
    map['cookie'] = user.cookie;
  } else {
    map['cookie'] = pref.getString('deviceId');
  }
  map['search'] = searchKeyboard;
  map['product_type'] = productType;
  map['min_price'] = minPrice;
  map['max_price'] = maxPrice;
  map['rating'] = rating;
  map['sort_by'] = sortBy;
  map['attributes'] = model.data;
  map['latitude'] = pref.getString('latitude');
  map['longitude'] = pref.getString('longitude');

  pref.getString('latitude');
  pref.getString('longitude');

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
  //
  // OverlayEntry loader = Helpers.overlayLoader(context);
  // Overlay.of(context)!.insert(loader);

  http.Response response = await http.post(
      Uri.parse(ApiUrls.getSearchProductUrl),
      body: jsonEncode(map),
      headers: headers);

  if (response.statusCode == 200) {
    // Helpers.hideLoader(loader);
    return ModelSearchProduct.fromJson(json.decode(response.body));
  } else {
    if (response.statusCode != 503) {
      Get.offAndToNamed(MyRouter.serverErrorUi, arguments: [
        response.body.toString(),
        response.statusCode.toString()
      ]);
    }
    // Helpers.hideLoader(loader);
    // Helpers.createSnackBar(context, response.statusCode.toString());
    throw Exception(response.body);
  }
}
