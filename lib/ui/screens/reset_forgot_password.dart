import 'package:dinelah/repositories/update_password_repository.dart';
import 'package:dinelah/res/app_assets.dart';
import 'package:dinelah/res/theme/theme.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:dinelah/ui/widget/common_button_white.dart';
import 'package:dinelah/ui/widget/common_widget.dart';
import 'package:dinelah/utils/ApiConstant.dart';
import 'package:dinelah/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class ResetForgotPassword extends StatefulWidget {
  const ResetForgotPassword({Key? key}) : super(key: key);

  @override
  State<ResetForgotPassword> createState() => _ResetForgotPasswordState();
}

class _ResetForgotPasswordState extends State<ResetForgotPassword> {
  var email;

  @override
  void initState() {
    super.initState();
    setState(() {
      email = Get.arguments[0];
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController newPassword = TextEditingController();
  bool obscure1 = true;
  bool obscure2 = true;

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
        appBar: AppBar(
          leadingWidth: AddSize.size45,
          leading: InkWell(
            child: Container(
                padding: EdgeInsets.only(left: AddSize.padding15),
                alignment: Alignment.centerLeft,
                child: Icon(Icons.arrow_back)),
            onTap: () {
              Get.back();
            },
          ),
          title: const Text(
            'Reset Password',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AddSize.padding16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  addHeight(screenSize.height * .05),
                  Center(
                      child: Image.asset(
                    AppAssets.forgotLogo,
                    height: 180,
                    width: 180,
                  )),
                  const Text(
                    'Reset Password',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: AddSize.padding10 * 1.8,
                        top: AddSize.padding15),
                    child: TextFormField(
                      controller: newPassword,
                      style: const TextStyle(color: Colors.white),
                      validator: MultiValidator([
                        RequiredValidator(
                          errorText: 'Password required',
                        ),
                        MinLengthValidator(6,
                            errorText:
                                'Password must contain minimum 6 characters'),
                      ]),
                      decoration: InputDecoration(
                        fillColor: AppTheme.colorEditFieldBg.withAlpha(90),
                        focusColor: AppTheme.primaryColor,
                        filled: true,
                        errorStyle: const TextStyle(color: Colors.white),
                        hintText: 'New Password',
                        contentPadding: EdgeInsets.only(
                            left: AddSize.padding10 * 2,
                            top: AddSize.padding10 * 2,
                            bottom: AddSize.padding10 * 2),
                        hintStyle: TextStyle(
                            color: Colors.white54, fontSize: AddSize.font14),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white54),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppTheme.primaryColorVariant),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: AppTheme.primaryColor, width: 2.0),
                            borderRadius: BorderRadius.circular(5.0)),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              obscure1 = !obscure1;
                            });
                          },
                          child: obscure1
                              ? Icon(
                                  Icons.visibility_off_outlined,
                                  size: AddSize.size10 * 1.8,
                                  color: Colors.white54,
                                )
                              : Icon(
                                  Icons.visibility_outlined,
                                  size: AddSize.size10 * 1.8,
                                  color: Colors.white54,
                                ),
                        ),
                      ),
                      obscureText: obscure1,
                    ),
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Confirm password required';
                      }
                      return MatchValidator(
                              errorText: 'Password does not matching')
                          .validateMatch(val, newPassword.text);
                    },
                    style: const TextStyle(
                      color: Colors.white54,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppTheme.colorEditFieldBg.withAlpha(90),
                      focusColor: AppTheme.primaryColor,
                      hintText: 'Confirm Password',
                      errorStyle: const TextStyle(color: Colors.white),
                      contentPadding: EdgeInsets.only(
                          left: AddSize.padding10 * 2,
                          top: AddSize.padding10 * 2,
                          bottom: AddSize.padding10 * 2),
                      hintStyle: TextStyle(
                          color: Colors.white54, fontSize: AddSize.font14),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white54),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppTheme.primaryColorVariant),
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: AppTheme.primaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(5.0)),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            obscure2 = !obscure2;
                          });
                        },
                        child: obscure2
                            ? Icon(
                                Icons.visibility_off_outlined,
                                size: AddSize.size10 * 1.8,
                                color: Colors.white54,
                              )
                            : Icon(
                                Icons.visibility_outlined,
                                size: AddSize.size10 * 1.8,
                                color: Colors.white54,
                              ),
                      ),
                    ),
                    obscureText: obscure2,
                  ),
                  addHeight(screenSize.width * .08),
                  CommonButtonWhite(
                    buttonHeight: 6,
                    buttonWidth: 100,
                    mainGradient: AppTheme.primaryGradientColor,
                    text: 'UPDATE NOW',
                    isDataLoading: true,
                    textColor: AppTheme.primaryColor,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        updatePassword(email, newPassword.text,
                                newPassword.text, context)
                            .then((value) {
                          showToast(value.message);
                          if (value.status) {
                            Get.offAllNamed(MyRouter.logInScreen, arguments: ['mainScreen']);
                          }
                          return null;
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
