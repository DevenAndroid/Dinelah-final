import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../res/theme/theme.dart';

class Utility {
  static double convertIntoMile(int loct) {
    return loct * 1609;
  }

  // static String getDay(String date_) {
  //   try {
  //     DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  //     DateTime dateTime = dateFormat.parse(date_);
  //     return "${dateTime.day}";
  //   } catch (e) {
  //     e.printError();
  //   }

  //   return "3";
  // }

  static showError(String content) {
    Get.snackbar("Error", content, colorText: AppTheme.failRed);
  }

  static getCurrentTimeStamp() {}

  ///hide keyboard
  static hideKeyboard(BuildContext context){
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  /// change color statusbar
  static statusBarColor(Color backgroundColor){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: backgroundColor,
        //or set color with: Color(0xFF0000FF)
        statusBarIconBrightness: Brightness.light));
  }

  //actionbar
  static actionBar(){
    return AppBar(
      backgroundColor: AppTheme.primaryColor,
      brightness: Brightness.dark,
      centerTitle: true,
      title: Container(
        height: 50,
        width: 50,
        alignment: Alignment.center,
        child: Text("Test"),//Image.asset(MyImages.ic_app_logo),
      ),
      leading: Builder(
        builder: (context) => // Ensure Scaffold is in context
        // ignore: deprecated_member_use
        FlatButton(
            padding: const EdgeInsets.all(0.0),
            child: const Icon(Icons.arrow_back),
            onPressed: () => {Get.back()}),
      ),
    );
  }
}
