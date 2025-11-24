import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/core/constants/color_constants.dart';
import 'package:netflix_clone/view/home_page/home_page.dart';
import 'package:netflix_clone/view/newandhot_screen/newandhot_screen.dart';
import 'package:netflix_clone/view/profile_screen/profile_screen.dart';
import 'package:netflix_clone/view/search_screen/search_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  List<Widget> screens = [
    HomePage(),
    SearchScreen(),
    NewandhotScreen(),
    ProfileScreen(),
  ];

  int selectedscreen = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedscreen],
      backgroundColor: ColorConstants.black,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedscreen,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        selectedIconTheme: IconThemeData(size: 25),
        unselectedIconTheme: IconThemeData(size: 25),
        selectedLabelStyle: GoogleFonts.poppins(),
        unselectedLabelStyle: GoogleFonts.poppins(),
        selectedFontSize: 12,
        unselectedFontSize: 10,
        onTap: (value) {
          selectedscreen = value;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: selectedscreen == 0
                ? Icon(Icons.home)
                : Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: selectedscreen == 2
                ? Icon(Icons.video_library)
                : Icon(Icons.video_library_outlined),
            label: 'New & Hot',
          ),
          BottomNavigationBarItem(
            icon: selectedscreen == 3
                ? Icon(Icons.person)
                : Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
