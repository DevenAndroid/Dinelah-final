import 'package:dinelah/res/app_assets.dart';
import 'package:dinelah/res/strings.dart';
import 'package:dinelah/res/theme/theme.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:dinelah/ui/widget/common_button_white.dart';
import 'package:dinelah/ui/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../repositories/forgot_password_repository.dart';
import '../widget/common_text_field_forgot_password.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var emailController = TextEditingController();

  RxBool isDataLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppAssets.forgotBg,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addHeight(screenSize.height * .05),
                  Row(
                    children: [
                      addWidth(4),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back_sharp,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                      addWidth(12),
                      const Text(
                        'Forgot Password',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  addHeight(screenSize.height * .08),
                  Center(
                      child: Image.asset(
                    AppAssets.forgotLogo,
                    height: 180,
                    width: 180,
                  )),
                  addHeight(screenSize.height * .02),
                  const Center(
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  addHeight(screenSize.height * .02),
                  const Center(
                    child: Text(
                      'Please Enter your registered email id.\nWe will send you a otp for verification',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  addHeight(screenSize.height * .04),
                  CommonTextFieldWidgetForgotPassword(
                    hint: Strings.enterYourEmail,
                    controller: emailController,
                    icon: Icons.email_outlined,
                    bgColor: AppTheme.etBgColor,
                    isPassword: false,
                  ),
                  addHeight(screenSize.width * .08),
                  CommonButtonWhite(
                    buttonHeight: 6,
                    buttonWidth: 100,
                    mainGradient: AppTheme.primaryGradientColor,
                    text: Strings.buttonSend,
                    isDataLoading: true,
                    textColor: AppTheme.primaryColor,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        forgotPassword(emailController.text, context)
                            .then((value) {
                          if (value.status) {
                            Get.toNamed(MyRouter.verifyOTPForgotPassword,
                                arguments: [emailController.text]);
                            // getAlertDialog('Forgot Password', value.message,
                            //     () {
                            //   Get.offAndToNamed(MyRouter.loginScreen);
                            // });
                          } else {
                            getAlertDialog('Forgot Password', value.message,
                                () {
                              Get.back();
                            });
                          }
                          return;
                        });
                        // forgotPassword(userNameController.text, context)
                        //     .then((value) {
                        //   if (value.status) {
                        //     Get.offAndToNamed(MyRouter.logInScreen);
                        //     Fluttertoast.showToast(
                        //         msg: value.message,
                        //         gravity: ToastGravity.BOTTOM,
                        //         backgroundColor: Colors.black,
                        //         textColor: Colors.white,
                        //         fontSize: 16.0);
                        //   } else {
                        //     Get.defaultDialog(
                        //         title: 'Log In',
                        //         titleStyle: const TextStyle(
                        //             color: AppTheme.primaryColor),
                        //         middleTextStyle:
                        //             const TextStyle(color: Colors.white),
                        //         textConfirm: "Okay",
                        //         onConfirm: () {
                        //           Get.back();
                        //         },
                        //         confirmTextColor: Colors.white,
                        //         buttonColor: AppTheme.primaryColor,
                        //         radius: 10,
                        //         content: Text(value.message));
                        //   }
                        //   return;
                        // });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
