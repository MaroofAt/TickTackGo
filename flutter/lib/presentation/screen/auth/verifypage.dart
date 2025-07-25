import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:pr1/business_logic/auth_cubit/auth_cubit.dart';
import 'package:pr1/business_logic/auth_cubit/auth_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';

import '../../../core/constance/strings.dart';
import '../../../core/functions/navigation_functions.dart';

class Verifypage extends StatefulWidget {
  const Verifypage({super.key});

  @override
  VerifypageState createState() => VerifypageState();
}

class VerifypageState extends State<Verifypage> {
  final pincontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: BlocBuilder<AuthCubit, AuthState>(
  builder: (context, state) {
    bool isloading=BlocProvider.of<AuthCubit>(context).isloading;
    return Stack(
            children: [
              Positioned(
                top:20,
                left:40,
                child:IconButton(onPressed: (){
                  pushReplacementNamed(context,signupRoute);
                }, icon:const Icon(Icons.arrow_back_sharp),)
              ),
              Positioned(
                top: height(context)*0.49,left: width(context)*0.25,
                child:  Center(
                child: Text(
                    "We have just send 6 degit\n code via your email",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: white,fontSize: 17)
                ),),),
              Positioned(
                top: height(context)*0.099,left: width(context)*0.18,
                child: const Text(
                  "Verify account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 34, color: white, fontWeight: FontWeight.bold,fontFamily: "PTSerif"),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
                    child: Image.asset(
                      "assets/images/verify_page_images/verfiy.png",
                      height: height(context) * 0.48,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: width(context) * 0.8,
                    height: height(context) * 0.2,
                    decoration: const BoxDecoration(
                        color: ampleOrange,
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Pinput(
                          showCursor: true,
                          length: 6,
                          controller: pincontroller,
                          defaultPinTheme: PinTheme(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: white, width: 2.0))),
                            width: 40,
                            height: 40,
                            textStyle: TextStyle(
                              fontSize: 24,
                              color: primaryColor,
                            ),
                          ),
                          onCompleted: (value) {
                            ///  done all pin input
                            print("pin is $value");
                          },
                        ),
                        IconButton(
                            onPressed: () {
                              print(pincontroller.text);
                              context.read<AuthCubit>().verify_SignUp(pincontroller.text,context);
                            },
                            icon: Container(
                              margin: EdgeInsets.all(10),
                              width: width(context) * 0.3,
                              height: height(context) * 0.04,
                              child: Center(
                                child: isloading?CircularProgressIndicator(color: ampleOrange,strokeWidth:3):Text("Verify"),
                              ),
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                            ))
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 10,),
                      GestureDetector(
                        onTap: () {},
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                                fontSize: 14,
                                color: white,
                                decorationColor: parrotGreen,
                                decorationThickness: 3,
                               ),
                            text: 'Did not receive code?',
                          ),
                        ),
                      ),
const SizedBox(height: 10,),
                      GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Re_send',
                            style: TextStyle(color: white,fontSize: 14),

                          )),
                      // margin: EdgeInsets.only(top:20),
                    ],
                  )
                ],
              ),
            ],
          );
  },
),
        ),
      ),
      backgroundColor: primaryColor,
    );
  }
}
