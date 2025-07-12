import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/auth_cubit/auth_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/presentation/screen/auth/signinnew.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';

import '../../../core/constance/strings.dart';
import '../../../core/functions/navigation_functions.dart';
import '../../widgets/creatTextFiled.dart';

class Signupnew extends StatefulWidget {
  const Signupnew({super.key});

  @override
  State<Signupnew> createState() => SignUpnewstate();
}

class SignUpnewstate extends State<Signupnew>  {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
      //// Name validation
      if (nameController.text.isEmpty) {
        errorname = 'Please enter your name';
      } else if (nameController.text.length < 3) {
        errorname = 'Name must be at least 3 characters';
      }
      else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(nameController.text)) {
        errorname = 'Name can only contain letters and spaces';
      } else {
        errorname = null;
      }
      // Email validation
      if (emailController.text.isEmpty) {
        erroremail = 'Please enter your email';
      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailController.text)) {
        erroremail = 'Please enter a valid email';
      } else {
        erroremail = null;
      }

      // Password validation
      if (passwordController.text.isEmpty) {
        errorpassword = 'Please enter your password';
      } else if (passwordController.text.length < 8) {
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
      body: BlocBuilder<AuthCubit,AuthState>(
  builder: (context, state) {
    bool isloading=BlocProvider.of<AuthCubit>(context).isloading;
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100,),
            const Center(child: Text("Hello!",style: TextStyle(color: white,fontSize: 34,fontFamily: 'PTSerif'),),),
            const Center(child: Text("enter your details below",style: TextStyle(color: white,fontSize: 18,fontFamily: 'PTSerif'),),),
            const SizedBox(
              height: 20,
            ),
            Container(child: Text("Name",style: TextStyle(color: white,fontSize: 20,fontFamily: 'PTSerif'),textAlign:TextAlign.start),margin: EdgeInsets.only(left: 10),),
           Container(child:  CreateTextField(
             text: "Your name",
             icon: Icon(Icons.person_2_outlined),
             controller: nameController,
           ),margin: EdgeInsets.only(left: 15),),
            if (errorname != null)
              Center(
                child:  Padding(
                  padding: const EdgeInsets.only(left: 20,bottom: 5,top:3),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      errorname!,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                ),
              ),
            SizedBox(height: 20,),
            Container(child: Text("E-mail",style: TextStyle(color: white,fontSize: 20,fontFamily: 'PTSerif'),textAlign:TextAlign.start),margin: EdgeInsets.only(left: 10),)
            , Container(child:  CreateTextField(
              text: "Your Email",
              icon: Icon(Icons.email),
              controller: emailController,
            ),margin: EdgeInsets.only(left: 15,),), if (erroremail != null)
              Padding(
                padding: const EdgeInsets.only(left:20,bottom: 5,top:3),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    erroremail!,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              ),
            SizedBox(height: 20,),
            Container(child: Text("Password",style: TextStyle(color: white,fontSize: 20,fontFamily: 'PTSerif'),textAlign:TextAlign.start) ,margin: EdgeInsets.only(left: 10),),
            Container(child:  CreateTextField(
              text: "Your Password",
              icon: Icon(Icons.lock_outline_rounded),
              obscureText: _obscurePassword,
              controller: passwordController,
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
            ),margin: EdgeInsets.only(left: 15),) ,
            if (errorpassword != null)
              Padding(
                padding: const EdgeInsets.only(left: 20,top:3),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    errorpassword!,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              ), SizedBox(height: 20,),
            Container(
                margin: EdgeInsets.only(left: 15,top:20,bottom: 20),
                decoration:BoxDecoration(color:parrotGreen, borderRadius: BorderRadius.all(Radius.circular(10))),width: width(context)*0.9,
                child: IconButton(onPressed: (){
                  if (_validateFields()) {
                    print("All fields are valid");

                    print("Email: ${emailController.text}");
                    print("Password: ${passwordController.text}");
                  }
                  if(erroremail == null && errorname == null && errorpassword == null ) {
                    context.read<AuthCubit>().initializeModel(
                        nameController.text, passwordController.text,
                        emailController.text);
                    context.read<AuthCubit>().sendEmailForOTP(
                        emailController.text, context
                    );
                  }
                  }, icon:isloading? CircularProgressIndicator(color: ampleOrange,strokeWidth:3)
                    : Text("Sign Up",style: TextStyle(color: Colors.black,fontSize: 20,fontFamily: 'PTSerif')))),
            Container(child: Text("Or",style: TextStyle(color: lightGrey,fontSize: 14,fontFamily: 'PTSerif'),textAlign:TextAlign.end),margin:EdgeInsets.only(left:width(context)*0.48))
            , Container(
                margin: EdgeInsets.only(left: 15,top:20,bottom: 20),
                decoration:BoxDecoration(color:ampleOrange, borderRadius: BorderRadius.all(Radius.circular(10))),width: width(context)*0.9,
                child: IconButton(onPressed: (){
                  pushReplacementScreen(context, BlocProvider(
                    create: (context) => AuthCubit(),
                    child:Signinnew(),
                  ));                 }, icon: Text("Sign In",style: TextStyle(color: Colors.black,fontSize: 20,fontFamily: 'PTSerif')))),


          ],
        ),
      );
  },
),
    );
  }
}
