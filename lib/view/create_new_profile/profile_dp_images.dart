import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/core/constants/color_constants.dart';
import 'package:netflix_clone/view/create_new_profile/demo_data.dart/profile_dp_data.dart';

class ProfileDpImages extends StatefulWidget {
  const ProfileDpImages({super.key});

  @override
  State<ProfileDpImages> createState() => _ProfileDpImagesState();
}

class _ProfileDpImagesState extends State<ProfileDpImages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Select profile Image',
          style: GoogleFonts.openSans(
            color: ColorConstants.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          itemCount: dpimages.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 40,
          ),
          itemBuilder: (context, index) {
            final image = dpimages[index];
            return GestureDetector(
              onTap: () {
                Navigator.pop(context, image);
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(dpimages[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
