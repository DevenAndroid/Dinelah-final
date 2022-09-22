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

class EarningsScreen extends StatefulWidget {
  const EarningsScreen({Key? key}) : super(key: key);

  @override
  State<EarningsScreen> createState() => EarningsScreenState();
}

class EarningsScreenState extends State<EarningsScreen> {
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
      appBar: backAppBar('Earnings'),
      backgroundColor: AppTheme.colorBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              children: [
                addHeight(screenSize.height * .01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    getCard(screenSize, Colors.black87),
                    getCard(screenSize, AppTheme.primaryColor),
                    getCard(screenSize, Colors.black87)
                  ],
                ),
                addHeight(screenSize.width*.04),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Amount',
                              style: (TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700)),
                            ),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                              ),
                              child: MaterialButton(
                                onPressed: () {},
                                elevation: 0,
                                child: Row(
                                  children: [
                                    Text(
                                      'Start Date',
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                    addWidth(4),
                                    Icon(
                                      Icons.calendar_today_outlined,
                                      size: 16,
                                      color: Colors.grey.shade600,
                                    )
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                              ),
                              child: MaterialButton(
                                onPressed: () {},
                                elevation: 0,
                                child: Row(
                                  children: [
                                    Text(
                                      'Start Date',
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                    addWidth(4),
                                    Icon(
                                      Icons.calendar_today_outlined,
                                      size: 16,
                                      color: Colors.grey.shade600,
                                    )
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                        addHeight(screenSize.height*.024),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ID',
                                style: (TextStyle(
                                    color: Colors.black87,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700)),
                              ),
                              Text(
                                'Date',
                                style: (TextStyle(
                                    color: Colors.black87,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700)),
                              ),
                              Text(
                                'Amount',
                                style: (TextStyle(
                                    color: Colors.black87,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700)),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                            itemCount: 4,
                            shrinkWrap: true,
                            itemBuilder: (context, index){
                          return Column(
                            children: [
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '#132-232',
                                      style: (TextStyle(
                                          color: Colors.black87.withAlpha(150),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                    ),
                                    Text(
                                      '13 Jan 2020',
                                      style: (TextStyle(
                                          color: Colors.black87.withAlpha(150),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                    ),
                                    Text(
                                      '+\$500',
                                      style: (TextStyle(
                                          color: Colors.green,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),

                addHeight(screenSize.width*.12),
                CommonButton(
                  buttonHeight: 6,
                  buttonWidth: 86,
                  mainGradient: AppTheme.primaryGradientColor,
                  text: Strings.buttonWithdrawRequest,
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

  Card getCard(Size screenSize, color) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              child: Icon(Icons.person_outline),
              backgroundColor: Colors.white,
              radius: 26,
            ),
            addHeight(screenSize.height * .012),
            Text(
              'Total Delivery',
              style:
                  (TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            ),
            addHeight(screenSize.height * .006),
            Text(
              '150',
              style: (TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w800)),
            )
          ],
        ),
      ),
    );
  }
}
