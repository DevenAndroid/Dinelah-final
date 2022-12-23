import 'dart:convert';

import 'package:dinelah/controller/BottomNavController.dart';
import 'package:dinelah/models/ModelLogIn.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:dinelah/utils/ApiConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../controller/CartController.dart';
import '../../controller/CustomNavigationBarController.dart';
import '../../res/app_assets.dart';
import '../../res/theme/theme.dart';
import '../widget/common_widget.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  CheckoutState createState() => CheckoutState();
}

class CheckoutState extends State<Checkout> {
  var cookie;

  RxBool isDataLoad = false.obs;

  final CartController _cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _cartController.getData();
        return true;
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xfffff8f9),
          image: DecorationImage(
            image: AssetImage(
              AppAssets.cartShapeBg,
            ),
            alignment: Alignment.topRight,
            fit: BoxFit.contain,
          ),
        ),
        child: Obx(() {
          return Scaffold(
            appBar: backAppBar("Checkout"),
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                WebView(
                  initialUrl: Uri.parse(Get.arguments[1]).toString(),
                  javascriptMode: JavascriptMode.unrestricted,

                  onPageFinished: (String url) {
                    setState(() {
                      isDataLoad.value = true;
                    });
                  },
                  navigationDelegate: (action) {
                      print('URL FOUND :: $action');
                    if (!action.url.contains('/checkout')) {
                      Get.offAllNamed(MyRouter.customBottomBar);
                      return NavigationDecision.prevent;
                    } else {
                      return NavigationDecision.navigate;
                    }
                  },
                ),
                !isDataLoad.value
                    ? const Center(
                    child: CupertinoActivityIndicator(
                        animating: true,
                        color: AppTheme.primaryColor,
                        radius: 30))
                    : const SizedBox.shrink()
              ],
            )
          );
        }),
      ),
    );
  }
}
