import 'dart:convert';

import 'package:dinelah/models/ModelLogIn.dart';
import 'package:dinelah/utils/ApiConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../controller/CartController.dart';
import '../../res/app_assets.dart';
import '../../res/theme/theme.dart';
import '../../routers/my_router.dart';
import '../widget/common_widget.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  CheckoutState createState() => CheckoutState();
}

class CheckoutState extends State<Checkout> {
  var cookie;
  String webUrl = "";

  RxBool isDataLoad = false.obs;
  RxBool isDataLoad1 = false.obs;
  final CartController _cartController = Get.put(CartController());

  getLoadPrefs() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ModelLogInData? user = ModelLogInData.fromJson(jsonDecode(pref.getString('user')!));

    setState(() {
      cookie = user.cookie;
      webUrl = "${"${ApiUrls.domainName}checkout/?cookie=" + cookie}&appchekout=yes";
      isDataLoad1.value = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getLoadPrefs();
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
                if(isDataLoad1.value)
                WebView(
                  initialUrl: Uri.parse(webUrl).toString(),
                  javascriptMode: JavascriptMode.unrestricted,

                  onPageFinished: (String url) {
                    setState(() {
                      isDataLoad.value = true;
                    });
                  },
                  navigationDelegate: (action) {
                      if (kDebugMode) {
                        print('URL FOUND..........  ${action.url.toString()}');
                      }
                    if (action.url.contains('https://dinelah.com/shop/')) {
                      print('URL FOUND.. ToGoTo.....................  ${action.url.toString()}');
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
                        radius: 30
                    )
                )
                    : const SizedBox.shrink()
              ],
            )
          );
        }),
      ),
    );
  }
}
