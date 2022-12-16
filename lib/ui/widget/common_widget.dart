import 'package:badges/badges.dart';
import 'package:dinelah/controller/ProfileController.dart';
import 'package:dinelah/controller/vendorsListController.dart';
import 'package:dinelah/res/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/CartController.dart';
import '../../res/theme/theme.dart';
import '../../routers/my_router.dart';
import '../screens/bottom_nav_bar.dart';

Widget searchView(BuildContext context, onTap, searchController) {
  return SizedBox(
    height: 44,
    child: TextField(
      maxLines: 1,
      controller: searchController,
      style: const TextStyle(fontSize: 17),
      textAlignVertical: TextAlignVertical.center,
      textInputAction: TextInputAction.search,
      onSubmitted: (value) => onTap(),
      decoration: InputDecoration(
        filled: true,
        prefixIcon:
            Icon(Icons.search, color: Theme.of(context).iconTheme.color),
        suffixIcon: InkWell(
            onTap: onTap,
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(5)),
              child: const Icon(
                Icons.search,
                size: 18,
                color: Colors.white,
              ),
            )),
        border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        fillColor: Colors.white,
        contentPadding: EdgeInsets.zero,
        hintText: 'Search Your Food',
      ),
    ),
  );
}

SizedBox addHeight(double size) => SizedBox(height: size);

SizedBox addWidth(double size) => SizedBox(width: size);

Padding getNoDataFound(Size screenSize, message) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          children: [
            addHeight(32),
            Image.asset(
              AppAssets.imgNoData,
              width: screenSize.width,
              height: 160,
              // fit: BoxFit.fill,
            ),
            Text(
              message,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87),
            ),
            addHeight(32),
          ],
        ),
      ),
    ),
  );
}

void getAlertDialog(title, value, onTap) {
  Get.defaultDialog(
      title: title,
      titleStyle: const TextStyle(
        color: AppTheme.primaryColor,
      ),
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

AppBar backAppBar(title) {
  final CartController cartController = Get.put(CartController());
  final ProfileController profileController = Get.put(ProfileController());
  String? userImage;

  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(
      title,
    ),
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
          onPressed: () {
            if (title == 'Search Result') {
              final controller = Get.put(VendorsController());
              controller.getResetData();
            } else if (title == 'Checkout') {
              cartController.getData();
            }
            cartController.getData();
            Get.back();
          },
          icon: Image.asset(
            AppAssets.backIcon,
          )),
    ),
    actions: [
      Visibility(
        visible: true,
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
      Padding(
        padding: const EdgeInsets.only(right: 16.0, top: 8),
        child: Visibility(
          visible: true,
          child: Badge(
            toAnimate: true,
            badgeContent: Obx(() {
              return Text(
                  cartController.isDataLoading.value ?
                  cartController.model.value.data!.items.length.toString() :"0",
                style: const TextStyle(color: Colors.white),
              );
            }),
            child: InkWell(
              onTap: () {
                Get.to(const CustomNavigationBar(
                  index: 1,
                ));
              },
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 24,
              ),
            ),
          ),
          /*IconButton(
              onPressed: () {
                Get.to(CustomNavigationBar(
                  index: 1,
                ));
              },
              icon: Icon(Icons.shopping_cart)),*/
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Obx(() {
          if (profileController.isDataLoading.value) {
            userImage = profileController.model.value.data?.profileImage;
          }
          return Visibility(
            visible: true,
            child: GestureDetector(
              onTap: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                if (pref.getString('user') != null) {
                  Get.off(const CustomNavigationBar(
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
                    margin: const EdgeInsets.all(2),
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
    ],
  );
}

AppBar backAppBarChat(title) {
  final CartController cartController = Get.put(CartController());
  // final bottomNavController = Get.put(BottomNavController());
  final ProfileController profileController = Get.put(ProfileController());
  String? userImage;

  return AppBar(
    backgroundColor: AppTheme.primaryColor,
    elevation: 0,
    title: Text(title,
        maxLines: 2, style: const TextStyle(color: Colors.white, fontSize: 16)),
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
          onPressed: () {
            cartController.getData();
            Get.back();
          },
          icon: Image.asset(
            AppAssets.backIcon,
          )),
    ),
    actions: [
      Visibility(
        visible: true,
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
      Padding(
        padding: const EdgeInsets.only(right: 16.0, top: 8),
        child: Visibility(
          visible: true,
          child: Badge(
            toAnimate: true,
            badgeContent: Obx(() {
              return Text(
                cartController.isDataLoading.value ?
                cartController.model.value.data!.items.length.toString() :"0",
                style: const TextStyle(color: Colors.white),
              );
            }),
            child: InkWell(
              onTap: () {
                Get.to(const CustomNavigationBar(
                  index: 1,
                ));
              },
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 24,
              ),
            ),
          ),
          /*IconButton(
              onPressed: () {
                Get.to(CustomNavigationBar(
                  index: 1,
                ));
              },
              icon: Icon(Icons.shopping_cart)),*/
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Obx(() {
          if (profileController.isDataLoading.value) {
            userImage = profileController.model.value.data?.profileImage;
          }
          return Visibility(
            visible: true,
            child: GestureDetector(
              onTap: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                if (pref.getString('user') != null) {
                  Get.off(const CustomNavigationBar(
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
                    margin: const EdgeInsets.all(2),
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
    ],
  );
}

AppBar backAppBarRed(title) {
  final CartController cartController = Get.put(CartController());
  // final bottomNavController = Get.put(BottomNavController());
  final ProfileController profileController = Get.put(ProfileController());
  String? userImage;

  return AppBar(
    backgroundColor: AppTheme.primaryColor,
    elevation: 0,
    title: Text(
      title,
    ),
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
          onPressed: () {
            cartController.getData();
            Get.back();
          },
          icon: Image.asset(
            AppAssets.backIcon,
          )),
    ),
    actions: [
      Visibility(
        visible: true,
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
      Padding(
        padding: const EdgeInsets.only(right: 16.0, top: 8),
        child: Visibility(
          visible: true,
          child: Badge(
            toAnimate: true,
            badgeContent: Obx(() {
              return Text(
                cartController.isDataLoading.value ?
                cartController.model.value.data!.items.length.toString() :"0",
                style: const TextStyle(color: Colors.white),
              );
            }),
            child: InkWell(
              onTap: () {
                Get.to(const CustomNavigationBar(
                  index: 1,
                ));
              },
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 24,
              ),
            ),
          ),
          /*IconButton(
              onPressed: () {
                Get.to(CustomNavigationBar(
                  index: 1,
                ));
              },
              icon: Icon(Icons.shopping_cart)),*/
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Obx(() {
          if (profileController.isDataLoading.value) {
            userImage = profileController.model.value.data?.profileImage;
          }
          return Visibility(
            visible: true,
            child: GestureDetector(
              onTap: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                if (pref.getString('user') != null) {
                  Get.off(const CustomNavigationBar(
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
                    margin: const EdgeInsets.all(2),
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
    ],
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
    style: const TextStyle(height: 1.2, color: Colors.black54, fontSize: 14),
  );
}

Text normalText(text) {
  return Text(
    text,
    style: const TextStyle(height: 1.2, color: Colors.black54, fontSize: 16),
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
      style: const TextStyle(
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

Widget loaderNoSize(context) => const Center(
        child: CircularProgressIndicator(
      color: AppTheme.primaryColor,
    ));
