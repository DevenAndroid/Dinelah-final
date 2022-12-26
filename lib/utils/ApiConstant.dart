import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dinelah/res/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiUrls {
  //https://dinelah.com (old)
  static const String domainName = 'https://dinelah.com/';
  static const String apiBaseUrl = '${domainName}wp-json/api/';
  static const String loginUrl =
      "${apiBaseUrl}woocustomer/generate_auth_cookie/";
  static const String registerUrl = "${apiBaseUrl}woocustomer/register";
  static const String forgotPasswordUrl =
      "${apiBaseUrl}woocustomer/forgot_password";
  static const String vendorStoresUrl = "${apiBaseUrl}vendor/stores";
  static const String homeDataUrl = "${apiBaseUrl}woohomepage/get_home_data";
  static const String getCartUrl = "${apiBaseUrl}woocustomer/get_cart";
  static const String getUpdateCartUrl = "${apiBaseUrl}woocustomer/update_cart";
  static const String getOrdersUrl = "${apiBaseUrl}woocustomer/get_orders";
  static const String getMyBookingUrl =
      "${apiBaseUrl}woocustomer/get_my_bookings";
  static const String getSingleOrderUrl =
      "${apiBaseUrl}woocustomer/single_order";
  static const String getNotificationUrl =
      "${apiBaseUrl}woocustomer/notifications";
  static const String getAddressUrl = "${apiBaseUrl}woocustomer/get_addresses";
  static const String updateAddressUrl =
      "${apiBaseUrl}woocustomer/update_addresses";
  static const String changePasswordUrl = "${apiBaseUrl}woocustomer/change_password";
  static const String deleteUserAccountUrl = "${apiBaseUrl}woocustomer/delete_user_account";


  static const String getSingleProductUrl = "${apiBaseUrl}woo_api/get_product";
  static const String getProductVariationUrl =
      "${apiBaseUrl}woo_api/get_product_variations";
  static const String getProfileFieldUrl =
      "${apiBaseUrl}woocustomer/get_profile_fields";
  static const String updateProfileFieldUrl =
      "${apiBaseUrl}woocustomer/update_profile_fields";
  static const String socialApiUrl = "${apiBaseUrl}woocustomer/social_login";
  static const String getCategoryProductUrl =
      "${apiBaseUrl}woo_api/category_products";
  static const String getCategoryUrl = "${apiBaseUrl}woo_api/categories";
  static const String getSearchProductUrl =
      "${apiBaseUrl}woo_api/search_product";
  static const String getStoreInfoUrl = "${apiBaseUrl}vendor/store_info";
  static const String emailOTPVerifyUrl = "${apiBaseUrl}woocustomer/email_verification";
  static const String getWishListUrl =
      '${apiBaseUrl}wishlist/get_wishlist_items';
  static const String addToWishListUrl =
      "${apiBaseUrl}wishlist/add_wishlist_item";
  static const String getSupportUrl = "${apiBaseUrl}woocustomer/get_support";
  static const String getCartCountUrl =
      "${apiBaseUrl}woocustomer/get_cart_counts";
  static const String removeFromWishListUrl =
      "${apiBaseUrl}wishlist/remove_wishlist_item";
  static const String getBookableProductUrl =
      "${apiBaseUrl}woo_api/get_bookable_product";
  static const String getBookableEndTime =
      "${apiBaseUrl}woocustomer/bookable_product_end_time";
  static const String getBookableAddToCart =
      "${apiBaseUrl}woocustomer/bookable_add_to_cart";
  static const String getAttributeDataUrl =
      "${apiBaseUrl}woo_api/get_attribute_data";
  static const String clearNotificationUrl =
      "${apiBaseUrl}woocustomer/clear_notifications";
  static const String cancelMyBookingUrl =
      "${apiBaseUrl}woocustomer/cancel_booking";
  static const String forgotPasswordOTPVerifyUrl =
      "${apiBaseUrl}woocustomer/forgot_password_otp_verify";
  static const String getAllAttributesUrl =
      "${apiBaseUrl}woo_api/get_all_attributes";
  static const String updatePasswordUrl =
      "${apiBaseUrl}woocustomer/reset_password";
  static const String resendOtp = "${apiBaseUrl}woocustomer/resend_otp";
  static const String chatSendNotificationUrl = "${apiBaseUrl}woocustomer/chat_sendnotification";

}

logPrint(String logis) {
  log(logis);
}

final headers = {
  HttpHeaders.contentTypeHeader: 'application/json',
  HttpHeaders.acceptHeader: 'application/json',
};

showToast(message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppTheme.newprimaryColor,
      textColor: Colors.white,
      fontSize: 16.0);
}

bool validateStructure(String value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);

  return regExp.hasMatch(em);
}

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

Future<bool> isLogIn() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('user') == null ? false : true;
}
