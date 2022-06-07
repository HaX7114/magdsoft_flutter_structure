import 'package:flutter/material.dart';
import 'package:magdsoft_flutter_structure/constants/style_values.dart';
import 'package:magdsoft_flutter_structure/presentation/styles/colors.dart';

class RawButton extends StatelessWidget {
  final String buttonText;
  final height;
  final Function() onPressed;
  double? width;
  Color textColor;
  Color buttonColor;

  RawButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.height,
    this.width,
    this.buttonColor = AppColor.blue,
    this.textColor = AppColor.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: RawMaterialButton(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(StyleValues.borderRadius),
        ),
        fillColor: buttonColor,
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
