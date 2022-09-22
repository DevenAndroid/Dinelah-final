import 'package:dinelah/res/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonTextFieldMultiLineWidgetForm extends StatelessWidget {
  String hint;
  TextEditingController controller;

  CommonTextFieldMultiLineWidgetForm({required this.hint, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
              color: AppTheme.colorWhite,
              border: Border.all(width: .5, color: Colors.grey),
              borderRadius: BorderRadius.circular(5)),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.multiline,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: hint,
              fillColor: AppTheme.primaryColor,
              focusColor: AppTheme.primaryColor,
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
        );
  }
}
