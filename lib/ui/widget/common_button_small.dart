
import 'package:dinelah/res/size_config.dart';
import 'package:dinelah/res/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonButtonSmall extends StatelessWidget {
  double buttonWidth;
  final Gradient mainGradient;
  final Color btnColor;
  final Color textColor;
  final String text;
  bool isDataLoading;
  final VoidCallback onTap;
  final margin;
  double buttonHeight;

  CommonButtonSmall(
      {
        required this.buttonHeight,
        required this.buttonWidth,
        this.btnColor: AppTheme.primaryColor,
      this.textColor: Colors.white,
      this.isDataLoading: true,
      this.margin,
      required this.text,
      required this.onTap,
      required this.mainGradient});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: buttonHeight,
      padding: margin,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
          gradient: mainGradient, boxShadow: const [
        BoxShadow(
         color: AppTheme.etBgColor,
          offset: Offset(0.0, 1.5),
          blurRadius: 1.5,
        ),
      ]),
      child: MaterialButton(
        onPressed: onTap,
      //  color: btnColor,
        elevation: 0,
        minWidth: SizeConfig.widthMultiplier! * buttonWidth,
        // height: SizeConfig.heightMultiplier! * buttonHeight,
        child:
        Text(text,
                style: TextStyle(color: textColor, fontWeight: FontWeight.w700,fontSize: 16, letterSpacing: .2),
              ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
