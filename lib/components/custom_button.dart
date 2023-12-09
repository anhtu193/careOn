import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String imagePath;
  String buttonFunctionName;
  CustomButton(
      {super.key, required this.imagePath, required this.buttonFunctionName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(13, 15, 11, 14),
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Color(0x3f000000),
            offset: Offset(0, 2),
            blurRadius: 2.5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: Image.asset(imagePath),
          ),
          SizedBox(
            height: 5,
          ),
          Text(buttonFunctionName,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400))
        ],
      ),
    );
  }
}
