import 'package:client_information/client_information.dart';
import 'package:dinelah/controller/ProfileController.dart';
import 'package:dinelah/repositories/delete_user_account_repository.dart';
import 'package:dinelah/res/size_config.dart';
import 'package:dinelah/res/strings.dart';
import 'package:dinelah/res/theme/theme.dart';
import 'package:dinelah/utils/ApiConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../routers/my_router.dart';

class CustomDrawer extends StatefulWidget {
  final void Function(int index) onItemTapped;

  const CustomDrawer(this.onItemTapped, {Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final ProfileController _profileController = Get.put(ProfileController());
  bool apiConnected = false;

  String? userName = 'Guest';
  String? userEmail = '';
  String? userImage;
  RxBool isLoggedIn = false.obs;

  ClientInformation? _clientInfo;
  SharedPreferences? pref;
  bool isLogin = true;

  @override
  void initState() {
    super.initState();

    _profileController.getData();
  }

  getSf() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      isLogin = pref!.getString('user') != null ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Drawer(
      child: Obx(() {
        getSf();
        if (_profileController.isDataLoading.value) {
          userName = _profileController.model.value.data?.firstName.toString();
          userEmail = _profileController.model.value.data?.email;
          userImage = _profileController.model.value.data?.profileImage;
        }
        return Container(
          color: AppTheme.colorBackground,
          height: SizeConfig.heightMultiplier! * 100,
          width: SizeConfig.widthMultiplier! * 80,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: screenSize.width,
                  color: AppTheme.newprimaryColor,
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.heightMultiplier! * 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Get.to(navigationPage.elementAt(_currentPage))
                          // Get.to(MyProfile());
                        },
                        child: Card(
                          elevation: 3,
                          shape: const CircleBorder(),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Container(
                              margin: const EdgeInsets.all(4),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: const ShapeDecoration(
                                shape: CircleBorder(),
                                color: Colors.white,
                              ),
                              height: SizeConfig.heightMultiplier! * 10,
                              width: SizeConfig.heightMultiplier! * 10,
                              child: userImage != null
                                  ? userImage!.isEmpty
                                      ? Image.asset(
                                          'assets/images/app_icon.png')
                                      : Image.network(
                                          userImage.toString(),
                                          fit: BoxFit.cover,
                                        )
                                  : const Icon(
                                      Icons.person,
                                      size: 40,
                                    )),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier! * 1.5,
                      ),
                      Text(userName != null ? userName.toString() : 'Guest',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: SizeConfig.heightMultiplier! * .5,
                      ),
                      Text(userEmail != null ? userEmail.toString() : '',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w400)),
                      SizedBox(
                        height: SizeConfig.heightMultiplier! * 1.8,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier! * .5,
                ),
                _drawerTile(
                    active: true,
                    title: Strings.orders,
                    icon: const Icon(
                      Icons.list_alt,
                      size: 22,
                      color: AppTheme.textColorDarkBLue,
                    ),
                    onTap: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      if (pref.getString('user') != null) {
                        Get.back();
                        Get.toNamed(MyRouter.myOrdersScreen);
                      } else {
                        Get.back();
                        Get.toNamed(MyRouter.logInScreen);
                      }
                    }),
                const Divider(
                  height: 1,
                ),
                _drawerTile(
                    active: true,
                    title: Strings.myBookings,
                    icon: const Icon(
                      Icons.library_books_outlined,
                      size: 22,
                      color: AppTheme.textColorDarkBLue,
                    ),
                    onTap: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      if (pref.getString('user') != null) {
                        Get.back();
                        Get.toNamed(MyRouter.myBookingsScreen);
                      } else {
                        Get.back();
                        Get.toNamed(MyRouter.logInScreen);
                      }
                    }),
                const Divider(
                  height: 1,
                ),
                _drawerTile(
                    active: true,
                    title: Strings.account,
                    icon: const Icon(
                      Icons.person_outline,
                      size: 22,
                      color: AppTheme.textColorDarkBLue,
                    ),
                    onTap: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      if (pref.getString('user') != null) {
                        Get.back();
                        widget.onItemTapped(4);
                      } else {
                        Get.back();
                        Get.toNamed(MyRouter.logInScreen);
                      }
                    }),
                const Divider(
                  height: 1,
                ),
                _drawerTile(
                    active: true,
                    title: Strings.wishlist,
                    icon: const Icon(
                      Icons.favorite_border,
                      size: 22,
                      color: AppTheme.textColorDarkBLue,
                    ),
                    onTap: () {
                      Get.back();
                      widget.onItemTapped(3);
                    }),
                const Divider(
                  height: 1,
                ),
                _drawerTile(
                    active: true,
                    title: Strings.notification,
                    icon: const Icon(
                      Icons.notifications_none,
                      size: 22,
                      color: AppTheme.textColorDarkBLue,
                    ),
                    onTap: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      if (pref.getString('user') != null) {
                        Get.back();
                        Get.toNamed(MyRouter.notificationScreen);
                      } else {
                        Get.back();
                        Get.toNamed(MyRouter.logInScreen);
                      }
                    }),
                const Divider(
                  height: 1,
                ),
                _drawerTile(
                    active: true,
                    title: Strings.address,
                    icon: const Icon(
                      Icons.location_on_outlined,
                      size: 22,
                      color: AppTheme.textColorDarkBLue,
                    ),
                    onTap: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      if (pref.getString('user') != null) {
                        Get.back();
                        Get.toNamed(MyRouter.addressScreen);
                      } else {
                        Get.back();
                        Get.toNamed(MyRouter.logInScreen);
                      }
                    }),
                const Divider(
                  height: 1,
                ),
                _drawerTile(
                    active: true,
                    title: Strings.myCart,
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      size: 22,
                      color: AppTheme.textColorDarkBLue,
                    ),
                    onTap: () async {
                      Get.back();
                      widget.onItemTapped(1);
                    }),
                const Divider(
                  height: 1,
                ),
                _drawerTile(
                    active: true,
                    title: Strings.faq,
                    icon: const Icon(
                      Icons.question_mark_outlined,
                      size: 22,
                      color: AppTheme.textColorDarkBLue,
                    ),
                    onTap: () async {
                      Get.back();
                      launch("https://dinelah.com/faq/");
                    }),
                !isLogin ? const SizedBox.shrink() : const Divider(),
                !isLogin ? const SizedBox.shrink() : _drawerTile(
                    active: true,
                    title: "Delete Account",
                    icon: const Icon(
                      Icons.delete_outline,
                      size: 22,
                      color: AppTheme.textColorDarkBLue,
                    ),
                    onTap: () async {
                      deleteUserAccountData(context).then((value) async {
                        if(value.status==true){
                          _getClientInformation();
                          Get.back();
                          SharedPreferences preferences = await SharedPreferences.getInstance();
                          await preferences.clear();
                          showToast(value.message);
                          Get.offAllNamed(MyRouter.logInScreen, arguments: ['mainScreen']);
                        }else{
                          showToast(value.message);
                        }
                        return null;
                      });
                    }),


                !isLogin ? const SizedBox.shrink() : const Divider(),
                !isLogin ? const SizedBox.shrink() : _drawerTile(
                        active: true,
                        title: Strings.logOut,
                        icon: const Icon(
                          Icons.power_settings_new,
                          size: 22,
                          color: AppTheme.textColorDarkBLue,
                        ),
                        onTap: () async {
                          _getClientInformation();
                          Get.back();

                          SharedPreferences preferences = await SharedPreferences.getInstance();
                          await preferences.clear();
                          Get.offAllNamed(MyRouter.logInScreen,
                              arguments: ['mainScreen']);
                        }),
                const Divider(
                  height: 1,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  //to get device Id
  Future<void> _getClientInformation() async {
    ClientInformation? info;
    try {
      info = await ClientInformation.fetch();
    } on PlatformException {
      // print('Failed to get client information');
    }
    if (!mounted) return;

    setState(() {
      _clientInfo = info!;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('deviceId', _clientInfo!.deviceId.toString());
  }

  Widget _drawerTile(
      {required bool active,
      required String title,
      required Icon icon,
      required VoidCallback onTap}) {
    return ListTile(
      selectedTileColor: AppTheme.etBgColor,
      leading: icon,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          color: active ? Colors.black : Colors.grey,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: active ? onTap : null,
    );
  }
}
