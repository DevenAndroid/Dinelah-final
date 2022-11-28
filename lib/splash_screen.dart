import 'package:dinelah/controller/GetHomeController.dart';
import 'package:dinelah/controller/SplashScreenController.dart';
import 'package:dinelah/res/app_assets.dart';
import 'package:dinelah/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final splashScreen = Get.put(SplashScreenController());

  // final _controller = Get.put(GetHomeController());
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Utility.hideKeyboard(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            /*Image.asset(
              AppAssets.splashBg,
              width: screenSize.width,
              height: MediaQuery.of(context).size.height * 0.75,
              fit: BoxFit.fill,
            ),
            Positioned(
              bottom: 0,
              child: Image.asset(
                AppAssets.logoWelcome,
                width: screenSize.width,
              ),
            ),*/

            // code after release
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                ),
                Image.asset(
                  AppAssets.splashBg,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.78,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  bottom: 50,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                      AppAssets.logoWelcome,
                    width: MediaQuery.of(context).size.width * 0.040,
                    height: MediaQuery.of(context).size.height*0.080,
                    //fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
