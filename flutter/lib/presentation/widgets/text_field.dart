import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';

class MyTextField {
  static Widget textField(
    context,
    controller, {
    TextAlign? textAlign,
    TextInputType? type,
    bool obscure = false,
    Color textColor = black,
    Color? hintColor,
    Color? borderColor,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? hint,
    Function(String query)? onChanged,
    int maxLines = 1,
    int minLines = 1,
  }) {
    return TextField(
      textAlign: textAlign ?? TextAlign.start,
      controller: controller,
      keyboardType: type,
      onChanged: onChanged,
      style: TextStyle(color: textColor),
      obscureText: obscure,
      maxLines: maxLines,
      minLines: minLines,
      decoration: InputDecoration(
        fillColor: white,
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        hintStyle: TextStyle(
          fontSize: 16,
          color: hintColor ?? Theme.of(context).hintColor,
        ),
        prefixIcon: SizedBox(
          height: 15,
          width: 15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              prefixIcon != null
                  ? Container(
                      width: 25,
                      height: 25,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: prefixIcon,
                    )
                  : Container(),
            ],
          ),
        ),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(width: 2, color: black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(width: 2, color: borderColor ?? lightGrey),
        ),
      ),
    );
  }
}
