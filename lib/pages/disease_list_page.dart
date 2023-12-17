import 'package:care_on/components/disease_box.dart';
import 'package:care_on/pages/disease_info_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DiseaseListPage extends StatefulWidget {
  String letter;
  DiseaseListPage({super.key, required this.letter});

  @override
  State<DiseaseListPage> createState() => _DiseaseListPageState();
}

class _DiseaseListPageState extends State<DiseaseListPage> {
  late List<String> diseaseNames = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDiseasesStartingWithLetter();
  }

  void fetchDiseasesStartingWithLetter() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(
              'diseases') // Thay 'diseases' bằng tên collection của bạn trong Firestore
          .where('letter', isEqualTo: widget.letter)
          .get();

      setState(() {
        diseaseNames = querySnapshot.docs
            .map((doc) => doc['diseaseName'] as String)
            .toList();
      });
    } catch (e) {
      print('Error fetching diseases: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(
              color: Colors.black, size: 28 //change your color here
              ),
          backgroundColor: Color(0xffF4F6FB),
          elevation: 0,
          title: Text(
            "Bệnh bắt đầu với chữ cái " + widget.letter,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: Container(
          color: Color(0xffF4F6FB),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: diseaseNames.length,
                    itemBuilder: (context, index) {
                      return DiseaseBox(
                        diseaseName: diseaseNames[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DiseaseInfoPage(
                                diseaseName: diseaseNames[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
