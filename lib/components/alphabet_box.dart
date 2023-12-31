import 'package:flutter/material.dart';

class AlphabetBox extends StatefulWidget {
  String letter;
  Color startColor;
  final Function()? onTap;
  AlphabetBox(
      {super.key,
      required this.letter,
      required this.startColor,
      required this.onTap});

  @override
  State<AlphabetBox> createState() => _AlphabetBoxState();
}

class _AlphabetBoxState extends State<AlphabetBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 148,
        height: 148,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 81.3,
              height: 81.3,
              margin: EdgeInsets.all(33.35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(39),
                gradient: LinearGradient(
                  begin: Alignment(0, -1),
                  end: Alignment(0, 1),
                  colors: <Color>[widget.startColor, Color(0x00d9d9d9)],
                  stops: <double>[0, 1],
                ),
              ),
              child: Center(
                child: Text(
                  widget.letter,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
