import 'package:care_on/components/alphabet_box.dart';
import 'package:care_on/pages/disease_list_page.dart';
import 'package:flutter/material.dart';

class InfoTab extends StatefulWidget {
  const InfoTab({super.key});

  @override
  State<InfoTab> createState() => _InfoTabState();
}

class _InfoTabState extends State<InfoTab> {
  //navigate to disease list page
  void navigateToDiseaseList(BuildContext context, String letter) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DiseaseListPage(letter: letter)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F6FB),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                " Tra cứu theo bảng chữ cái",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AlphabetBox(
                    letter: "A",
                    startColor: Color(0xffff8686),
                    onTap: () {
                      navigateToDiseaseList(context, "A");
                    },
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  AlphabetBox(
                    letter: "B",
                    startColor: Color(0xffff8686),
                    onTap: () {
                      navigateToDiseaseList(context, "B");
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AlphabetBox(
                    letter: "C",
                    startColor: Color(0xffffb286),
                    onTap: () {
                      navigateToDiseaseList(context, "C");
                    },
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  AlphabetBox(
                    letter: "D",
                    startColor: Color(0xffffb286),
                    onTap: () {
                      navigateToDiseaseList(context, "D");
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AlphabetBox(
                    letter: "Đ",
                    startColor: Color(0xfffcff86),
                    onTap: () {
                      navigateToDiseaseList(context, "Đ");
                    },
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  AlphabetBox(
                    letter: "G",
                    startColor: Color(0xfffcff86),
                    onTap: () {
                      navigateToDiseaseList(context, "G");
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AlphabetBox(
                    letter: "H",
                    startColor: Color(0xffbbff86),
                    onTap: () {
                      navigateToDiseaseList(context, "H");
                    },
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  AlphabetBox(
                    letter: "J",
                    startColor: Color(0xffbbff86),
                    onTap: () {
                      navigateToDiseaseList(context, "J");
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AlphabetBox(
                    letter: "K",
                    startColor: Color(0xff86ffe9),
                    onTap: () {
                      navigateToDiseaseList(context, "K");
                    },
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  AlphabetBox(
                    letter: "L",
                    startColor: Color(0xff86ffe9),
                    onTap: () {
                      navigateToDiseaseList(context, "L");
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AlphabetBox(
                    letter: "M",
                    startColor: Color(0xff86ccff),
                    onTap: () {
                      navigateToDiseaseList(context, "M");
                    },
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  AlphabetBox(
                    letter: "N",
                    startColor: Color(0xff86ccff),
                    onTap: () {
                      navigateToDiseaseList(context, "N");
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AlphabetBox(
                    letter: "P",
                    startColor: Color(0xffb486ff),
                    onTap: () {
                      navigateToDiseaseList(context, "P");
                    },
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  AlphabetBox(
                    letter: "Q",
                    startColor: Color(0xffb486ff),
                    onTap: () {
                      navigateToDiseaseList(context, "Q");
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AlphabetBox(
                    letter: "R",
                    startColor: Color(0xff86a1ff),
                    onTap: () {
                      navigateToDiseaseList(context, "R");
                    },
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  AlphabetBox(
                    letter: "S",
                    startColor: Color(0xff86a1ff),
                    onTap: () {
                      navigateToDiseaseList(context, "S");
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AlphabetBox(
                    letter: "T",
                    startColor: Color(0xffff86f3),
                    onTap: () {
                      navigateToDiseaseList(context, "T");
                    },
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  AlphabetBox(
                    letter: "U",
                    startColor: Color(0xffff86f3),
                    onTap: () {
                      navigateToDiseaseList(context, "U");
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AlphabetBox(
                    letter: "V",
                    startColor: Color(0xffff86b2),
                    onTap: () {
                      navigateToDiseaseList(context, "V");
                    },
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  AlphabetBox(
                    letter: "X",
                    startColor: Color(0xffff86b2),
                    onTap: () {
                      navigateToDiseaseList(context, "X");
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
