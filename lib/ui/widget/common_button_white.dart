import 'package:dinelah/res/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonButtonWhite extends StatelessWidget {
  double buttonWidth;
  final Gradient mainGradient;
  final Color btnColor;
  final Color textColor;
  final String text;
  bool isDataLoading;
  final VoidCallback onTap;
  final margin;
  double buttonHeight;

  CommonButtonWhite(
      {required this.buttonHeight,
      required this.buttonWidth,
      this.btnColor: Colors.white,
      this.textColor: Colors.black87,
      this.isDataLoading: false,
      this.margin,
      required this.text,
      required this.onTap,
      required this.mainGradient});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: MaterialButton(
        onPressed: onTap,
        color: btnColor,
        elevation: 0,
        minWidth: SizeConfig.widthMultiplier! * buttonWidth,
        // : SpinKitRing(
        //     color: textColor,
        //     lineWidth: 3,
        //     size: 26,
        //   ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        // height: SizeConfig.heightMultiplier! * buttonHeight,
        child:
            // !isDataLoading ?
            Text(
          text,
          style: TextStyle(
              color: textColor, fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
    );
  }
}
