
import 'package:flutter/material.dart';
import 'package:flutter_grocery/utill/color_resources.dart';
import 'package:flutter_grocery/utill/dimensions.dart';
import 'package:flutter_grocery/utill/styles.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final double margin;
  final Color? textColor;
  CustomButton({required this.buttonText, required this.onPressed, this.margin = 0, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(margin),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: onPressed == null ? ColorResources.getHintColor(context) : Theme.of(context).primaryColor,
          minimumSize: Size(MediaQuery.of(context).size.width, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(buttonText, style: poppinsMedium.copyWith(
          color: textColor != null ? textColor : Theme.of(context).cardColor,
          fontSize: Dimensions.FONT_SIZE_LARGE,
        )),
      ),
    );
  }
}
