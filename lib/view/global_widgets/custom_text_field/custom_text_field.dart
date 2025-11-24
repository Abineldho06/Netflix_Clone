import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants/color_constants.dart';

class Customtextfield extends StatelessWidget {
  const Customtextfield({
    super.key,
    required this.fieldfcusNode,
    required this.controller,
    this.validator,
    this.obscuretext = false,
    required this.hinttext,
    this.onTapOutside,
    this.formkey,
    this.paddingbottom = 20,
    this.suffixIcon,
    this.suffixonPressed,
  });

  final FocusNode fieldfcusNode;
  final TextEditingController controller;
  final bool obscuretext;
  final void Function(PointerDownEvent)? onTapOutside;
  final String? Function(String?)? validator;
  final double paddingbottom;
  final IconData? suffixIcon;
  final String hinttext;
  final Key? formkey;
  final void Function()? suffixonPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(bottom: paddingbottom),
      child: Form(
        key: formkey,
        child: TextFormField(
          obscureText: obscuretext,
          validator: validator,
          style: TextStyle(color: ColorConstants.white),
          focusNode: fieldfcusNode,
          controller: controller,
          decoration: InputDecoration(
            hintText: hinttext,
            hintStyle: TextStyle(color: Colors.white54),
            filled: true,
            fillColor: Colors.grey.withValues(alpha: .3),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorConstants.primary),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white12),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorConstants.primary),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorConstants.white),
            ),
            suffixIcon: IconButton(
              onPressed: suffixonPressed,
              icon: Icon(suffixIcon, size: 20, color: ColorConstants.white),
            ),
          ),
          onTapOutside: onTapOutside,
        ),
      ),
    );
  }
}
