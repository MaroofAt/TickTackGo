import 'package:flutter/material.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/presentation/screen/auth/signin.dart';
import '../../../core/constance/colors.dart';
import '../../widgets/creatTextFiled.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;
  bool _obscurePassword = true;
  String? erroremail;
  String? errorpassword;
  String? errorname;

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validateFields() {
    setState(() {
      // Name validation
      if (_nameController.text.isEmpty) {
        errorname = 'Please enter your name';
      } else if (_nameController.text.length < 3) {
        errorname = 'Name must be at least 3 characters';
      } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(_nameController.text)) {
        errorname = 'Name can only contain letters and spaces';
      } else {
        errorname = null;
      }

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
      } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(_passwordController.text)) {
        errorpassword = 'Password must contain:\n- 1 uppercase\n- 1 lowercase\n- 1 number';
      } else {
        errorpassword = null;
      }
    });

    return errorname == null && erroremail == null && errorpassword == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Middle box for the Textfields
            Container(
              width: width(context),
              height: height(context),
              decoration: BoxDecoration(color: primaryColor),
              child: Column(
                children: [
                  SizedBox(height: 335),
                  CreateTextField(
                    text: "Your name",
                    icon: Icon(Icons.person_2_outlined),
                    controller: _nameController,
                  ),
                  if (errorname != null)
                   Center(
                    child:  Padding(
                      padding: const EdgeInsets.only(left: 20, top: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          errorname!,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    ),
                   ),
                  SizedBox(height: 20),
                  CreateTextField(
                    text: "Your Email",
                    icon: Icon(Icons.email),
                    controller: _emailController,
                  ),
                  if (erroremail != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          erroremail!,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    ),
                  SizedBox(height: 20),
                  CreateTextField(
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
                  ),
                  if (errorpassword != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          errorpassword!,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Header box (purple)
            Positioned(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Container(
                      padding: EdgeInsets.only(top: 90, right: 180),
                      child: Text(
                        "Create",
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white.withOpacity(1),
                          fontFamily: "DMSerifText",
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 150),
                      child: Text(
                        "Account",
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white.withOpacity(1),
                          fontFamily: "DMSerifText",
                        ),
                      ),
                    ),
                  ],
                ),
                width: width(context),
                height: height(context) - 520,
                decoration: BoxDecoration(
                  color: Ample_orang,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(400)),
                ),
              ),
              left: 0,
              top: 0,
            ),

            // Bottom white box
            Positioned(
              child: Container(
                width: width(context) - 100,
                height: height(context) - 610,
                decoration: BoxDecoration(
                  color: Ample_orang,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(400)),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(400)),
                      ),
                      child: IconButton(
                        onPressed: () {
                          if (_validateFields()) {
                            print("All fields are valid");
                            print("Name: ${_nameController.text}");
                            print("Email: ${_emailController.text}");
                            print("Password: ${_passwordController.text}");
                            // Proceed with sign up
                           
                          }
                        },
                        icon: loading
                            ? CircularProgressIndicator(
                                strokeWidth: 2.0,
                                valueColor: AlwaysStoppedAnimation(
                                  Color(0xf5b99c).withOpacity(1),
                                ),
                              )
                            : Icon(Icons.arrow_right_alt_sharp),
                        iconSize: 40,
                        color: Colors.white.withOpacity(1),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        onPressed: () {
                          pushReplacementNamed(context, signinRoute);
                          // Navigator.of(context).pushReplacement(
                          //     MaterialPageRoute(builder: (context) => SignIn()));
                        },
                        icon: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              decorationColor: parrot_green,
                              decorationThickness: 2,
                              fontFamily: "DMSerifText",
                            ),
                            text: 'Sign In',
                          ),
                        ),
                      ),
                      margin: EdgeInsets.only(top: 100, left: 80),
                    ),
                  ],
                ),
              ),
              right: 0,
              bottom: 0,
            ),
         
             Positioned(child:  Container(
                    margin: EdgeInsets.only(top: 60),
                    padding: EdgeInsets.only(right: 180),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white.withOpacity(1),
                        fontFamily: "DMSerifText",
                      ),
                    ),
                  ),
                  bottom: height(context)*0.21,right: width(context)*0.19,)
         
         
         
          ],
        ),
      ),
    );
  }
}