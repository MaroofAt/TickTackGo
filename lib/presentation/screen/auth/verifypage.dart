import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';

class Verifypage extends StatefulWidget {
  @override
  Verifypagestate createState() => Verifypagestate();
}

class Verifypagestate extends State<Verifypage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
        child:  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 40,),
  Center(child:  Text("Verfiy account",textAlign: TextAlign.center,style: TextStyle(fontSize: 30,color: white,fontWeight: FontWeight.bold),),)
      , Container(child: 
       Image.asset("assets/images/verfiy.png"),),
        Center(child:  Text("We have just send 4 degit\n code via your email",textAlign: TextAlign.center,style: TextStyle(fontSize: 16,color: white,fontWeight: FontWeight.normal),),)
      ,SizedBox(height: 20,)
,      Container(child:Column(
  children: [
    SizedBox(height: 30,)
,    Pinput(
      ) ,
      IconButton(onPressed: (){

      }, icon: Container(width: width(context)*0.4,height: height(context)*0.05,
        child: Center(child: Text("Verfiy"),),decoration: BoxDecoration(color: white,borderRadius: BorderRadius.all(Radius.circular(50))),))
  ],
)
, width: width(context)*0.8,
      height: height(context)*0.2,
      decoration: BoxDecoration(
        color: Ample_orang,
        borderRadius: BorderRadius.all(Radius.circular(40))
      ),
      ),
      






      
      ],
    ) ,) ,
     
    
    backgroundColor: primaryColor,
    )
  ;
  }
}
