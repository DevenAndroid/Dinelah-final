import 'dart:convert';

import 'package:dinelah/controller/BottomNavController.dart';
import 'package:dinelah/models/ModelLogIn.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:dinelah/utils/ApiConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

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

  final bottomNavController = Get.put(BottomNavController());

  getLoadPrefs() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ModelLogInData? user =
        ModelLogInData.fromJson(jsonDecode(pref.getString('user')!));

    setState(() {
      cookie = user.cookie;
    });
  }

  @override
  void initState() {
    super.initState();
    getLoadPrefs();
  }

  @override
  Widget build(BuildContext context) {
    String webUrl = "${"${ApiUrls.domainName}checkout/?cookie=" +
        cookie}&appchekout=yes";
    return WillPopScope(
      onWillPop: () async {
        bottomNavController.getData();
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
        child: Scaffold(
          appBar: backAppBar("Checkout"),
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              WebView(
                initialUrl: webUrl.toString(),
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (String url) {
                  setState(() {
                    isDataLoad.value = true;
                  });
                },
                navigationDelegate: (action) {
                  print('URL FOUND :: $action');
                  if (!action.url
                      .contains('/checkout')) {
                    bottomNavController.getData();
                    Get.offAllNamed(MyRouter.customBottomBar);
                    return NavigationDecision.prevent;
                  } else {
                    bottomNavController.getData();
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
          ),
        ),
      ),
    );
  }
}
