import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';


class CustomTextField {
  static Widget build({
    required BuildContext context,
    required TextEditingController controller,
    double? width, // Custom width
    double? height, // Custom height
    String? hint,
    TextInputType type = TextInputType.text,
    TextAlign textAlign = TextAlign.start,
    bool obscure = false,
    Color textColor = Colors.black,
    Color? backgroundColor,
    Color? hintColor,
    Color? borderColor,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return Container(
      width: width, // Set width
      height: height, // Set height
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: backgroundColor ?? white, // Default background color
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: borderColor ?? Colors.grey, // Default border color
          width: 2,
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: type,
        textAlign: textAlign,
        obscureText: obscure,
        style: TextStyle(
          color: textColor, // Text color
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: hintColor ?? Colors.grey, // Hint color
            fontSize: 16,
          ),
          border: InputBorder.none, // Remove default border
          prefixIcon: prefixIcon, // Custom prefix icon
          suffixIcon: suffixIcon, // Custom suffix icon
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }
}
