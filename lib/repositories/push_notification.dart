import 'dart:convert';
import 'package:dinelah/models/ModelLogIn.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import '../utils/ApiConstant.dart';

Future<dynamic> pushNotification(receiverId, title, message, receiverDetails, receiverType, orderId) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelLogInData? user =
  ModelLogInData.fromJson(jsonDecode(pref.getString('user')!));
  var map = <String, dynamic>{};
  map['cookie'] = user.cookie;
  map['sender_id'] = user.cookie;
  map['receiver_id'] = receiverId;
  map['title'] = title;
  map['message'] = message;
  map['receiver_details'] = receiverDetails;
  map['receiver_type'] = receiverType;
  map['order_id'] = orderId;

  http.Response response = await http.post(Uri.parse(ApiUrls.chatSendNotificationUrl),
  body: jsonEncode(map), headers: headers);

  debugPrint('CHAT :: ${jsonEncode(map)}');
  debugPrint('CHAT :: ${response.body}');
  debugPrint('CHAT :: 11  ${user.user!.id.toString()}');
  
  if (response.statusCode == 200) {
    return ((response.body));
  } else {
    throw Exception(response.body);
  }
}