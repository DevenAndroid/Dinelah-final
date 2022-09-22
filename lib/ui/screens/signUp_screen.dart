import 'package:client_information/client_information.dart';
import 'package:dinelah/repositories/user_signup_repository.dart';
import 'package:dinelah/res/app_assets.dart';
import 'package:dinelah/res/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../helper/Helpers.dart';
import '../../res/theme/theme.dart';
import '../../routers/my_router.dart';
import '../widget/common_button.dart';
import '../widget/common_text_field_sign_up.dart';
import '../widget/common_widget.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var userNameController = TextEditingController();
  var mobileController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmController = TextEditingController();

  RxBool isDataLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  late ClientInformation _clientInfo;

  // var googledata=Get.arguments;
  var userGoogleEmail;
  var userGoogleDisplayname;
  var googleAccessTokenId;
  var socialTypeGoogle;
  var userLoginType = 'manual';

  RxBool isPasswordShow = true.obs;
  RxBool isConfirmPasswordShow = true.obs;

  // bool? isPassword = true;

  @override
  void initState() {
    super.initState();
    _getClientInformation();

    googleAccessTokenId =
        Get.arguments == null ? '' : Get.arguments[0].toString();
    userGoogleEmail = Get.arguments == null ? '' : Get.arguments[1].toString();
    userGoogleDisplayname =
        Get.arguments == null ? '' : Get.arguments[2].toString();
    socialTypeGoogle = Get.arguments == null ? '' : Get.arguments[3].toString();
    userLoginType = Get.arguments == null ? '' : Get.arguments[3].toString();

    userNameController.text = userGoogleEmail;
  }

  Future<void> _getClientInformation() async {
    ClientInformation? info;
    try {
      info = await ClientInformation.fetch();
    } on PlatformException {
      print('Failed to get client information');
    }
    if (!mounted) return;

    setState(() {
      _clientInfo = info!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AppAssets.logInBg,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 26,
              child: Image.asset(
                AppAssets.logoWelcome,
                width: screenSize.width,
                height: 60,
              ),
            ),
            Positioned(
                bottom: 32,
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Stack(
                      children: [
                        SizedBox(
                          width: screenSize.width,
                          child: Card(
                            elevation: 5,
                            color: Colors.white.withOpacity(0.88),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin: const EdgeInsets.fromLTRB(18, 56, 18, 24),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  addHeight(38),
                                  Text(
                                    Strings.buttonSignUp,
                                    style: const TextStyle(
                                        color: AppTheme.textColorDarkBLue,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 28),
                                  ),
                                  addHeight(8),
                                  labelText(Strings.signUpToYourAccount),
                                  addHeight(24),
                                  CommonTextFieldWidgetSignUp(
                                    hint: 'Email',
                                    controller: userNameController,
                                    icon: Icons.email_outlined,
                                    isPassword: false,
                                    type: '1',
                                  ),
                                  addHeight(12),
                                  CommonTextFieldWidgetSignUp(
                                    hint: Strings.mobileNumber,
                                    controller: mobileController,
                                    icon: Icons.phone_android_outlined,
                                    isPassword: false,
                                    type: '2',
                                  ),
                                  addHeight(12),
                                  Obx(() => IntrinsicHeight(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                controller: passwordController,
                                                obscureText:
                                                    isPasswordShow.value,
                                                validator: (value) {
                                                  if (value!.trim().isEmpty) {
                                                    return 'Please enter password';
                                                  } else if (value.length < 4) {
                                                    return 'Password must be greater then 6';
                                                  } else if (value.length > 100) {
                                                    return 'Password must be less then 100';
                                                  }
                                                  return null;
                                                },
                                                keyboardType:
                                                    TextInputType.text,
                                                maxLength: 32,
                                                textInputAction:
                                                    TextInputAction.done,
                                                decoration: InputDecoration(
                                                    hintText: Strings.password,
                                                    counterText: "",
                                                    filled: true,
                                                    fillColor: AppTheme
                                                        .colorEditFieldBg,
                                                    focusColor: AppTheme
                                                        .colorEditFieldBg,
                                                    contentPadding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 18),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: const BorderSide(
                                                          color: AppTheme
                                                              .primaryColorVariant),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    enabledBorder: const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: AppTheme
                                                                .primaryColorVariant),
                                                        borderRadius:
                                                            const BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0))),
                                                    border: OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: AppTheme
                                                                    .primaryColor,
                                                                width: 2.0),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5.0)),
                                                    prefixIcon: const Icon(
                                                      Icons.lock,
                                                      color: Colors.grey,
                                                    ),
                                                    suffixIcon: GestureDetector(
                                                      onTap: () {
                                                        isPasswordShow.value =
                                                            !isPasswordShow
                                                                .value;
                                                      },
                                                      child: Icon(
                                                          isPasswordShow.value
                                                              ? CupertinoIcons
                                                                  .eye_slash_fill
                                                              : CupertinoIcons
                                                                  .eye,
                                                          color: Colors.red),
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                  addHeight(12),
                                  Obx(() => IntrinsicHeight(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                controller:
                                                    passwordConfirmController,
                                                obscureText:
                                                    isConfirmPasswordShow.value,
                                                validator: (value) {
                                                  if (value!.trim().isEmpty) {
                                                    return 'Please enter confirm password';
                                                  } else if (value.length < 4) {
                                                    return 'Confirm password must be greater then 6';
                                                  } else if (value.length >
                                                      16) {
                                                    return 'Confirm password must be less then 16';
                                                  } else if (value !=
                                                      passwordController.text) {
                                                    return 'Entered password not match';
                                                  }
                                                  /* else {
                                                if (value!.trim().isEmpty) {
                                                  return 'Please enter username or email';
                                                } else if (value.length < 4) {
                                                  return 'Please enter valid username or email';
                                                }
                                              }*/
                                                  return null;
                                                },
                                                keyboardType:
                                                    TextInputType.text,
                                                maxLength: 32,
                                                textInputAction:
                                                    TextInputAction.done,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        Strings.confirmPassword,
                                                    counterText: "",
                                                    filled: true,
                                                    fillColor: AppTheme
                                                        .colorEditFieldBg,
                                                    focusColor: AppTheme
                                                        .colorEditFieldBg,
                                                    contentPadding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 18),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: const BorderSide(
                                                          color: AppTheme
                                                              .primaryColorVariant),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    enabledBorder: const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: AppTheme
                                                                .primaryColorVariant),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0))),
                                                    border: OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: AppTheme
                                                                    .primaryColor,
                                                                width: 2.0),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5.0)),
                                                    prefixIcon: const Icon(
                                                      Icons.lock,
                                                      color: Colors.grey,
                                                    ),
                                                    suffixIcon: GestureDetector(
                                                      onTap: () {
                                                        isConfirmPasswordShow
                                                                .value =
                                                            !isConfirmPasswordShow
                                                                .value;
                                                      },
                                                      child: Icon(
                                                          isConfirmPasswordShow
                                                                  .value
                                                              ? CupertinoIcons
                                                                  .eye_slash_fill
                                                              : CupertinoIcons
                                                                  .eye,
                                                          color: Colors.red),
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                  addHeight(24),
                                  Obx(
                                    () => CommonButton(
                                        buttonHeight: 6.5,
                                        buttonWidth: 95,
                                        mainGradient:
                                            AppTheme.primaryGradientColor,
                                        text: Strings.buttonSignUp,
                                        isDataLoading: isDataLoading.value,
                                        textColor: Colors.white,
                                        onTap: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            if (passwordController.text
                                                    .trim() !=
                                                passwordConfirmController.text
                                                    .trim()) {
                                              Helpers.createSnackBar(context,
                                                  'Password not matched');
                                            } else {
                                              if (userLoginType != 'manual') {
                                                register(
                                                        userNameController.text,
                                                        mobileController.text,
                                                        passwordController.text,
                                                        googleAccessTokenId
                                                            .toString(),
                                                        socialTypeGoogle
                                                            .toString(),
                                                        context)
                                                    .then((value) async {
                                                  if (value.status) {
                                                    Get.toNamed(
                                                        MyRouter.verifySignUpOtp, arguments: [userNameController.text.toString()]);

                                                    /* getAlertDialog('Sign Up',
                                                        value.message, () {
                                                      Get.offAllNamed(
                                                          MyRouter.logInScreen, arguments: ['mainScreen']);
                                                    });*/
                                                  } else {
                                                    getAlertDialog('Sign Up',
                                                        value.message, () {
                                                      Get.back();
                                                    });
                                                  }
                                                  return;
                                                });
                                              } else {
                                                register(
                                                        userNameController.text,
                                                        mobileController.text,
                                                        passwordController.text,
                                                        '',
                                                        "manual",
                                                        context)
                                                    .then((value) async {
                                                  if (value.status) {
                                                    getAlertDialog('Sign Up',
                                                        value.message, () {
                                                      Get.offAndToNamed(
                                                          MyRouter.logInScreen);
                                                    });
                                                  } else {
                                                    getAlertDialog('Sign Up',
                                                        value.message, () {
                                                      Get.back();
                                                    });
                                                  }
                                                  return;
                                                });
                                              }
                                            }
                                          }
                                        }),
                                  ),
                                  addHeight(8),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppAssets.logInLogo,
                                  height: 100,
                                  width: 100,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            Positioned(
              bottom: 16,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: Strings.login,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                          children: [
                            TextSpan(
                                text: Strings.loginNow,
                                recognizer: TapGestureRecognizer()
                                  ..onTap =
                                      () => Get.toNamed(MyRouter.logInScreen, arguments: ['mainScreen']),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.w700,
                                )),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
