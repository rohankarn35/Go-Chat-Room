import 'package:flutter/material.dart';

class Custombutton {
  Widget customButoon({
    required String buttonText,
    required double height,
    required double width,
    required Color color,
    Color textColor = Colors.white,
    double fontSize = 16,
    BorderRadius? borderRadius,
    required VoidCallback onpressed,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onpressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: textColor,
          backgroundColor: color,
          side: BorderSide(color: Colors.black),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(8),
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: textColor),
        ),
      ),
    );
  }
}
