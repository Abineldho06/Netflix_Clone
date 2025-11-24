import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/core/constants/color_constants.dart';
import 'package:netflix_clone/services/user_service.dart';
import 'package:netflix_clone/view/global_widgets/custom_button/custom_button.dart';
import 'package:netflix_clone/view/on_boarding_screen/dummy_data/on_boarding_data.dart';
import 'package:netflix_clone/view/profile_selection/profile_selection.dart';
import 'package:netflix_clone/view/sign_in_page/signin_page.dart';
import 'package:netflix_clone/view/subscription_page/subscription_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  UserService userService = UserService();
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      body: methodmaincontainer(),
    );
  }

  Widget methodmaincontainer() {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Stack(
        children: [
          //Bg images
          methodPageview(),
          //Bottom Text and Button
          Align(
            alignment: AlignmentGeometry.bottomCenter,
            child: stackedsection(),
          ),
        ],
      ),
    );
  }

  Widget stackedsection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        methodsmoothIndicator(),
        SizedBox(height: 20),
        methodCustomButton(),
        SizedBox(height: 20),
      ],
    );
  }

  Widget methodPageview() {
    return PageView.builder(
      itemCount: images.length,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(images[index]),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.transparent,
                Colors.black26,
                Colors.black38,
                Colors.black87,
                Colors.black.withOpacity(
                  0.7,
                ), // Reduced opacity for better contrast
              ],
            ),
          ),
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  text[index],
                  style: GoogleFonts.montserrat(
                    color: ColorConstants.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Text(
                  subtext[index],
                  style: GoogleFonts.montserrat(
                    color: ColorConstants.whitefade,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      onPageChanged: (index) {
        currentindex = index;
        setState(() {});
      },
    );
  }

  Widget methodCustomButton() {
    return Custombutton(
      text: "GET STARTED",
      onTap: () async {
        if (await userService.islogin() == true) {
          if (await userService.isSubscription() == true) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfileSelectionPage()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SubscriptionPage()),
            );
          }
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignInScreen()),
          );
        }
      },
    );
  }

  Widget methodsmoothIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: currentindex,
      count: images.length,
      effect: ScaleEffect(
        dotHeight: 8,
        dotWidth: 8,
        activeDotColor: ColorConstants.primary,
      ),
    );
  }
}
