import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/core/constants/color_constants.dart';
import 'package:netflix_clone/core/constants/image_constants.dart';
import 'package:netflix_clone/view/forgot_password/forgot_password.dart';
import 'package:netflix_clone/view/forgot_password/newpass_screen.dart';
import 'package:netflix_clone/view/global_widgets/custom_button/custom_button.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController text1 = TextEditingController();
  TextEditingController text2 = TextEditingController();
  TextEditingController text3 = TextEditingController();
  TextEditingController text4 = TextEditingController();

  bool isverify = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ForgotPassword()),
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
      ),
      backgroundColor: ColorConstants.black,
      extendBodyBehindAppBar: true,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageConstants.otpscreen),
                fit: BoxFit.cover,
              ),
            ),
            child: methodFloatingContainer(context),
          ),
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
        children: [
          //Text
          methodMainText(),
          SizedBox(height: 20),
          //Subtext
          methodSubText(),
          SizedBox(height: 30),
          //OTP Field
          methodOTPfield(context),
          SizedBox(height: 10),
          isverify == false
              ? Text(
                  'Invalid OTP',
                  style: TextStyle(fontSize: 16, color: ColorConstants.primary),
                )
              : Text(''),
          SizedBox(height: 15),
          //Resend Section
          methodresend(),
          //Button
          SizedBox(height: 30),
          methodButton(context),
        ],
      ),
    );
  }

  Widget methodMainText() {
    return Text(
      'Verification Code',
      style: GoogleFonts.montserrat(
        textStyle: TextStyle(
          color: ColorConstants.white,
          fontSize: 30,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget methodSubText() {
    return Text(
      'enter the 4 digit verfication code here',
      style: GoogleFonts.montserrat(
        textStyle: TextStyle(color: ColorConstants.white, fontSize: 16),
      ),
    );
  }

  Widget methodOTPfield(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        otpgenerate(context, text1),
        otpgenerate(context, text2),
        otpgenerate(context, text3),
        otpgenerate(context, text4),
      ],
    );
  }

  Widget methodresend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Haven't recieved the OTP yet?",
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(color: ColorConstants.white, fontSize: 12),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'Resend',
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(color: ColorConstants.primary, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget methodButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Custombutton(
        text: 'Verify',
        onTap: () {
          final otp = text1.text + text2.text + text3.text + text4.text;
          if (otp == '2164') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => NewpassScreen()),
            );
          } else {
            setState(() {
              isverify = false;
            });
          }
        },
      ),
    );
  }
}

Widget otpgenerate(BuildContext context, TextEditingController controller) {
  return Container(
    width: 50,
    height: 80,
    decoration: BoxDecoration(
      border: Border.all(color: ColorConstants.white, width: 2),
      borderRadius: BorderRadius.circular(6),
    ),
    child: TextFormField(
      controller: controller,
      maxLength: 1,
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 42, color: ColorConstants.white),
      textAlign: TextAlign.center,
      decoration: InputDecoration(counterText: ''),
      onChanged: (value) {
        if (value.length == 1) {
          FocusScope.of(context).nextFocus();
        }
      },
    ),
  );
}
