import 'package:flutter/material.dart';
import 'package:pr1/core/constance/constance.dart';
import '../../core/constance/colors.dart';

class CreateTextField extends StatelessWidget {
  final String text;
  final Icon? icon;
  final IconButton? iconsuf;
  final bool obscureText;
  final TextEditingController controller;
  
  CreateTextField({
    required this.text,
    this.icon,
    this.iconsuf,
    this.obscureText = false,
    required this.controller,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: icon,
          suffixIcon: iconsuf ?? const SizedBox(),
          filled: true,
          fillColor: ampleOrange.withOpacity(0.5),
          hintText: text,
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontFamily: "DMSerifText",
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      width: width(context) - 100,
      height: 50,
      margin: EdgeInsets.only(top: 10),
    );
  }
}