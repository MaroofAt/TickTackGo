import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart' show GoRouterState;
import 'package:pr1/business_logic/auth_cubit/auth_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_service.dart';

import '../../widgets/create_text_field.dart';

class SignInNew extends StatefulWidget {
  const SignInNew({super.key});

  @override
  State<SignInNew> createState() => _SignInNewState();
}

class _SignInNewState extends State<SignInNew> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? errorEmail;
  String? errorPassword;
  String? errorname;
  bool _obscurePassword = true;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {

              // 1. Check for the 'from' query parameter passed by the redirect.
              final String? fromRoute = GoRouterState.of(context).uri.queryParameters['from'];

              if (fromRoute != null && fromRoute.isNotEmpty) {
                // 2. If it exists, navigate the user to their original destination.
                NavigationService().pushReplacement(context, fromRoute);
              } else {
                // 3. If there's no pending route, go to the default home page.
                NavigationService().pushReplacementNamed(context, mainHomePageName);
              }
            }
          },
          builder: (context, state) {
            bool isLoading = context.read<AuthCubit>().isLoading;
            return Column(
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
                  child: const Text(
                    "E-mail",
                    style: TextStyle(
                        color: white, fontSize: 20, fontFamily: 'PTSerif'),
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: CreateTextField(
                    text: "Your Email",
                    icon: const Icon(Icons.email),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                if (errorEmail != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        errorEmail!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text(
                    "Password",
                    style: TextStyle(
                        color: white, fontSize: 20, fontFamily: 'PTSerif'),
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: CreateTextField(
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
                ),
                const SizedBox(
                  height: 3,
                ),
                if (errorPassword != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        errorPassword!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  ),
                Container(
                  margin: EdgeInsets.only(left: width(context) * 0.67),
                  child: const Text(
                    "forget password?",
                    style: TextStyle(
                      color: lightGrey,
                      fontSize: 14,
                      fontFamily: 'PTSerif',
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15, top: 20, bottom: 40),
                  decoration: const BoxDecoration(
                      color: parrotGreen,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  width: width(context) * 0.9,
                  child: IconButton(
                    onPressed: () {
                      if (errorPassword == null && errorEmail == null) {
                        context.read<AuthCubit>().login(_emailController.text,
                            _passwordController.text, context);
                      }
                    },
                    icon: isLoading
                        ? const CircularProgressIndicator(
                            color: white,
                          )
                        : const Text(
                            "Sign in",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'PTSerif',
                            ),
                          ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: width(context) * 0.354),
                      child: const Icon(Icons.key_sharp, color: lightGrey),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "continues with",
                      style: TextStyle(
                        color: lightGrey,
                        fontSize: 14,
                        fontFamily: 'PTSerif',
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(left: 80),
                  margin: const EdgeInsets.only(left: 15, top: 40, bottom: 40),
                  decoration: BoxDecoration(
                      color: ampleOrange.withValues(alpha: 0.5),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  width: width(context) * 0.9,
                  child: IconButton(
                    onPressed: () async {
                      // final userCredential = await context
                      //     .read<AuthCubit>()
                      //     .signInWithGoogle();
                      // if (userCredential != null) {
                      //   print('Signed in as ${userCredential.user?.displayName}');
                      // } else {
                      //   print('Google sign-in cancelled or failed');
                      // }
                    },
                    icon: Row(
                      children: [
                        SizedBox(
                          width: 25,
                          height: 25,
                          child: Image.asset(
                              "assets/images/auth_page_images/google.png"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Sign in with Google",
                          style: TextStyle(
                            color: white,
                            fontSize: 20,
                            fontFamily: 'PTSerif',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
