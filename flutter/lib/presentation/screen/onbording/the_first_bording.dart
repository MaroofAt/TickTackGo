import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/presentation/screen/onbording/white_side.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          // there the base for title and dec 
          Description(),
          Positioned(child: 
          Container(
            width: width(context),
          
            decoration:BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(80),
                bottomRight: Radius.circular(80),
              )
            )
          ), 
          left: 0,
          right: 0,
          top: 0,
          bottom:height(context)*0.6 ,),
          Positioned(child:
           Container(
            padding: EdgeInsets.all(5),
            height: 100,
            width: 100,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.white),
            child: Center(child: Image.asset("assets/images/logo1larg.png",height:double.infinity, width: double.infinity,fit: BoxFit.contain,),)
          ) 
          ,left: width(context)/2-50,top: height(context)/2-140,
        )
          ,
        ],
      )
    );
  }
}