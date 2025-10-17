import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pr1/business_logic/auth_cubit/auth_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/presentation/screen/auth/sign_in_new.dart';

import '../../../core/functions/navigation_functions.dart';
import '../../widgets/create_text_field.dart';

class SignUpNew extends StatefulWidget {
  const SignUpNew({super.key});

  @override
  State<SignUpNew> createState() => SignUpNewState();
}

class SignUpNewState extends State<SignUpNew> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? errorEmail;
  String? errorPassword;
  String? errorname;
  bool _obscurePassword = true;

  bool _validateFields() {
    setState(() {
      //// Name validation
      if (nameController.text.isEmpty) {
        errorname = 'Please enter your name';
      } else if (nameController.text.length < 3) {
        errorname = 'Name must be at least 3 characters';
      } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(nameController.text)) {
        errorname = 'Name can only contain letters and spaces';
      } else {
        errorname = null;
      }
      // Email validation
      if (emailController.text.isEmpty) {
        errorEmail = 'Please enter your email';
      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
          .hasMatch(emailController.text)) {
        errorEmail = 'Please enter a valid email';
      } else {
        errorEmail = null;
      }

      // Password validation
      if (passwordController.text.isEmpty) {
        errorPassword = 'Please enter your password';
      } else if (passwordController.text.length < 8) {
        errorPassword = 'Password must be at least 8 characters';
      } else {
        errorPassword = null;
      }
    });

    return errorEmail == null && errorPassword == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          bool isLoading = BlocProvider.of<AuthCubit>(context).isLoading;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Center(
                  child: Text(
                    "Hello!",
                    style: TextStyle(
                        color: white, fontSize: 34, fontFamily: 'PTSerif'),
                  ),
                ),
                const Center(
                  child: Text(
                    "enter your details below",
                    style: TextStyle(
                        color: white, fontSize: 18, fontFamily: 'PTSerif'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text("Name",
                      style: TextStyle(
                          color: white, fontSize: 20, fontFamily: 'PTSerif'),
                      textAlign: TextAlign.start),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: CreateTextField(
                    text: "Your name",
                    icon: const Icon(Icons.person_2_outlined),
                    controller: nameController,
                  ),
                ),
                if (errorname != null)
                  Center(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, bottom: 5, top: 3),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          errorname!,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text("E-mail",
                      style: TextStyle(
                          color: white, fontSize: 20, fontFamily: 'PTSerif'),
                      textAlign: TextAlign.start),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: CreateTextField(
                    text: "Your Email",
                    icon: const Icon(Icons.email),
                    controller: emailController,
                  ),
                ),
                if (errorEmail != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 5, top: 3),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        errorEmail!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text("Password",
                      style: TextStyle(
                          color: white, fontSize: 20, fontFamily: 'PTSerif'),
                      textAlign: TextAlign.start),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: CreateTextField(
                    text: "Your Password",
                    icon: const Icon(Icons.lock_outline_rounded),
                    obscureText: _obscurePassword,
                    controller: passwordController,
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
                ),
                if (errorPassword != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 3),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        errorPassword!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    margin:
                        const EdgeInsets.only(left: 15, top: 20, bottom: 20),
                    decoration: const BoxDecoration(
                        color: parrotGreen,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: width(context) * 0.9,
                    child: IconButton(
                        onPressed: () {
                          if (_validateFields()) {
                            // print("All fields are valid");
                            // print("Email: ${emailController.text}");
                            // print("Password: ${passwordController.text}");
                          }
                          if (errorEmail == null &&
                              errorname == null &&
                              errorPassword == null) {
                            context.read<AuthCubit>().initializeModel(
                                nameController.text,
                                passwordController.text,
                                emailController.text);
                            context.read<AuthCubit>().sendEmailForOTP(
                                emailController.text,
                                nameController.text,
                                passwordController.text,
                                context);
                          }
                        },
                        icon: isLoading
                            ? const CircularProgressIndicator(
                                color: ampleOrange, strokeWidth: 3)
                            : const Text("Sign Up",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'PTSerif')))),
                Container(
                    margin: EdgeInsets.only(left: width(context) * 0.48),
                    child: const Text("Or",
                        style: TextStyle(
                            color: lightGrey,
                            fontSize: 14,
                            fontFamily: 'PTSerif'),
                        textAlign: TextAlign.end)),
                Container(
                  margin: const EdgeInsets.only(left: 15, top: 20, bottom: 20),
                  decoration: const BoxDecoration(
                      color: ampleOrange,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  width: width(context) * 0.9,
                  child: IconButton(
                    onPressed: () {
                      NavigationService().push(context, signInRoute);
                    },
                    icon: const Text(
                      "Sign In",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'PTSerif'),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
