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
          prefixIcon: icon?? null,
          suffixIcon: iconsuf ?? const SizedBox(),
          filled: true,
          fillColor: Ample_orang.withOpacity(0.5),
          hintText: text,
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontFamily: "DMSerifText",
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      width: width(context)*0.9,
      height: 50,
      margin: EdgeInsets.only(top: 10),
    );
  }
}