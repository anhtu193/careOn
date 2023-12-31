import 'package:flutter/material.dart';

class DiseaseBox extends StatelessWidget {
  String diseaseName;
  final Function()? onTap;
  DiseaseBox({super.key, required this.diseaseName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        width: double.infinity,
        height: 45,
        child: Padding(
          padding: EdgeInsets.only(top: 13, bottom: 10, left: 23),
          child: Text(
            diseaseName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
