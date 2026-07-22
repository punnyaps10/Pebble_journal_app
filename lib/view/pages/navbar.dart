import 'package:flutter/material.dart';
import 'package:pebble_project/core/constants/app_color.dart';

import 'package:pebble_project/view/pages/add_journal.dart';
import 'package:pebble_project/view/pages/home.dart';
import 'package:pebble_project/view/pages/journal.dart';
import 'package:pebble_project/view/pages/profile.dart';
import 'package:pebble_project/view/pages/stats.dart';



class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int indexValue = 0;

  final List<Widget> screen = [Home(), Journal(), AddJournal(), Stats(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[indexValue],

      bottomNavigationBar: BottomNavigationBar(
        
        backgroundColor: AppColor.backgroundColor,
        selectedItemColor: AppColor.primaryColor,
        unselectedItemColor: Colors.black,

        currentIndex: indexValue,
        onTap: (value) {
          print(value);
          setState(() {
            indexValue = value;
          });
        },

        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Journals',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle,
              size: 50,
              color: AppColor.primaryColor,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
