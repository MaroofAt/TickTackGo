
import 'package:flutter/material.dart';
import 'package:pr1/core/constance/constance.dart';
import '../../core/constance/colors.dart';

class CreateTextField extends StatelessWidget {
  final String text;
  final Icon? icon;
  final IconButton? iconSuf;
  final bool obscureText;
  final TextEditingController controller;
  final Color? fillcolor;
  final TextInputType? keyboardType;

  
  const CreateTextField({super.key, 
    required this.text,
    this.icon,
    this.iconSuf,
    this.obscureText = false,
    required this.controller,
    this.fillcolor,
    this.keyboardType,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context) *0.9,
      height: 50,
      margin: const EdgeInsets.only(top: 10),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: icon,
          suffixIcon: iconSuf ?? const SizedBox(),
          filled: true,
          fillColor:fillcolor?? ampleOrange.withOpacity(0.5),
          hintText: text,
          hintStyle: const TextStyle(
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
    );
  }
}