import 'package:dinelah/res/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonTextFieldWidget extends StatelessWidget {
  IconData icon;
  Color bgColor;
  bool isPassword;
  RxBool isPasswordShow = false.obs;
  String hint;
  TextEditingController controller;

  CommonTextFieldWidget(
      {required this.icon,
      this.isPassword: false,
      required this.hint,
      required this.controller,
      required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Obx(() => IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  obscureText: isPasswordShow.value,
                  autofillHints: const [AutofillHints.email, AutofillHints.username, AutofillHints.newUsername],
                  validator: (value) {
                    if (isPassword) {
                      if (value!.trim().isEmpty) {
                        return 'Please enter password';
                      } else if (value.length < 4) {
                        return 'Password must be greater then 6';
                      }
                      /*else if (!validatePassword(value)) {
                  return 'Password must be a combination of upper and lower with special char and number';
                } */
                      else if (value.length > 16) {
                        return 'Password must be less then 16';
                      }
                    } else {
                      if (value!.trim().isEmpty) {
                        return 'Please enter username or email';
                      } else if (value.length < 4) {
                        return 'Please enter valid username or email';
                      }
                    }
                    return null;
                  },
                  keyboardType:
                      isPassword ? TextInputType.text : TextInputType.text,
                  maxLength: isPassword ? 16 : 150,
                  textInputAction:
                      isPassword ? TextInputAction.done : TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: hint,
                      counterText: "",
                      filled: true,
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
                      prefixIcon: Icon(
                        icon,
                        color: Colors.grey,
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
        ));
  }
}
