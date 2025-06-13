import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';

class ShowProjects extends StatefulWidget {
  const ShowProjects({super.key});

  @override
  State<ShowProjects> createState() => _ShowProjectsState();
}

class _ShowProjectsState extends State<ShowProjects>  {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Row(
          children: [
            GestureDetector(
              onTap: (){},child:
              Icon(Icons.arrow_back_sharp,color: white,size: 24,),
            ),SizedBox(width: width(context)*0.2,),
            Center(child: Text("name's workspace",style: TextStyle(color: white,fontFamily: 'PTSerif'),),),

          ],
        ),
        backgroundColor: Ample_orang.withOpacity(0.5),
      ),
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
           Container(
             margin: EdgeInsets.all(10),
             padding: EdgeInsets.all(10),
             width: width(context)*0.4,
             decoration: BoxDecoration(

             ),
           )
          ],
        ),
      ),
    );
  }
}
