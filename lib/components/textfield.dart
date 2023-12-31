import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final TextInputType inputType;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.inputType});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
          fontSize: 14, fontFamily: 'Montserrat', fontWeight: FontWeight.w700),
      controller: controller,
      obscureText: obscureText,
      keyboardType: inputType,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: 13,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffcdcdcd)),
              borderRadius: BorderRadius.circular(15)),
          filled: true,
          contentPadding: EdgeInsets.all(16)),
    );
  }
}
