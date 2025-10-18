import 'package:flutter/material.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_service.dart';
import '../../../core/constance/colors.dart';
import '../../widgets/create_text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;
  bool _obscurePassword = true;
  String? errorEmail;
  String? errorPassword;
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

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Middle box for the Textfield
            Container(
              width: width(context),
              height: height(context),
              decoration: const BoxDecoration(color: primaryColor),
              child: Column(
                children: [
                  const SizedBox(height: 335),
                  CreateTextField(
                    text: "Your name",
                    icon: const Icon(Icons.person_2_outlined),
                    controller: _nameController,
                  ),
                  if (errorname != null)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 200, top: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            errorname!,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  CreateTextField(
                    text: "Your Email",
                    icon: const Icon(Icons.email),
                    controller: _emailController,
                  ),
                  if (errorEmail != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 200, top: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          errorEmail!,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  CreateTextField(
                    text: "Your Password",
                    icon: const Icon(Icons.lock_outline_rounded),
                    obscureText: _obscurePassword,
                    controller: _passwordController,
                    iconSuf: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  if (errorPassword != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          errorPassword!,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Header box (purple)
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: width(context),
                height: height(context) - 520,
                decoration: const BoxDecoration(
                  color: ampleOrange,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(400)),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Container(
                      padding: const EdgeInsets.only(top: 90, right: 180),
                      child: Text(
                        "Create",
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white.withAlpha(1),
                          fontFamily: "DMSerifText",
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 150),
                      child: Text(
                        "Account",
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white.withAlpha(1),
                          fontFamily: "DMSerifText",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom white box
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: width(context) - 100,
                height: height(context) - 610,
                decoration: const BoxDecoration(
                  color: ampleOrange,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(400)),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(400)),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: loading
                            ? CircularProgressIndicator(
                                strokeWidth: 2.0,
                                valueColor: AlwaysStoppedAnimation(
                                  const Color(0xfff5b99c).withAlpha(1),
                                ),
                              )
                            : const Icon(Icons.arrow_right_alt_sharp),
                        iconSize: 40,
                        color: Colors.white.withAlpha(1),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 100, left: 80),
                      child: IconButton(
                        onPressed: () {
                          NavigationService().pushReplacementNamed(context, signInName);
                          // Navigator.of(context).pushReplacement(
                          //     MaterialPageRoute(builder: (context) => SignIn()));
                        },
                        icon: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              decorationColor: parrotGreen,
                              decorationThickness: 2,
                              fontFamily: "DMSerifText",
                            ),
                            text: 'Sign In',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              bottom: height(context) * 0.21,
              right: width(context) * 0.19,
              child: Container(
                margin: const EdgeInsets.only(top: 60),
                padding: const EdgeInsets.only(right: 180),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white.withAlpha(1),
                    fontFamily: "DMSerifText",
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
