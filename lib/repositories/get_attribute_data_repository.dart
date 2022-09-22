import 'dart:convert';

import 'package:dinelah/models/ModelAllAttributes.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:dinelah/utils/ApiConstant.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

Future<ModelAllAttributes> getAllAttributes() async {
  http.Response response =
      await http.post(Uri.parse(ApiUrls.getAllAttributesUrl));

  if (response.statusCode == 200) {
    return ModelAllAttributes.fromJson(json.decode(response.body));
  } else {
    Get.offAndToNamed(MyRouter.serverErrorUi, arguments: [response.body.toString(), response.statusCode.toString()]);
    throw Exception(response.body);
  }
}
