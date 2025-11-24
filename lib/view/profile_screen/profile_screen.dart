import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:netflix_clone/core/constants/color_constants.dart';
import 'package:netflix_clone/services/user_service.dart';
import 'package:netflix_clone/view/appsettings_screen/app_settings_screen.dart';
import 'package:netflix_clone/view/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:netflix_clone/view/downloads/downloads_data/downloads_list.dart';
import 'package:netflix_clone/view/global_current_user/global_current_user.dart';
import 'package:netflix_clone/view/help_screen/help_screen.dart';
import 'package:netflix_clone/view/movie_details_page/movie_details_page.dart';
import 'package:netflix_clone/view/mylistmovies/my_list_data/my_list_movies.dart';
import 'package:netflix_clone/view/profile_selection/profile_selection.dart';
import 'package:netflix_clone/view/search_screen/search_screen.dart';
import 'package:netflix_clone/view/sign_in_page/signin_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserService userService = UserService();

  void signout() {
    userService.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF000000),
            Color.fromARGB(255, 13, 3, 24),
            Color.fromARGB(255, 44, 1, 1),
            Color(0xFF000000),
            Color(0xFF000000),
          ],
        ),
      ),
      child: PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              'My Netflix',
              style: GoogleFonts.openSans(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: ColorConstants.white,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchScreen()),
                  );
                },
                icon: Icon(Icons.search, color: Colors.white, size: 30),
              ),
              IconButton(
                onPressed: () {
                  showBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.horizontal(
                        start: Radius.circular(10),
                      ),
                    ),
                    builder: (context) {
                      return Container(
                        height: MediaQuery.sizeOf(context).height * .28,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 50, 50, 50),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            bottom: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProfileSelectionPage(),
                                    ),
                                  );
                                },
                                child: Row(
                                  spacing: 10,
                                  children: [
                                    Icon(
                                      Icons.edit_outlined,
                                      color: Colors.white70,
                                      size: 30,
                                    ),
                                    Text(
                                      "Manage Profiles",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AppSettingsScreen(),
                                    ),
                                  );
                                },
                                child: Row(
                                  spacing: 10,
                                  children: [
                                    Icon(
                                      Icons.settings_outlined,
                                      color: Colors.white70,
                                      size: 30,
                                    ),
                                    Text(
                                      "App Settings",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Row(
                                  spacing: 10,
                                  children: [
                                    Icon(
                                      Icons.person_outline_outlined,
                                      color: Colors.white70,
                                      size: 30,
                                    ),
                                    Text(
                                      "Account",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HelpScreen(),
                                    ),
                                  );
                                },
                                child: Row(
                                  spacing: 10,
                                  children: [
                                    Icon(
                                      Icons.help_outline,
                                      color: Colors.white70,
                                      size: 30,
                                    ),
                                    Text(
                                      "Help",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  signout();
                                },
                                child: Row(
                                  spacing: 10,
                                  children: [
                                    Icon(
                                      Icons.exit_to_app_outlined,
                                      color: Colors.white70,
                                      size: 30,
                                    ),
                                    Text(
                                      "Sign out",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: Icon(Icons.menu, size: 30, color: ColorConstants.white),
              ),
              SizedBox(width: 10),
            ],
          ),

          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  //Profile Img
                  methodProfileimg(context),
                  const SizedBox(height: 10),
                  //UserName
                  methodUsername(),
                  const SizedBox(height: 40),
                  //Notification
                  methodNotifications(context),
                  const SizedBox(height: 40),
                  //Downloads
                  downloads.isEmpty
                      ? methodDownloadEmpty(context)
                      : methodDownloads(context),
                  const SizedBox(height: 30),
                  //My List
                  myList.isEmpty
                      ? methodMyLitsEmpty(context)
                      : methodMyList(context),
                  const SizedBox(height: 30),
                  //Lottie
                  methodLottie(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget methodLottie(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white12),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white10,
      ),
      child: Column(
        children: [
          Lottie.asset(
            'assets/json/Netflix Logo Swoop.json',
            width: 100,
            height: 100,
            frameRate: FrameRate(60),
            fit: BoxFit.contain,
          ),
          Text(
            "Step into your world of cinema",
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => BottomNavBarScreen()),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
              ),
              child: Text(
                "Explore",
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget methodMyList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          'my List',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: MediaQuery.sizeOf(context).height * .2,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: myList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          final movie = myList[index];
                          return MovieDetailPage(
                            movie: movie,
                            category: 'Malayalam',
                          );
                        },
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(10),
                    child: Image.asset(
                      myList[index].thumbail,
                      width: MediaQuery.sizeOf(context).width * 0.3,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget methodMyLitsEmpty(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Colors.black26,
        border: Border.all(color: Colors.white24),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        spacing: 10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 10,
                children: [
                  Icon(
                    Icons.library_add_check_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  Text(
                    "My List",
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavBarScreen(),
                    ),
                  );
                },
                child: Row(
                  spacing: 5,
                  children: [
                    Text(
                      "Add",
                      style: GoogleFonts.montserrat(
                        color: Colors.white60,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            "Keep track of the shows and movies you want to watch",
            style: GoogleFonts.montserrat(
              color: Colors.white54,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget methodDownloads(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'my Downloads',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
        Container(
          height: MediaQuery.sizeOf(context).height * .2,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: downloads.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: InkWell(
                  onTap: () {
                    final category = 'Malayalam';
                    final movie = downloads[index];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MovieDetailPage(
                            movie: movie,
                            category: category,
                          );
                        },
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(10),
                    child: Image.asset(
                      downloads[index].thumbail,
                      width: MediaQuery.sizeOf(context).width * 0.3,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget methodDownloadEmpty(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Colors.black26,
        border: Border.all(color: Colors.white24),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        spacing: 10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 10,
                children: [
                  Icon(
                    Icons.file_download_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  Text(
                    "Downloads",
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavBarScreen(),
                    ),
                  );
                },
                child: Row(
                  spacing: 5,
                  children: [
                    Text(
                      "Add",
                      style: GoogleFonts.montserrat(
                        color: Colors.white60,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            "Movies and shows that you download appear here.",
            style: GoogleFonts.montserrat(
              color: Colors.white54,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget methodNotifications(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Colors.black26,
        border: Border.all(color: Colors.white24),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 10,
            children: [
              Icon(Icons.notifications, color: Colors.white, size: 30),
              Text(
                "Notifications",
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            spacing: 5,
            children: [
              Text(
                "See All",
                style: GoogleFonts.montserrat(
                  color: Colors.white60,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget methodUsername() {
    return Text(
      currentUser!.username,
      style: GoogleFonts.poppins(
        color: ColorConstants.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget methodProfileimg(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(10),
      child: Image.asset(
        currentUser!.profileimg,
        width: MediaQuery.sizeOf(context).width * .25,
      ),
    );
  }
}
