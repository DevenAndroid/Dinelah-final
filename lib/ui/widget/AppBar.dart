import 'dart:convert';

import 'package:dinelah/controller/ProfileController.dart';
import 'package:dinelah/res/app_assets.dart';
import 'package:dinelah/res/theme/theme.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/ModelLogIn.dart';
import '../screens/bottom_nav_bar.dart';

AppBar buildAppBar(
  isProfilePage,
  title,
  _scaffoldKey,
  currentPage,
) {
  final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();
  //AppBarController _appBarController = Get.put(AppBarController());
  final ProfileController _profileController = Get.put(ProfileController());
  String? userImage;

  return AppBar(
    backgroundColor: Colors.transparent,
    //backgroundColor: AppTheme.colorBackground,
    elevation: 0,
    // centerTitle: true,
    title: Text(
      title,
      style: const TextStyle(
          color: AppTheme.colorWhite, fontWeight: FontWeight.bold),
    ),
    leading: Builder(
        builder: (context) => IconButton(
            padding: const EdgeInsets.all(0.0),
            icon: IconButton(
              icon: Image.asset(AppAssets.drawerIcon),
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
            onPressed: () => {
                  //  Get.toNamed(MyRouter.notification)
                })),

    actions: [
      Visibility(
        visible: title != 'My Profile',
        child: IconButton(
          icon: const Icon(
            Icons.notifications,
            color: AppTheme.colorWhite,
          ),
          onPressed: () async {
            SharedPreferences pref = await SharedPreferences.getInstance();
            if (pref.getString('user') != null) {
              Get.toNamed(MyRouter.notificationScreen);
            } else {
              Get.toNamed(MyRouter.logInScreen);
            }
          },
        ),
      ),
      Visibility(
        visible: title != 'My Profile',
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Obx(() {
            if (_profileController.isDataLoading.value) {
              userImage = _profileController.model.value.data?.profileImage;
            }
            return Visibility(
              visible: true,
              child: GestureDetector(
                onTap: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  if (pref.getString('user') != null) {
                    ModelLogInData? user = ModelLogInData.fromJson(
                        jsonDecode(pref.getString('user')!));

                    Get.off(CustomNavigationBar(
                      index: 4,
                    ));
                  } else {
                    Get.toNamed(MyRouter.logInScreen);
                  }
                },
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
                          color: Colors.brown),
                      child: userImage != null
                          ? userImage!.isEmpty
                              ? Image.asset('assets/images/app_icon.png')
                              : Image.network(userImage.toString(),
                                  fit: BoxFit.cover)
                          : Image.asset(
                              AppAssets.logInLogo,
                              fit: BoxFit.fill,
                            )),
                ),
              ),
            );
          }),
        ),
      )
    ],
  );
}
/*
getUser() async {
  isLoggedIn.value = await isLogIn();
  //showToast(isLoggedIn.value.toString());
}*/
