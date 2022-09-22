import 'dart:async';

import 'package:dinelah/repositories/resend_otp_repository.dart';
import 'package:dinelah/repositories/verify_otp_forgot_pass_repo.dart';
import 'package:dinelah/res/app_assets.dart';
import 'package:dinelah/res/theme/theme.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:dinelah/ui/widget/common_button_white.dart';
import 'package:dinelah/ui/widget/common_widget.dart';
import 'package:dinelah/utils/ApiConstant.dart';
import 'package:dinelah/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOTPForgotPassword extends StatefulWidget {
  const VerifyOTPForgotPassword({Key? key}) : super(key: key);

  @override
  State<VerifyOTPForgotPassword> createState() =>
      _VerifyOTPForgotPasswordState();
}

class _VerifyOTPForgotPasswordState extends State<VerifyOTPForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();

  late Timer _timer;
  var resendText = 'Resend OTP';

  void startTimer() {
    int start = 30;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          setState(() {
            resendText = 'Resend OTP';
            timer.cancel();
          });
        } else {
          setState(() {
            resendText = 'Resend OTP $start';
            start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.forgotBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AddSize.padding10 * 3),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  addHeight(screenSize.height * .05),
                  Row(
                    children: [
                      addWidth(4),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back_sharp,
                          color: Colors.white54,
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
                  Container(
                    padding: EdgeInsets.only(
                        top: AddSize.padding10 * 2.5,
                        bottom: AddSize.padding10 * .5),
                    child: Text(
                      'You will get OTP via Email',
                      style: TextStyle(
                          color: Colors.white, fontSize: AddSize.font16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  addHeight(screenSize.height * .02),
                  Center(
                    child: Text(
                      'Forgot Password OTP has been sent on ${Get.arguments == null ? '' : Get.arguments[0].toString().substring(0, 3)}******@gmail.com',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: AddSize.padding10 * 3.5,
                          bottom: AddSize.padding12,
                        ),
                        child: Text('Enter your OTP Code',
                            style: TextStyle(
                                fontSize: AddSize.font14,
                                color: Colors.white54,
                                fontWeight: FontWeight.w600)),
                      ),
                      PinCodeTextField(
                        appContext: context,
                        textStyle: const TextStyle(color: Colors.white),
                        controller: otpController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        pastedTextStyle: TextStyle(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "OTP code Required";
                          } else if (v.length != 6) {
                            return "Enter complete OTP code";
                          }
                          return null;
                        },
                        length: 6,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldWidth: 40,
                          fieldHeight: 40,
                          activeColor: Colors.white,
                          inactiveColor: Colors.white,
                          errorBorderColor: Colors.white,
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (v) {
                          setState(() {
                            // currentText = v;
                          });
                        },
                      ),
                      InkWell(
                        onTap: resendText == 'Resend OTP'
                            ? () {
                                resendOtp(Get.arguments[0], context)
                                    .then((value) {
                                  showToast(value.message);
                                  return null;
                                });
                                startTimer();
                              }
                            : null,
                        child: Container(
                          padding: EdgeInsets.only(
                            top: AddSize.padding10 * .8,
                            bottom: AddSize.padding10 * .8,
                          ),
                          child: Text(resendText,
                              style: TextStyle(
                                  fontSize: AddSize.font14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                  addHeight(screenSize.width * .08),
                  CommonButtonWhite(
                    buttonHeight: 6,
                    buttonWidth: 100,
                    mainGradient: AppTheme.primaryGradientColor,
                    text: 'SUBMIT',
                    isDataLoading: true,
                    textColor: AppTheme.primaryColor,
                    onTap: () {
                      // Get.toNamed(MyRouter.resetForgotPasswordScreen,
                      //     arguments: [Get.arguments[0]]);
                      if (_formKey.currentState!.validate()) {
                        verifyOTPPassword(
                                Get.arguments[0], otpController.text, context)
                            .then((value) {
                          showToast(value.message);
                          if (value.status!) {
                            Get.toNamed(MyRouter.resetForgotPasswordScreen,
                                arguments: [Get.arguments[0]]);
                          }
                        });
                      }
                    },
                    btnColor: Colors.white,
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
