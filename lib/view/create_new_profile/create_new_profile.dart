import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/core/constants/color_constants.dart';
import 'package:netflix_clone/core/constants/image_constants.dart';
import 'package:netflix_clone/models/profile_model/profile_model.dart';
import 'package:netflix_clone/view/create_new_profile/demo_data.dart/profile_dp_data.dart';
import 'package:netflix_clone/view/create_new_profile/profile_dp_images.dart';
import 'package:netflix_clone/view/global_widgets/custom_text_field/custom_text_field.dart';

class CreateNewProfile extends StatefulWidget {
  const CreateNewProfile({super.key});

  @override
  State<CreateNewProfile> createState() => _CreateNewProfileState();
}

class _CreateNewProfileState extends State<CreateNewProfile> {
  TextEditingController usernamecntrl = TextEditingController();

  FocusNode focusNode = FocusNode();
  final formkey = GlobalKey<FormState>();

  String selecetedimg = dpimages[0];
  bool buttonvalue = false;

  Future<void> selectdpimg() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileDpImages()),
    );
    if (result != null && result is String) {
      setState(() {
        selecetedimg = result;
      });
    }
  }

  void saveprofile() {
    if (usernamecntrl.text.isNotEmpty) {
      final newprofile = ProfileModel(
        profileimg: selecetedimg,
        username: usernamecntrl.text.trim(),
      );
      Navigator.pop(context, newprofile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Add Profile',
          style: GoogleFonts.openSans(
            color: ColorConstants.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (formkey.currentState!.validate()) {
                saveprofile();
              }
            },
            child: Text(
              'Save',
              style: GoogleFonts.openSans(
                color: ColorConstants.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstants.otpscreen),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          decoration: BoxDecoration(color: Colors.black.withValues(alpha: .6)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Profile Selection
              methodProfileContainer(),
              SizedBox(height: 26),
              //User Name Filed
              methodTextField(),
              SizedBox(height: 10),
              //Childrens Profile
              methodSwitchContainer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget methodSwitchContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Childrens Profile',
                  style: GoogleFonts.montserrat(
                    color: ColorConstants.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Made for childrens 12 and under, but parents have all\nthe control.',
                  style: GoogleFonts.montserrat(
                    color: ColorConstants.white,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            Switch(
              activeThumbColor: ColorConstants.primary,
              value: buttonvalue,
              onChanged: (value) {
                setState(() {
                  buttonvalue = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget methodTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Customtextfield(
        fieldfcusNode: focusNode,
        controller: usernamecntrl,
        formkey: formkey,
        hinttext: 'User Name',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter User Name';
          } else if (value.length < 3) {
            return 'User Name must contain more than 3 characters';
          } else {
            return null;
          }
        },
        onTapOutside: (_) {
          focusNode.unfocus();
        },
      ),
    );
  }

  Widget methodProfileContainer() {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage('$selecetedimg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          right: 5,
          bottom: 5,
          child: GestureDetector(
            onTap: () {
              selectdpimg();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Icon(
                  Icons.mode_edit_outline_outlined,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
