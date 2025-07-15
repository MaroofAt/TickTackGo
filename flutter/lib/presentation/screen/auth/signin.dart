


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/presentation/screen/auth/signup.dart';
import 'package:pr1/presentation/widgets/creatTextFiled.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<StatefulWidget> createState() {
    return SignInstate();
  }
}

class SignInstate extends State<StatefulWidget> {
bool loading = false;
  bool _obscurePassword = true;
  String? erroremail;
  String? errorpassword;
  String? errorname;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

 

  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  

bool validateFields() {
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
    return Scaffold(
        body: SingleChildScrollView(
            child: Stack(children: [
              Container(
                width: width(context),
                height: height(context),
                decoration: const BoxDecoration(
                  color: primaryColor,
                ),
                child: Column(children: [
                  const SizedBox(height: 480),
                  CreateTextField(
                    text: "Your Email",
                    icon: const Icon(Icons.email),
                    controller: _emailController,
                  ),
                  if (erroremail != null)
                    Padding(
                      padding: const EdgeInsets.only(left:200, top: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          erroremail!,
                          style: const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  CreateTextField(
                    text: "Your Password",
                    icon: const Icon(Icons.lock_outline_rounded),
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
                  ),
                  if (errorpassword != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 200, top: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          errorpassword!,
                          style: const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    ),
                  Row(children: [
                    Container(
                      margin: const EdgeInsets.only(left: 80, top: 20),
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: 28,
                            color:white,
                            fontFamily: "DMSerifText"),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 80, top: 30),
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: ampleOrange,
                        borderRadius: BorderRadius.all(Radius.circular(400)),
                      ),
                      child: IconButton(
                        onPressed: () {
                          loading=!loading;
                             if (validateFields()) {
                            print("All fields are valid");
                          
                            print("Email: ${_emailController.text}");
                            print("Password: ${_passwordController.text}");

                          
                        }},
                        icon: (loading)?
                        const CircularProgressIndicator(strokeWidth: 2.0,
                            valueColor:AlwaysStoppedAnimation(white,
                        )):const Icon(Icons.arrow_right_alt_sharp,size:40,color: white,)
                     
                      ),
                    )
                  ]),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 50,top:20),
                        child: IconButton(onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => SignUp()));
                        },
                          icon:RichText(
                            text: TextSpan(
                              style: TextStyle(fontSize: 20, color: white,  decoration: TextDecoration.underline,
                                  decorationColor: parrotGreen, decorationThickness: 2,fontFamily: "DMSerifText"),
                              text: 'Sign Up',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 80,top:20),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: 16,
                                color: white,
                                decoration: TextDecoration.underline,
                                decorationColor: parrotGreen,
                                decorationThickness: 3,
                                fontFamily: "DMSerifText"),
                            text: 'Forgot Passwords',


                          ),
                        ),
                      ),
                    ],
                  )
                ]),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: width(context) - 200,
                  height:height(context) - 350,
                  decoration: BoxDecoration(
                    color:  parrotGreen,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(600)),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                    width: width(context),
                    height: height(context) - 450,
                    decoration: BoxDecoration(
                      color: ampleOrange,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(600, 400),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 120, top: 180),
                            // padding: EdgeInsets.only(top: 90, right: 180),
                            child: Text(
                              "Welcome",
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Color(0xffffff).withOpacity(1),
                                  fontFamily: "DMSerifText"),
                            )),
                        Container(
                            margin: EdgeInsets.only(left: 55),
                            child: Text(
                              "Back",
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Color(0xffffff).withOpacity(1),
                                  fontFamily: "DMSerifText"),
                            )),
                      ],
                    )),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: width(context) - 180,
                  height: height(context) - 680,
                  decoration: BoxDecoration(
                    color:  parrotGreen,
                    borderRadius:
                    BorderRadius.only(bottomRight: Radius.elliptical(600, 500)),
                  ),
                ),
              ),
            ])));
  }

}