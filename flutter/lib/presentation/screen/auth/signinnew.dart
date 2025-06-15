import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';

import '../../widgets/creatTextFiled.dart';

class Signinnew extends StatefulWidget {
  const Signinnew({super.key});

  @override
  State<Signinnew> createState() => _SigninnewState();
}

class _SigninnewState extends State<Signinnew>  {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? erroremail;
  String? errorpassword;
  String? errorname;
  bool _obscurePassword = true;
  @override
  void initState() {
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _validateFields() {
    setState(() {
      // Email validation
      if (_emailController.text.isEmpty) {
        erroremail = 'Please enter your email';
      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_emailController.text)) {
        erroremail = 'Please enter a valid email';
      } else {
        erroremail = null;
      }

      // Password validation
      if (_passwordController.text.isEmpty) {
        errorpassword = 'Please enter your password';
      } else if (_passwordController.text.length < 8) {
        errorpassword = 'Password must be at least 8 characters';
      } else {
        errorpassword = null;
      }
    });

    return erroremail == null && errorpassword == null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100,),
      const Center(child: Text("Hello!",style: TextStyle(color: white,fontSize: 34,fontFamily: 'PTSerif'),),),
        const Center(child: Text("enter your details below",style: TextStyle(color: white,fontSize: 18,fontFamily: 'PTSerif'),),),
     const SizedBox(
       height: 20,
     ),
           Container(child: Text("E-mail",style: TextStyle(color: white,fontSize: 20,fontFamily: 'PTSerif'),textAlign:TextAlign.start),margin: EdgeInsets.only(left: 10),)
          , Container(child:  CreateTextField(
             text: "Your Email",
             icon: Icon(Icons.email),
             controller: _emailController,
           ),margin: EdgeInsets.only(left: 15,),),
            SizedBox(height: 3,),
            if (erroremail != null)
              Padding(
                padding: const EdgeInsets.only(left:20,bottom: 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    erroremail!,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              ),
            Container(child: Text("Password",style: TextStyle(color: white,fontSize: 20,fontFamily: 'PTSerif'),textAlign:TextAlign.start) ,margin: EdgeInsets.only(left: 10),),
           Container(child:  CreateTextField(
             text: "Your Password",
             icon: Icon(Icons.lock_outline_rounded),
             obscureText: _obscurePassword,
             controller: _passwordController,
             iconsuf: IconButton(
               icon: Icon(
                 _obscurePassword ? Icons.visibility_off : Icons.visibility,
                 color: Colors.grey,
               ),
               onPressed: () {
                 setState(() {
                   _obscurePassword = !_obscurePassword;
                 });
               },
             ),
           ),margin: EdgeInsets.only(left: 15,),) ,
    SizedBox(height:3,),
    if (errorpassword != null)
    Padding(
    padding: const EdgeInsets.only(left: 20),
    child: Align(
    alignment: Alignment.centerLeft,
    child: Text(
    errorpassword!,
    style: TextStyle(color: Colors.red, fontSize: 12),
    ),
    ),
    ),
            Container(margin:EdgeInsets.only(left: width(context)*0.67
            ),child: Text("forget password?",style: TextStyle(color: lightGrey,fontSize: 14,fontFamily: 'PTSerif'),textAlign:TextAlign.end),)
        , Container(
              margin: EdgeInsets.only(left: 15,top:20,bottom: 40),
              decoration:BoxDecoration(color:parrotGreen,borderRadius: BorderRadius.all(Radius.circular(10))),width: width(context)*0.9,
                child: IconButton(onPressed: (){
    if (_validateFields()) {
    print("All fields are valid");

    print("Email: ${_emailController.text}");
    print("Password: ${_passwordController.text}");

    }}, icon: Text("Sign in",style: TextStyle(color: Colors.black,fontSize: 20,fontFamily: 'PTSerif')))),
         Row(
           children: [
Container(child: Icon(Icons.key_sharp,color: lightGrey),margin:EdgeInsets.only(left: width(context)*0.354
)),
             SizedBox(width: 5,),
             Container(child: Text("continues with",style: TextStyle(color: lightGrey,fontSize: 14,fontFamily: 'PTSerif'),textAlign:TextAlign.end),)
             ,
           ],
         ),
            Container(

              padding: EdgeInsets.only(left: 50),
                margin: EdgeInsets.only(left: 15,top:40,bottom: 40),
                decoration:BoxDecoration(color:ampleOrange.withOpacity(0.5),borderRadius: BorderRadius.all(Radius.circular(10) )),width: width(context)*0.9,
                child: IconButton(onPressed: (){}, icon:Row(
                  children: [
  Container(child: Image.asset("google.png"),width: 25,height: 25,),
                    SizedBox(width: 10,),
                    Text("Sign in with Google",style: TextStyle(color:white,fontSize: 20,fontFamily: 'PTSerif'))
                  ],
                ))),

          ],
        ),
      ),
    );
  }
}
