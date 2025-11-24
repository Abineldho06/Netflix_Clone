import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants/color_constants.dart';

class Custombutton extends StatelessWidget {
  const Custombutton({super.key, this.onTap, required this.text});

  final void Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: MediaQuery.sizeOf(context).height * .07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: ColorConstants.primary,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorConstants.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
