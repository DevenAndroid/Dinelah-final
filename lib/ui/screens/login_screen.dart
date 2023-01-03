import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:client_information/client_information.dart';
import 'package:dinelah/repositories/get_social_data_repository.dart';
import 'package:dinelah/repositories/user_login_repository.dart';
import 'package:dinelah/res/app_assets.dart';
import 'package:dinelah/res/strings.dart';
import 'package:dinelah/res/theme/theme.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:dinelah/ui/widget/common_button.dart';
import 'package:dinelah/ui/widget/common_text_field.dart';
import 'package:dinelah/ui/widget/common_widget.dart';
import 'package:dinelah/utils/ApiConstant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/CustomNavigationBarController.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ClientInformation _clientInfo;
  final loginFormKey = GlobalKey<FormState>();
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();

  final controller = Get.put(CustomNavigationBarController());

  RxBool isDataLoading = false.obs;

  loginWithApple(context) async {
    final appleProvider =
    AppleAuthProvider().addScope("email").addScope("fullName");
    if (kIsWeb) {
      await FirebaseAuth.instance.signInWithPopup(appleProvider).then((value) async {

        print("Apple authResult:: uid=:"+value.user!.uid.toString());
        print("Apple authResult:: email=:"+value.user!.email.toString());

        String? token = await FirebaseMessaging.instance.getToken();

        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('socialLoginId', value.user!.uid.toString());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var deviceId = prefs.getString('deviceId');
        getSocialLogin(
            context,
            value.user!.uid.toString(),
            "apple",
            deviceId,
          value.user!.email.toString(),
            token
        ).then((value1) async {
          showToast(value1.message);
          if (value1.status) {
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.setString('user', jsonEncode(value1.data));
            Get.offAndToNamed(MyRouter.customBottomBar);
          } else {
            // Get.offAndToNamed(MyRouter.signUpScreen, arguments: [
            //   value.user!.uid.toString(),
            //   value.user!.email.toString(),
            //   "",
            //   'apple',
            // ]);
          }
        });
      });
    }
    else {
      String? token = await FirebaseMessaging.instance.getToken();
      await FirebaseAuth.instance
          .signInWithProvider(appleProvider)
          .then((value) async {

        print("Apple authResult:: uid=:"+value.user!.uid.toString());
        print("Apple authResult:: email=:"+value.user!.email.toString());

        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('socialLoginId', value.user!.uid.toString());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var deviceId = prefs.getString('deviceId');

        print(await FirebaseMessaging.instance.getToken());
        getSocialLogin(context,value.user!.uid.toString(), "apple",deviceId,
            value.user!.email.toString(),
            token
        ).then((value1) async {
          showToast(value1.message);
          if (value1.status) {
            // showToast(value.message.toString());
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.setString('user', jsonEncode(value1.data));
            Get.offAndToNamed(MyRouter.customBottomBar);
          } else {
            // showToast(value.message.toString());
            // Get.offAndToNamed(MyRouter.signUpScreen, arguments: [
            //   value.user!.uid.toString(),
            //   value.user!.email.toString(),
            //   "",
            //   'apple',
            // ]);
          }
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getClientInformation();
  }

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
  }

  RxBool isPasswordShow = true.obs;

  bool? isPassword = true;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppAssets.logInBg,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 60,
              child: Image.asset(
                AppAssets.logoWelcome,
                width: screenSize.width,
              ),
            ),
            Positioned(
                bottom: 36,
                child: Stack(
                  children: [
                    Theme(
                      data: ThemeData(
                        primaryColor: Colors.red,
                        primarySwatch: Colors.red
                      ),
                      child: SizedBox(
                        width: screenSize.width,
                        child: Form(
                          key: loginFormKey,
                          child: Column(
                            children: [
                              Card(
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
                                      addHeight(screenSize.height * .04),
                                      Text(
                                        Strings.buttonLogin,
                                        style: const TextStyle(
                                            color: AppTheme.textColorDarkBLue,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 28),
                                      ),
                                      addHeight(8),
                                      labelText(Strings.loginToYourAccount),
                                      addHeight(24),
                                      CommonTextFieldWidget(
                                        hint: 'Email',
                                        controller: userNameController,
                                        icon: Icons.email_outlined,
                                        bgColor: AppTheme.etBgColor,
                                      ),
                                      addHeight(12),
                                      Obx(() =>
                                          IntrinsicHeight(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    controller:
                                                        passwordController,
                                                    obscureText:
                                                        isPasswordShow.value,
                                                    autofillHints: const [
                                                      AutofillHints.password
                                                    ],
                                                    validator: (value) {
                                                      if (isPassword!) {
                                                        if (value!
                                                            .trim()
                                                            .isEmpty) {
                                                          return 'Please enter password';
                                                        } else if (value.length <
                                                            4) {
                                                          return 'Password must be greater then 6';
                                                        } else if (value.length >
                                                            100) {
                                                          return 'Password must be less then 100';
                                                        }
                                                      } else {
                                                        if (value!
                                                            .trim()
                                                            .isEmpty) {
                                                          return 'Please enter username or email';
                                                        } else if (value.length <
                                                            4) {
                                                          return 'Please enter valid username or email';
                                                        }
                                                      }
                                                      return null;
                                                    },
                                                    keyboardType:
                                                        TextInputType.text,
                                                    maxLength: 32,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            Strings.password,
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
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(0),
                                                          borderSide: BorderSide(
                                                            color: Colors.black.withOpacity(0.1),
                                                            width: 1,
                                                          ),
                                                        ),
                                                        enabledBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(0),
                                                          borderSide: BorderSide(
                                                            color: Colors.black.withOpacity(0.1),
                                                            width: 1,
                                                          ),
                                                        ),
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
                                      addHeight(4),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          onTap: () {
                                            Get.toNamed(MyRouter.forgotPassword);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              Strings.forgotPassword,
                                              style: const TextStyle(
                                                  color:
                                                      AppTheme.textColorDarkBLue,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ),
                                      addHeight(24),
                                      CommonButton(
                                        buttonHeight: 6.5,
                                        buttonWidth: 95,
                                        mainGradient:
                                            AppTheme.primaryGradientColor,
                                        text: Strings.buttonLogin,
                                        textColor: Colors.white,
                                        onTap: () async {
                                          var fcmToken = await FirebaseMessaging.instance.getToken();
                                          if (loginFormKey.currentState!.validate()) {
                                            createLogin(
                                                    userNameController.text,
                                                    passwordController.text,
                                                    _clientInfo.deviceId
                                                        .toString(),
                                                    fcmToken.toString(),
                                                    context)
                                                .then((value) async {
                                              if (value.status == true) {
                                                showToast(value.message);
                                                // Helpers.createSnackBar(context,
                                                //     value.message.toString());
                                                SharedPreferences pref = await SharedPreferences.getInstance();
                                                pref.setString('user', jsonEncode(value.data));

                                                controller.getUser();

                                                if (Get.arguments != null) {
                                                  Get.offAndToNamed(MyRouter.customBottomBar);
                                                  } else {
                                                    Get.back();
                                                  }
                                              } else {
                                                Get.defaultDialog(
                                                    title: 'Log In',
                                                    titleStyle: const TextStyle(
                                                        color: AppTheme
                                                            .primaryColor),
                                                    middleTextStyle:
                                                        const TextStyle(
                                                            color: Colors.white),
                                                    textConfirm: "Okay",
                                                    onConfirm: () {
                                                      Get.back();
                                                    },
                                                    confirmTextColor:
                                                        Colors.white,
                                                    buttonColor:
                                                        AppTheme.primaryColor,
                                                    radius: 10,
                                                    content: Text(value.message));
                                                // showToast(value.message);
                                              }
                                              return;
                                            });
                                          }
                                        },
                                      ),
                                      /*addHeight(16),
                                      Row(
                                        children: [
                                          Expanded(child: Divider()),
                                          Text('  or  '),
                                          Expanded(child: Divider()),
                                        ],
                                      ),*/
                                      addHeight(16),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              signInWithGoogle();
                                            },
                                            child: Container(
                                              height: 38,
                                              width: 38,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: AppTheme.primaryColor,
                                              ),
                                              child: const Center(
                                                  child: FaIcon(
                                                FontAwesomeIcons.google,
                                                size: 18,
                                                color: Colors.white,
                                              )),
                                            ),
                                          ),
                                          addWidth(30),
                                          Platform.isIOS ?
                                          InkWell(
                                            onTap: () async {
                                              loginWithApple(context);
                                              // final appleIdCredential = await SignInWithApple.getAppleIDCredential(
                                              //   scopes: [
                                              //     AppleIDAuthorizationScopes.email,
                                              //     AppleIDAuthorizationScopes.fullName,
                                              //   ],
                                              // );
                                              // final oAuthProvider = OAuthProvider('apple.com');
                                              // final credential = oAuthProvider.credential(
                                              //   idToken: appleIdCredential.identityToken,
                                              //   accessToken: appleIdCredential.authorizationCode,
                                              // );
                                              // UserCredential authResult =
                                              // await FirebaseAuth.instance.signInWithCredential(credential);
                                              // print("Apple Credientials:::"+credential.toString());
                                              // print("Apple authResult:: uid=:"+authResult.user!.uid.toString());
                                              // print("Apple authResult:: email=:"+authResult.user!.email.toString());
                                              //
                                              // SharedPreferences pref = await SharedPreferences.getInstance();
                                              // pref.setString('socialLoginId', authResult.user!.uid.toString());
                                              // SharedPreferences prefs = await SharedPreferences.getInstance();
                                              // var deviceId = prefs.getString('deviceId');
                                              // getSocialLogin(context,authResult.user!.uid.toString(), "apple",deviceId)
                                              //     .then((value) async {
                                              //   if (value.status) {
                                              //     // showToast(value.message.toString());
                                              //     SharedPreferences pref = await SharedPreferences.getInstance();
                                              //     pref.setString('user', jsonEncode(value.data));
                                              //     Get.offAndToNamed(MyRouter.customBottomBar);
                                              //   } else {
                                              //     // showToast(value.message.toString());
                                              //     Get.offAndToNamed(MyRouter.signUpScreen, arguments: [
                                              //       authResult.user!.uid.toString(),
                                              //       authResult.user!.email.toString(),
                                              //       "",
                                              //       'apple',
                                              //     ]);
                                              //   }
                                              // });
                                            },
                                            child: Container(
                                              height: 38,
                                              width: 38,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(5),
                                                color: Colors.black,
                                              ),
                                              child: const Center(
                                                  child: FaIcon(
                                                    FontAwesomeIcons.apple,
                                                    size: 18,
                                                    color: Colors.white,
                                                  )),
                                            ),
                                          ) : InkWell(
                                            onTap: () => signInFaceBook(),
                                            child: Container(
                                              height: 38,
                                              width: 38,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: AppTheme.textColorSkyBLue,
                                              ),
                                              child: const Center(
                                                  child: FaIcon(
                                                FontAwesomeIcons.facebookF,
                                                size: 18,
                                                color: Colors.white,
                                              )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
                )),
            Positioned(
              bottom: 20,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: Strings.signUp,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                          children: [
                            TextSpan(
                                text: Strings.signUpNow,
                                recognizer: TapGestureRecognizer()
                                  ..onTap =
                                      () => Get.toNamed(MyRouter.signUpScreen),
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

  signInWithGoogle() async {
    await GoogleSignIn().signOut();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    // showToast(googleUser.id.toString());
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('socialLoginId', googleUser.id.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var deviceId = prefs.getString('deviceId');


  final value = await FirebaseAuth.instance.signInWithCredential(credential);
    log("Firebase response.... ${value.toString()}");
    print(await FirebaseMessaging.instance.getToken());
    getSocialLogin(context, value.user!.uid.toString(), "google",deviceId,
        value.user!.email.toString(),
        await FirebaseMessaging.instance.getToken()).then((value1) async {
      showToast(value1.message);
      if (value1.status) {
        // showToast(value.message.toString());
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('user', jsonEncode(value1.data));
        Get.offAllNamed(MyRouter.customBottomBar);
      }
      // else {
      //   // showToast(value.message.toString());
      //   Get.offAndToNamed(MyRouter.signUpScreen, arguments: [
      //     googleUser.id.toString(),
      //     googleUser.email.toString(),
      //     googleUser.displayName.toString(),
      //     'google'
      //   ]);
      // }
    });
  }

  signInFaceBook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login(
        permissions: ["public_profile", "email"]);

    final OAuthCredential oAuthCredential = FacebookAuthProvider.credential(
        loginResult.accessToken!.token);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var deviceId = prefs.getString('deviceId');
    final value = await FirebaseAuth.instance.signInWithCredential(
        oAuthCredential).then((value) async {
          print(await FirebaseMessaging.instance.getToken());
      getSocialLogin(context, value.user!.uid.toString(), "facebook", deviceId,
          value.additionalUserInfo!.profile!["email"],
          await FirebaseMessaging.instance.getToken()).then((value1) async {
      showToast(value1.message);
      if (value1.status) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('user', jsonEncode(value1.data));
      Get.offAllNamed(MyRouter.customBottomBar);
      }
      });
    }).catchError((FirebaseAuthException? e){
      showToast(e.toString());
      throw Exception(e!.message);
    });
    log("Firebase response.... ${value.toString()}");
    // if (value.user!.email != null) {

  // }
  }

  //  signInApple() async {
  //   final appleProvider = AppleAuthProvider().addScope("email").addScope("fullName");
  //
  //   if(kIsWeb){
  //     await FirebaseAuth.instance.signInWithPopup(appleProvider).then((value) {
  //
  //     });
  //   } else {
  //     await FirebaseAuth.instance.signInWithProvider(appleProvider).then((value) {
  //
  //
  //     });
  //   }
  // }
}
