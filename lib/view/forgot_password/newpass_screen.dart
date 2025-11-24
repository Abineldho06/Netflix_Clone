import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants/color_constants.dart';
import 'package:netflix_clone/core/constants/image_constants.dart';
import 'package:netflix_clone/view/forgot_password/forgot_password.dart';
import 'package:netflix_clone/view/global_widgets/custom_button/custom_button.dart';
import 'package:netflix_clone/view/global_widgets/custom_text_field/custom_text_field.dart';
import 'package:netflix_clone/view/sign_in_page/signin_page.dart';

class NewpassScreen extends StatefulWidget {
  const NewpassScreen({super.key});

  @override
  State<NewpassScreen> createState() => _NewpassScreenState();
}

class _NewpassScreenState extends State<NewpassScreen> {
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController repasswordcontroller = TextEditingController();

  FocusNode passwordfocusNode = FocusNode();
  FocusNode repasswordfocusNode = FocusNode();

  final passwordFormKey = GlobalKey<FormState>();
  final repasswordFormKey = GlobalKey<FormState>();

  bool passobscure = true;
  bool repassobscure = true;

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
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: .6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //logo
                methodimage(),
                SizedBox(height: 20),
                //New Password
                methodText(),
                SizedBox(height: 20),
                //Password Field
                methodPasswordField(),
                //Re-Password
                methodRepassFiled(),
                SizedBox(height: 30),
                //Save Button
                methodbuttonSave(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget methodText() {
    return Text(
      "Set new Password",
      style: TextStyle(
        color: ColorConstants.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }

  Widget methodPasswordField() {
    return Customtextfield(
      obscuretext: passobscure,
      fieldfcusNode: passwordfocusNode,
      controller: passwordcontroller,
      hinttext: 'Enter new password',
      suffixIcon: passobscure == true
          ? Icons.visibility_outlined
          : Icons.visibility_off_rounded,
      suffixonPressed: () {
        setState(() {
          passobscure = !passobscure;
        });
      },
      onTapOutside: (_) {
        passwordfocusNode.unfocus();
      },
      formkey: passwordFormKey,
      validator: (value) => passwordValidation(value),
    );
  }

  Widget methodRepassFiled() {
    return Customtextfield(
      obscuretext: repassobscure,
      fieldfcusNode: repasswordfocusNode,
      controller: repasswordcontroller,
      hinttext: 'Re-enter new password',
      suffixIcon: repassobscure == true
          ? Icons.visibility_outlined
          : Icons.visibility_off_sharp,
      suffixonPressed: () {
        setState(() {
          repassobscure = !repassobscure;
        });
      },
      onTapOutside: (_) {
        repasswordfocusNode.unfocus();
      },
      formkey: repasswordFormKey,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please re-enter the password';
        } else if (value.trim() != passwordcontroller.text.trim()) {
          return 'the re-enter password was wrong';
        } else {
          return null;
        }
      },
    );
  }

  Widget methodbuttonSave(BuildContext context) {
    return Custombutton(
      text: 'Save',
      onTap: () {
        if (passwordFormKey.currentState!.validate() &&
            repasswordFormKey.currentState!.validate()) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignInScreen()),
          );
        }
      },
    );
  }

  Widget methodimage() =>
      Image.asset(ImageConstants.logoimage, width: 140, height: 50);
}

String? passwordValidation(String? value) {
  RegExp capital = RegExp(r'^(?=.*[A-Z]).+$');
  RegExp small = RegExp(r'^(?=.*[a-z]).+$');
  RegExp numbers = RegExp(r'^(?=.*[0-9]).+$');
  RegExp spclchar = RegExp(r'^(?=.*[@!#%*.,]).+$');

  if (value == null || value.isEmpty) {
    return 'Please enter password';
  } else if (value.length < 8) {
    return 'password must minimum length of 8';
  } else if (!capital.hasMatch(value)) {
    return 'the password must contain an uppercase';
  } else if (!small.hasMatch(value)) {
    return 'the password must contain lowercase letter';
  } else if (!numbers.hasMatch(value)) {
    return 'the password must contain any number';
  } else if (!spclchar.hasMatch(value)) {
    return 'the password must contain a special character';
  } else {
    return null;
  }
}
