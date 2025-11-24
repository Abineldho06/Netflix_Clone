import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants/color_constants.dart';
import 'package:netflix_clone/core/constants/image_constants.dart';
import 'package:netflix_clone/services/user_service.dart';
import 'package:netflix_clone/view/global_widgets/custom_button/custom_button.dart';
import 'package:netflix_clone/view/global_widgets/custom_text_field/custom_text_field.dart';
import 'package:netflix_clone/view/sign_in_page/signin_page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  UserService userService = UserService();

  final emailformkey = GlobalKey<FormState>();
  final passformkey = GlobalKey<FormState>();
  final repassformkey = GlobalKey<FormState>();

  FocusNode emailfocusNode = FocusNode();
  FocusNode passwordfocusNode = FocusNode();
  FocusNode repasswordfocusNode = FocusNode();

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController repasswordcontroller = TextEditingController();

  bool passstatus = true;
  bool repassstatus = true;

  bool ischecked = false;

  Future<void> createAccount() async {
    if (emailformkey.currentState!.validate() &&
        passformkey.currentState!.validate() &&
        repassformkey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Account Created")));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstants.signuppage),
              fit: BoxFit.cover,
            ),
          ),
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: methodFloatingContainer(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget methodFloatingContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
          //SignUp Text
          methodtextSignup(),
          SizedBox(height: 20),
          //Email Text Feild
          methodEmailFiled(),
          //Password text Feild
          methodPaswordFiled(),
          //Re-password Field
          methodRePassField(),
          //Button
          methodButton(context),
          //Remind me CheckBox
          methodCheckbox(),
          SizedBox(height: 20),
          //Already have Account
          methodAlreadyHaveAccoount(context),
        ],
      ),
    );
  }

  Widget methodLogo() {
    return Image.asset(ImageConstants.logoimage, width: 150, height: 50);
  }

  Widget methodtextSignup() {
    return Text(
      "Sign up",
      style: TextStyle(
        color: ColorConstants.white,
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),
    );
  }

  Widget methodEmailFiled() {
    return Customtextfield(
      hinttext: 'Email or phone number',
      formkey: emailformkey,
      fieldfcusNode: emailfocusNode,
      controller: emailcontroller,
      validator: (value) => emailValidation(value),
    );
  }

  Widget methodPaswordFiled() {
    return Customtextfield(
      hinttext: 'Password',
      formkey: passformkey,
      fieldfcusNode: passwordfocusNode,
      controller: passwordcontroller,
      obscuretext: passstatus,
      suffixIcon: passstatus
          ? Icons.visibility_rounded
          : Icons.visibility_off_sharp,
      suffixonPressed: () {
        passstatus = !passstatus;
        setState(() {});
      },
      validator: (value) => passwordValidation(value),
      onTapOutside: (event) {
        passwordfocusNode.unfocus();
      },
    );
  }

  Widget methodRePassField() {
    return Customtextfield(
      hinttext: 'Re Password',
      formkey: repassformkey,
      fieldfcusNode: repasswordfocusNode,
      controller: repasswordcontroller,
      obscuretext: repassstatus,
      suffixIcon: repassstatus
          ? Icons.visibility_rounded
          : Icons.visibility_off_sharp,
      suffixonPressed: () {
        repassstatus = !repassstatus;
        setState(() {});
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 're enter password';
        }
        if (value.trim() != passwordcontroller.text.trim()) {
          return 're enter password was wrong';
        } else {
          return null;
        }
      },
      onTapOutside: (event) {
        repasswordfocusNode.unfocus();
      },
    );
  }

  Widget methodButton(BuildContext context) {
    return Custombutton(
      text: 'Sign up',
      onTap: () {
        createAccount();
      },
    );
  }

  Widget methodCheckbox() {
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
          onPressed: () {},
          child: const Text(
            'Need Help?',
            style: TextStyle(color: ColorConstants.white),
          ),
        ),
      ],
    );
  }

  Widget methodAlreadyHaveAccoount(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        Text(
          'Already Have an Account?',
          style: TextStyle(color: Colors.white70),
        ),
        InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignInScreen()),
            );
          },
          child: Text(
            'Login',
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
}

String? emailValidation(String? value) {
  RegExp validate = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );
  if (value == null || value.isEmpty) {
    return 'Please Enter a valid Email';
  } else if (!validate.hasMatch(value)) {
    return 'Invalid Email';
  } else {
    return null;
  }
}

String? passwordValidation(String? value) {
  RegExp capital = RegExp(r'^(?=.*[A-Z]).+$');
  RegExp small = RegExp(r'^(?=.*[a-z]).+$');
  RegExp number = RegExp(r'^(?=.*[0-9]).+$');
  RegExp spclchar = RegExp(r'^(?=.*[#*@.!%,]).+$');

  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  } else if (value.length < 8) {
    return 'password must minimum length of 8';
  } else if (!capital.hasMatch(value)) {
    return 'Password must contain a uppercase letter';
  } else if (!small.hasMatch(value)) {
    return 'Password must contaion a lowercase letter';
  } else if (!number.hasMatch(value)) {
    return 'Password must include a digit';
  } else if (!spclchar.hasMatch(value)) {
    return 'Password must contain a special character';
  } else {
    return null;
  }
}
