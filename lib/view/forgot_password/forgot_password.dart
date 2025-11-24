import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants/color_constants.dart';
import 'package:netflix_clone/core/constants/image_constants.dart';
import 'package:netflix_clone/view/forgot_password/otp_screen.dart';
import 'package:netflix_clone/view/global_widgets/custom_button/custom_button.dart';
import 'package:netflix_clone/view/global_widgets/custom_text_field/custom_text_field.dart';
import 'package:netflix_clone/view/sign_in_page/signin_page.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailcontroller = TextEditingController();
  FocusNode emailfocusNode = FocusNode();
  final emailformkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignInScreen()),
            );
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          Text(
            'Help?',
            style: TextStyle(
              color: ColorConstants.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 20),
        ],

        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstants.otpscreen),
              fit: BoxFit.cover,
            ),
          ),
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: methodFloatingContainer(context),
        ),
      ),
    );
  }

  Widget methodFloatingContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: .6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Logo
          Image.asset(ImageConstants.logoimage, width: 140, height: 50),
          SizedBox(height: 30),
          //Text
          methodText(),
          SizedBox(height: 20),
          //Email Text Filed
          methodEmailFeild(),
          SizedBox(height: 20),
          //Button
          emthodButton(context),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget emthodButton(BuildContext context) {
    return Custombutton(
      text: 'GET OTP',
      onTap: () {
        if (emailformkey.currentState!.validate()) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => OTPScreen()),
          );
        }
      },
    );
  }

  Widget methodEmailFeild() {
    return Customtextfield(
      fieldfcusNode: emailfocusNode,
      controller: emailcontroller,
      hinttext: 'Enter your email',
      onTapOutside: (_) {
        emailfocusNode.unfocus();
      },
      formkey: emailformkey,
      validator: (value) => emailvalidation(value),
    );
  }

  Widget methodText() {
    return Text(
      "Forgot Password",
      style: TextStyle(
        color: ColorConstants.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }
}

String? emailvalidation(String? value) {
  RegExp validate = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  } else if (!validate.hasMatch(value)) {
    return 'Email in invalid';
  } else {
    return null;
  }
}
