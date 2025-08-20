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
leading:GestureDetector(
  onTap: (){},child:
const Icon(Icons.arrow_back_sharp,color: white,size: 24,),
),
        title: Row(
          children: [
            SizedBox(width: width(context)*0.1,),
            const Center(child: Text("workspace name",style: TextStyle(color: white,fontFamily: 'PTSerif'),),),
            SizedBox(width: width(context)*0.13,),
            IconButton(onPressed: (){}, icon: const Icon(Icons.menu,color: white,))
          ],
        ),
        backgroundColor: primaryColor,
      ),
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
          ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              itemBuilder: (context,index){
                return
                  Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 65, left: 10, right: 10),
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                          BoxShadow(
                          color: Colors.orangeAccent,
                          blurRadius: 2,
                          offset: Offset(0, 1),)
                          ],
                        ),
                        child: const Text(
                          "the project collected with the workespace one",
                          style: TextStyle(color: black, fontFamily: 'PTSerif'),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.only(left:10,top:10),
                          decoration: BoxDecoration(
                              color: ampleOrange.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10)),
                          width:width(context) * 0.5,
                          height: 50,
                          child: const Text(
                            "name project",
                            style: TextStyle(
                                color: white,
                                fontFamily: 'PTSerif',
                                fontSize: 24),
                          ),
                        ),
                      ),
                      Positioned(
                          right: width(context)*0.04,
                      top: height(context)*0.03,
                          child: GestureDetector(
                        child: Icon(Icons.delete_outlined,color: Colors.red.withOpacity(0.5),size: 30,),
                      ),)
                    ],
                  ),
                );
          }
          )

          ],
        ),
      ),
    );
  }
}
