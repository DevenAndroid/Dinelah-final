import 'dart:convert';

import 'package:dinelah/res/app_assets.dart';
import 'package:dinelah/res/strings.dart';
import 'package:dinelah/res/theme/theme.dart';
import 'package:dinelah/routers/my_router.dart';
import 'package:dinelah/ui/widget/common_button.dart';
import 'package:dinelah/ui/widget/common_text_field.dart';
import 'package:dinelah/ui/widget/common_text_field_sign_up.dart';
import 'package:dinelah/ui/widget/common_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({Key? key}) : super(key: key);

  @override
  State<PaymentDetails> createState() => PaymentDetailsState();
}

class PaymentDetailsState extends State<PaymentDetails> {
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();

  RxBool isDataLoading = false.obs;
  final loginFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: backAppBar('Payment Details'),
      backgroundColor: AppTheme.colorBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              children: [
                addHeight(screenSize.height*.04),
                Image.asset(AppAssets.paymentDetail,height: 120,width: 120,),
                addHeight(screenSize.height*.04),
                CommonTextFieldWidgetSignUp(
                  hint: Strings.bankName,
                  controller: userNameController,
                  icon: Icons.food_bank_outlined,
                  isPassword: false,
                  type: '1',
                ),
                addHeight(12),
                CommonTextFieldWidget(
                  hint: Strings.bankAccountNumber,
                  controller: userNameController,
                  icon: Icons.food_bank_outlined,
                  bgColor: AppTheme.etBgColor,
                ),
                addHeight(12),
                CommonTextFieldWidget(
                  hint: Strings.accountHolderName,
                  controller: userNameController,
                  icon: Icons.person_outline,
                  bgColor: AppTheme.etBgColor,
                ),
                addHeight(12),
                CommonTextFieldWidget(
                  hint: Strings.routingNumber,
                  controller: userNameController,
                  icon: Icons.keyboard_outlined,
                  bgColor: AppTheme.etBgColor,
                ),
                addHeight(screenSize.width*.12),
                CommonButton(
                  buttonHeight: 6,
                  buttonWidth: 100,
                  mainGradient: AppTheme.primaryGradientColor,
                  text: Strings.buttonUpdate,
                  isDataLoading: true,
                  textColor: Colors.white,
                  onTap: () {
                    // Get.offAndToNamed(MyRouter.logScreen);
                    //Get.toNamed(MyRouter.paymentDetailsScreen);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}