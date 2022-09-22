import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/theme/theme.dart';

//SizedBox addHeight(double size) => SizedBox(height: size);

//SizedBox addWidth(double size) => SizedBox(width: size);

void getAlertDialog(title, value, onTap) {
  Get.defaultDialog(
      title: title,
      titleStyle: const TextStyle(color: AppTheme.primaryColor),
      middleTextStyle: const TextStyle(
        color: Colors.white,
      ),
      textConfirm: "Okay",
      onConfirm: onTap,
      confirmTextColor: Colors.white,
      buttonColor: AppTheme.primaryColor,
      radius: 10,
      content: Text(value));
}

AppBar backAppBarOrders(title) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(
      title,
      style: TextStyle(color: AppTheme.colorWhite),
    ),
    centerTitle: true,
    /*leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(onPressed: (){
        Get.back();
      },
          icon: Image.asset(AppAssets.backIcon,)),
    ),*/
    /*actions: [
      Visibility(
        visible: true,
        child: IconButton(
          icon: const Icon(
            Icons.notifications,
            color: AppTheme.colorWhite,
          ),
          onPressed: () {
            // Get.toNamed(MyRouter.cartProductScreen);
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Visibility(
          visible: true,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: Container(
                height: 34,
                width: 34,
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.brown ),
                child: Image.asset(AppAssets.bannerImage,fit: BoxFit.fill,)),
          ),
        ),
      ),
    ],*/
  );
}

Text labelText(label) {
  return Text(
    label,
    style: const TextStyle(
        color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 18),
  );
}

Text smallText(text) {
  return Text(
    text,
    style: TextStyle(height: 1.2, color: Colors.black54, fontSize: 14),
  );
}

Text normalText(text) {
  return Text(
    text,
    style: TextStyle(height: 1.2, color: Colors.black54, fontSize: 16),
  );
}

Text textBold(text) {
  return Text(
    text,
    textScaleFactor: 1,
    style: const TextStyle(
        color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20),
  );
}

Padding textHeading(text) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
    child: Text(
      text,
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20),
    ),
  );
}

SizedBox loader(context) => SizedBox(
    height: MediaQuery.of(context).size.height,
    child: const Center(
        child: CircularProgressIndicator(
      color: AppTheme.primaryColor,
    )));
