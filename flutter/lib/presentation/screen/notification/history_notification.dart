import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';

class NotificationHistoryPage extends StatelessWidget {

  final List<NotificationItem> notifications = [
    NotificationItem(
      title: "🔔 New Message",
      body: "You have a new alert.",
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    NotificationItem(
      title: "🔔 Welcome",
      body: "Thanks for joining!",
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    ), NotificationItem(
      title: "🔔 Welcome",
      body: "Thanks for joining!",
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    ), NotificationItem(
      title: "🔔 Welcome",
      body: "Thanks for joining!",
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    ), NotificationItem(
      title: "🔔 Welcome",
      body: "Thanks for joining!",
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    ), NotificationItem(
      title: "🔔 Welcome",
      body: "Thanks for joining!",
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    ), NotificationItem(
      title: "🔔 Welcome",
      body: "Thanks for joining!",
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    ), NotificationItem(
      title: "🔔 Welcome",
      body: "Thanks for joining!",
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    ), NotificationItem(
      title: "🔔 Welcome",
      body: "Thanks for joining!",
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    ), NotificationItem(
      title: "🔔 Welcome",
      body: "Thanks for joining!",
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    ),
  ];

  NotificationHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Notification History'),
      //   backgroundColor: Colors.deepPurple,
      // ),
      body: Stack(
        children: [
          Positioned(top: 20,child: Row(
            children: [
              Container(margin:const EdgeInsets.only(top: 10, left:20),child: const Text('Notification History',style: TextStyle(color: white,fontSize: 30,fontFamily: 'PTSerif'))),
          // SizedBox(width: 60,),
          //   Icon(Icons.arrow_forward,color: white,)
            ],
          ),),
         Container(decoration: const BoxDecoration(
    color: ampleOrange,
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(50),
    topRight: Radius.circular(50),
    ),
    ),margin: EdgeInsets.only(top: height(context)*0.1),child:  ListView.builder(
           itemCount: notifications.length,
           itemBuilder: (context, index) {
             final item = notifications[index];
             return Card(
               color: primaryColor,
               margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
               elevation: 3,
               child: ListTile(
                 title: Text(
                   item.title,
                   style: const TextStyle(fontWeight: FontWeight.bold,color: white),
                 ),
                 subtitle: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     const SizedBox(height: 4),
                     Text(item.body,style: const TextStyle(color: white),),
                     const SizedBox(height: 8),
                     Text(
                       DateFormat('dd MMM yyyy, h:mm a').format(item.timestamp),
                       style: const TextStyle(color: Colors.grey, fontSize: 12),
                     ),
                   ],
                 ),
               ),
             );
           },
         ),)
        ],
      ),
    );
  }
}

class NotificationItem {
  final String title;
  final String body;
  final DateTime timestamp;

  NotificationItem({
    required this.title,
    required this.body,
    required this.timestamp,
  });
}
