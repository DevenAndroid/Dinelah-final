import 'dart:async';

import 'package:badges/badges.dart';
import 'package:dinelah/controller/BottomNavController.dart';
import 'package:dinelah/controller/CustomNavigationBarController.dart';
import 'package:dinelah/controller/WishListController.dart';
import 'package:dinelah/res/theme/theme.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:dinelah/ui/screens/wishList_screen.dart';
import 'package:dinelah/ui/widget/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/CartController.dart';
import '../../res/app_assets.dart';
import '../widget/drawer.dart';
import 'all_hosts.dart';
import 'cart_screen.dart';
import 'dashboard_screen.dart';
import 'my_profile.dart';

class CustomNavigationBar extends StatefulWidget {
  final int index;

  const CustomNavigationBar({Key? key, this.index = 2}) : super(key: key);

  @override
  CustomNavigationBarState createState() => CustomNavigationBarState();
}

class CustomNavigationBarState extends State<CustomNavigationBar> {
  final controller =
      Get.put(CustomNavigationBarController());

  // final bottomNavController = Get.put(BottomNavController());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;

  String title = '';
  //
  // @override
  // void dispose() {
  //   super.dispose();
  //   bottomNavController.onClose();
  // }
  final CartController _cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    // bottomNavController.getData();
    setState(() {
      _selectedIndex = widget.index;
    });
  }

  // updateCartBadgeCount() {
  //   setState(() {
  //     ++bottomNavController.cartBadgeCount.value;
  //   });
  // }

  final List<Widget> _widgetOptions = <Widget>[
    AllHostsScreen(),
    const CartScreen(),
    const DashBoardScreen(),
    MyWishList(),
    MyProfile(),
  ];

  Future<void> _onItemTapped(int index) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      if (pref.getString('user') != null) {
        _selectedIndex = index;
      } else {
        if (index == 4) {
          Get.toNamed(MyRouter.logInScreen);
        } else {
          _selectedIndex = index;
        }
      }
      switch (_selectedIndex) {
        case 0:
          title = 'All Hosts';
          break;
        case 1:
          _cartController.getData();
          title = 'My cart';
          break;
        case 2:
          title = '';
          break;
        case 3:
          final controller = Get.put(WishListController());
          controller.getYourWishList();
          title = 'Wishlist';
          break;
        case 4:
          title = 'My Profile';
          break;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return Container(
      decoration: const BoxDecoration(
        // color: Color(0xfff3f3f3),
        image: DecorationImage(
          image: AssetImage(
            AppAssets.dashboardBg,
          ),
          alignment: Alignment.topRight,
          fit: BoxFit.contain,
        ),
        gradient: LinearGradient(
            colors: [
          Color(0xfff3f3f3),
          Color(0xfff3f3f3),
          Color(0xfff3f3f3),
          Color(0xfff3f3f3),
          Colors.white
        ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        )
          // color: Color(0xfff3f3f3),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: _scaffoldKey,
        drawer: CustomDrawer(_onItemTapped),
        appBar: buildAppBar(
          false,
          title,
          _scaffoldKey,
          _selectedIndex,
        ),
        bottomNavigationBar: SafeArea(
          minimum: EdgeInsets.zero,
          top: false,
          child: SizedBox(
            height: 56,
            child: BottomAppBar(
              color: Colors.transparent,
              elevation: 0,
                shape: const CircularNotchedRectangle(),
                notchMargin: 8.0,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: BottomNavigationBar(
                    items: [
                      const BottomNavigationBarItem(
                          icon: Icon(
                            Icons.storefront_outlined,
                            size: 24,
                          ),
                          label: ''),
                      BottomNavigationBarItem(
                          icon: Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Badge(
                                toAnimate: true,
                                badgeContent: Obx(() {
                                  return Text(
                                    _cartController.isDataLoading.value ?
                                    _cartController.model.value.data!.items.length.toString() : "0",
                                    style: const TextStyle(color: Colors.white),
                                  );
                                }),
                                child: const Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 24,
                                ),
                              )),
                          label: ''),
                      const BottomNavigationBarItem(
                          icon: Icon(
                            Icons.person_outline,
                            size: 24,
                            color: Colors.transparent,
                          ),
                          label: ''),
                      const BottomNavigationBarItem(
                          icon: Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: Icon(
                              Icons.favorite_border,
                              size: 24,
                            ),
                          ),
                          label: ''),
                      const BottomNavigationBarItem(
                          icon: Icon(
                            Icons.person_outline,
                            size: 24,
                          ),
                          label: ''),
                    ],
                    backgroundColor: Colors.white,
                    type: BottomNavigationBarType.fixed,
                    currentIndex: _selectedIndex,
                    selectedItemColor: AppTheme.primaryColor,
                    iconSize: 40,
                    onTap: _onItemTapped,
                    elevation: 4)
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Visibility(
          visible: !keyboardIsOpened,
          child: FloatingActionButton(
            child: Image.asset(AppAssets.homeBottomNav),
            onPressed: () {
              _cartController.getData();
              setState(() {
                title = '';
                _selectedIndex = 2;
              });
            },
          ),
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
    );
  }
}
