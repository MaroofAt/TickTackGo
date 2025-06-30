 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';

import '../../../core/constance/constance.dart';
import '../../widgets/creatTextFiled.dart';

class CreateProject extends StatefulWidget {
   const CreateProject({super.key});

   @override
   State<CreateProject> createState() => _CreateProjectState();
 }

 class _CreateProjectState extends State<CreateProject>  {
 final TextEditingController _name_project= TextEditingController();
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
     return  Scaffold(
       body: Center(child: IconButton(onPressed: (){
         _CustomDiaoge(context);
       }, icon: Icon(Icons.photo_rounded)),),
     );

   }
   void _CustomDiaoge (BuildContext Context){
     showDialog(
         context: Context, builder: (BuildContext dialogcontext){
       return Dialog(
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
         backgroundColor: primaryColor,
         child: Column(
           children: [
             // SizedBox(h:20),
             Container(child: Image.asset( "assets/images/verify_page_images/project.png"),),
             const Center(child: Text("create your owner project",style: TextStyle(color: white,fontSize: 18,fontFamily: 'PTSerif'),),),
             const Center(child: Text("on workspace",style: TextStyle(color: white,fontSize: 18,fontFamily: 'PTSerif'),),),

             const SizedBox(
               height: 20,
             ),
             Container(child:  CreateTextField(
               text: "title",
               controller: _name_project,
             ),margin: EdgeInsets.all(15)),
             Container(child:  CreateTextField(
               text: "description",
               controller: _name_project,
             ),margin: EdgeInsets.all(15)),
             SizedBox(height: 3,),
             Container(
                 margin: EdgeInsets.only(left: 15,top:20,bottom: 40),
                 decoration:BoxDecoration(color:parrotGreen,borderRadius: BorderRadius.all(Radius.circular(10))),width: width(context)*0.4,
                 child: IconButton(onPressed: (){
                  }, icon: Center(child: Text("Create",style: TextStyle(color: Colors.black,fontSize: 20,fontFamily: 'PTSerif'))))),

           ],
         ),
       );
     });
   }
 }
