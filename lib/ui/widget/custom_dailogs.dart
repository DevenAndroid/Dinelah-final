
import 'package:dinelah/res/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showError(String msg) {
  Get.snackbar("Error : ", "$msg",
      backgroundColor: Colors.red,
      snackStyle: SnackStyle.GROUNDED,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white);
}

showSuccess(String msg) {
  Get.snackbar("Success : ", "$msg",
      backgroundColor: Colors.green,
      snackStyle: SnackStyle.GROUNDED,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white);
}

showMsg(String title, String msg) {
  Get.snackbar("$title : ", "$msg",
      backgroundColor: Colors.green,
      snackStyle: SnackStyle.GROUNDED,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white);
}

showProgressBar() {
  // Get.dialog(SpinKitWave(
  //   color: AppTheme.primaryColor,
  //   duration: Duration(milliseconds: 1000),
  //   size: 60,
  // ));
}

showLoading() {
  Get.dialog(Scaffold(
    backgroundColor: Colors.transparent,
    body: Container(
      color: Colors.transparent,
      height: SizeConfig.heightMultiplier! * 100,
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // SpinKitFoldingCube(
              //   color: AppTheme.primaryColor,
              // ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Uploading...',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ],
          )),
    ),
  ));
}

closeProgress() {
  Get.back();
}
