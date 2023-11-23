import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  const SquareTile({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
      height: 61,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffb6b6b6)),
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        // gmailRK9 (4:28)
        child: SizedBox(width: 35, height: 35, child: Image.asset(imagePath)),
      ),
    );
  }
}
