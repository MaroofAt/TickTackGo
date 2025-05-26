import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';

class Description extends StatelessWidget {
  Description();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: height(context) - 400,
        ),
        Center(
            child: Text(
          "Tick Tack Go",
          style: TextStyle(fontSize: 50,color: primaryColor),
        )),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            'this is help u to contool ur tasks\n so we need u wiith us.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        SizedBox(
          height: 100,
        ),
        Center(child: GestureDetector(
            onTap: () {},
            child: Container(
                width: width(context) * 0.7,
                height: height(context) * 0.07,
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(50)
                ),
                padding: EdgeInsets.all(10),
                child:Center(child:  Text(
                  'Lets start for free',textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),))),)
      ],
    );
  }
}
