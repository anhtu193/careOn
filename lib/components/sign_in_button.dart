import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonName;
  const SignInButton(
      {super.key, required this.onTap, required this.buttonName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 309,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xff3ab5ff),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Color(0x3f000000),
              offset: Offset(0, 3),
              blurRadius: 2,
            ),
          ],
        ),
        child: Center(
          child: Center(
            child: Text(
              buttonName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 1.2175,
                color: Color(0xffffffff),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
