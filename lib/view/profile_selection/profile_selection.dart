import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/core/constants/color_constants.dart';
import 'package:netflix_clone/models/profile_model/profile_model.dart';
import 'package:netflix_clone/view/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:netflix_clone/view/create_new_profile/create_new_profile.dart';
import 'package:netflix_clone/view/global_current_user/global_current_user.dart';
import 'package:netflix_clone/view/profile_selection/demodata/bgimage_data.dart';
import 'package:netflix_clone/view/profile_selection/demodata/profile_demo_data.dart';

class ProfileSelectionPage extends StatefulWidget {
  const ProfileSelectionPage({super.key});

  @override
  State<ProfileSelectionPage> createState() => _ProfileSelectionPageState();
}

class _ProfileSelectionPageState extends State<ProfileSelectionPage> {
  int currentindex = 0;
  late Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      setState(() {
        currentindex = (currentindex + 1) % bgimages.length;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> addnewprofile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateNewProfile()),
    );

    if (result != null && result is ProfileModel) {
      setState(() {
        profiles.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          //Bg Animation Container
          methodAnimatedContainer(context),
          //Stacked SemiCircle
          stackedcircle(context),
          //Profile Containers
          methodProfiles(),
        ],
      ),
    );
  }

  Widget methodProfiles() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'choose your profile',
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: profiles.length + 1,
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  spacing: 8,
                  children: [
                    index == profiles.length
                        ? Column(
                            spacing: 10,
                            children: [
                              if (profiles.length < 5)
                                GestureDetector(
                                  onTap: () {
                                    addnewprofile();
                                  },
                                  child: Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.transparent,
                                      border: Border.all(color: Colors.white),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              if (profiles.length < 5)
                                Text(
                                  'Add Profile',
                                  style: GoogleFonts.openSans(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                            ],
                          )
                        : Column(
                            spacing: 10,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  final user = profiles[index];
                                  currentUser = user;
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      transitionDuration: const Duration(
                                        seconds: 1,
                                      ),
                                      pageBuilder:
                                          (
                                            context,
                                            animation,
                                            secondaryAnimation,
                                          ) => const BottomNavBarScreen(),
                                      transitionsBuilder:
                                          (
                                            context,
                                            animation,
                                            secondaryAnimation,
                                            child,
                                          ) {
                                            const begin = Offset(
                                              1.0,
                                              0.0,
                                            ); // from right to left
                                            const end = Offset.zero;
                                            final tween =
                                                Tween(
                                                  begin: begin,
                                                  end: end,
                                                ).chain(
                                                  CurveTween(
                                                    curve: Curves.ease,
                                                  ),
                                                );

                                            return SlideTransition(
                                              position: animation.drive(tween),
                                              child: child,
                                            );
                                          },
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        profiles[index].profileimg,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                profiles[index].username,
                                style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget stackedcircle(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: AlignmentGeometry.bottomCenter,
          child: Transform.scale(
            scale: 2.7,
            child: Container(
              height: MediaQuery.sizeOf(context).width * 0.35,
              width: MediaQuery.sizeOf(context).width * .85,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentGeometry.topCenter,
                  end: AlignmentGeometry.bottomCenter,
                  colors: [
                    Colors.black87,
                    Colors.black87,
                    Colors.black,
                    Colors.black,
                  ],
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(300)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget methodAnimatedContainer(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(seconds: 2),
      child: Container(
        key: ValueKey<String>(bgimages[currentindex]),
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        color: Colors.black,
        child: Image.asset(bgimages[currentindex], fit: BoxFit.cover),
      ),
    );
  }
}
