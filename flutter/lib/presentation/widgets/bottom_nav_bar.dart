import 'package:flutter/material.dart';
import 'package:pr1/core/constance/colors.dart';

class MyBottomNavBar {
  static BottomNavigationBar buildBottomNavigationBar(
      BuildContext context, double width ,{required int selectedIndex,required void Function(int)? onItemTapped}) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor: Theme.of(context).secondaryHeaderColor,
      unselectedItemColor: white,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      elevation: 10,
      type: BottomNavigationBarType.fixed,
      items: [
        _buildBottomNavigationBarItem(context,Icons.home_outlined, width,'home'),
        _buildBottomNavigationBarItem(context,Icons.favorite_outline, width,'favorite'),
        _buildBottomNavigationBarItem(context,Icons.person, width,'profile'),
      ],
      currentIndex: selectedIndex,
      onTap: onItemTapped,
    );
  }

  static BottomNavigationBarItem _buildBottomNavigationBarItem(
      BuildContext context, IconData icon, double width,String label) {
    return BottomNavigationBarItem(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      icon: Icon(
        icon,
        size: width * 0.07,
      ),
      label: label,
    );
  }
}
