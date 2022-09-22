import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../res/theme/theme.dart';
import 'package:get/get.dart';

class CommonTextFieldWidgetSignUp extends StatelessWidget {
  IconData icon;
  String type;
  String hint;
  bool isPassword;
  RxBool isPasswordShow = false.obs;
  TextEditingController controller;

  CommonTextFieldWidgetSignUp({required this.hint,
    required this.icon,
    required this.type,
    required this.isPassword,
    required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                obscureText: isPasswordShow.value,
                validator: (value) {
                  if (type == '1' && value!.trim().isEmpty) {
                    return 'Email can\'t be empty.';
                  } else if (type == '2' && value!.trim().isEmpty) {
                    return 'Mobile No can\'t be empty.';
                  } else if (type == '2' && value!.trim().length != 10) {
                    return 'Mobile No should be 10 digit.';
                  } else if (type == '3' && value!.trim().length < 8) {
                    return 'Password can\'t be empty and should be grater then 8 and less then 16 digit.';
                  } else if (type == '4' && value!.trim().length < 8) {
                    return 'Password can\'t be empty and should be grater then 8 and less then 16 digit.';
                  }
                  return null;
                },
                keyboardType: type == '2' ? TextInputType.number : TextInputType
                    .text,
                // maxLength: isPassword ? 16 : 10,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    hintText: hint,
                    counterText: "",
                    filled: true,
                    errorMaxLines: 2,
                    fillColor: AppTheme.colorEditFieldBg,
                    focusColor: AppTheme.colorEditFieldBg,
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 18),
                    // focusedBorder: InputBorder.none,
                    // enabledBorder: InputBorder.none,
                    // errorBorder: InputBorder.none,
                    // disabledBorder: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: AppTheme.primaryColorVariant),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: AppTheme.primaryColorVariant),
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppTheme.primaryColor, width: 2.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    prefixIcon: Icon(icon, color: Colors.grey,
                    ),
                    suffixIcon: isPassword
                        ? GestureDetector(
                      onTap: () {
                        isPasswordShow.value = !isPasswordShow.value;
                      },
                      child: Icon(
                        CupertinoIcons.eye,
                        color: isPasswordShow.value
                            ? Colors.red
                            : Colors.grey,
                      ),
                    )
                        : SizedBox.shrink()),
              ),
            ),
          ],
        ),
      );
    });
  }

  bool isEmail(String em) {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
}
