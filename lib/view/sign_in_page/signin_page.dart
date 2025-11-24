import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants/color_constants.dart';
import 'package:netflix_clone/core/constants/image_constants.dart';
import 'package:netflix_clone/services/user_service.dart';
import 'package:netflix_clone/view/global_widgets/custom_button/custom_button.dart';
import 'package:netflix_clone/view/global_widgets/custom_text_field/custom_text_field.dart';
import 'package:netflix_clone/view/profile_selection/profile_selection.dart';
import 'package:netflix_clone/view/forgot_password/forgot_password.dart';
import 'package:netflix_clone/view/signup_screen/signup_screen.dart';
import 'package:netflix_clone/view/subscription_page/subscription_page.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  UserService userService = UserService();
  final emailformkey = GlobalKey<FormState>();
  final passformkey = GlobalKey<FormState>();

  FocusNode emailfocusNode = FocusNode();
  FocusNode passwordfocusNode = FocusNode();

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  bool passstatus = true;

  bool ischecked = false;

  void checkSubscription() async {
    if (await userService.isSubscription() == true) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ProfileSelectionPage();
          },
        ),
        (route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return SubscriptionPage();
          },
        ),
        (route) => false,
      );
    }
  }

  Future<void> login() async {
    if (emailformkey.currentState!.validate() &&
        passformkey.currentState!.validate()) {
      final email = emailcontroller.text.trim();
      final password = emailcontroller.text.trim();

      await userService.saveuserdetails(email: email, password: password);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login Successfully")));

      checkSubscription();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstants.signinpage),
              fit: BoxFit.cover,
            ),
          ),
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: methodFloatingContainer(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget methodFloatingContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: .8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //Logo
          methodLogo(),
          SizedBox(height: 30),
          //SignInText
          methodText(),
          SizedBox(height: 20),
          //Email Filed
          methodEmailField(),
          //Password Field
          methodPassField(),
          //Button
          methodButton(context),
          //Forgot Password Row
          methodForgotpass(context),
          SizedBox(height: 20),
          //Bottom Row
          methodNewtoNetflix(context),
        ],
      ),
    );
  }

  Widget methodNewtoNetflix(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        Text('New to Netflix?', style: TextStyle(color: Colors.white70)),
        InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()),
            );
          },
          child: Text(
            'Sign up now',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorConstants.white,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }

  Widget methodForgotpass(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: ischecked,
              onChanged: (value) {
                setState(() => ischecked = value!);
              },
              activeColor: ColorConstants.primary,
            ),
            const Text(
              "Remember me",
              style: TextStyle(color: ColorConstants.white),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ForgotPassword()),
            );
          },
          child: const Text(
            'Forgot Password?',
            style: TextStyle(color: ColorConstants.white),
          ),
        ),
      ],
    );
  }

  Widget methodButton(BuildContext context) {
    return Custombutton(
      text: 'Sign in',
      onTap: () {
        login();
      },
    );
  }

  Widget methodPassField() {
    return Customtextfield(
      hinttext: 'Password',
      formkey: passformkey,
      fieldfcusNode: passwordfocusNode,
      controller: passwordcontroller,
      obscuretext: passstatus,
      validator: (value) => passwordValidation(value),
      onTapOutside: (event) {
        passwordfocusNode.unfocus();
      },
      suffixIcon: passstatus ? Icons.visibility : Icons.visibility_off_rounded,
      suffixonPressed: () {
        passstatus = !passstatus;
        setState(() {});
      },
    );
  }

  Widget methodEmailField() {
    return Customtextfield(
      hinttext: 'Email or phone number',
      formkey: emailformkey,
      fieldfcusNode: emailfocusNode,
      controller: emailcontroller,
      validator: (value) => emailValidation(value),
      onTapOutside: (event) {
        emailfocusNode.unfocus();
      },
    );
  }

  Widget methodText() {
    return Text(
      "Sign In",
      style: TextStyle(
        color: ColorConstants.white,
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),
    );
  }

  Widget methodLogo() {
    return Image.asset(ImageConstants.logoimage, width: 150, height: 50);
  }
}

String? emailValidation(String? value) {
  RegExp validate = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );
  if (value == null || value.isEmpty) {
    return 'please Enter your email';
  } else if (!validate.hasMatch(value)) {
    return 'Enter a valid email';
  } else {
    return null;
  }
}

String? passwordValidation(String? value) {
  RegExp capital = RegExp(r'^(?=.*[A-Z]).+$');
  RegExp small = RegExp(r'^(?=.*[a-z]).+$');
  RegExp number = RegExp(r'^(?=.*[0-9]).+$');
  RegExp spclchar = RegExp(r'^(?=.*[@#$%.,]).+$');
  if (value == null || value.isEmpty) {
    return 'Please enter your Password';
  } else if (value.length < 8) {
    return 'password must minimum length of 8';
  } else if (!capital.hasMatch(value)) {
    return 'the password must contain uppercase letter';
  } else if (!small.hasMatch(value)) {
    return 'the password must contain lowercase letter';
  } else if (!number.hasMatch(value)) {
    return 'the password must contain digit';
  } else if (!spclchar.hasMatch(value)) {
    return 'the password must contain a special character';
  } else {
    return null;
  }
}
