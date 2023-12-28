import 'package:care_on/models/disease_model.dart';
import 'package:care_on/presenters/disease_presenter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DiseaseInfoPage extends StatefulWidget {
  String diseaseName;
  DiseaseInfoPage({super.key, required this.diseaseName});

  @override
  State<DiseaseInfoPage> createState() => _DiseaseInfoPageState();
}

class _DiseaseInfoPageState extends State<DiseaseInfoPage> {
  final DiseasePresenter presenter = DiseasePresenter();

  late Future<Map<String, dynamic>> diseaseInfo;

  @override
  void initState() {
    super.initState();
    diseaseInfo = fetchDiseaseInfo();
  }

  Future<Map<String, dynamic>> fetchDiseaseInfo() async {
    try {
      return await presenter.fetchDiseaseInfo(widget.diseaseName);
    } catch (e) {
      throw e;
    }
  }

  String processTextWithLineBreaks(String inputText) {
    List<String> lines = inputText.split('-');
    String processedText = lines.join('\n•');
    return processedText;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme:
            IconThemeData(color: Colors.black, size: 28 //change your color here
                ),
        backgroundColor: Color(0xffF4F6FB),
        elevation: 0,
        title: Text(
          widget.diseaseName,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: diseaseInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data available'));
          } else {
            // Lấy thông tin từ snapshot và hiển thị lên các Text
            var diseaseData = snapshot.data!;
            if (diseaseData != null) {
              String cause = diseaseData['cause'];
              String diagnosis = diseaseData['diagnosis'];
              String overview = diseaseData['overview'];
              String prevention = diseaseData['prevention'];
              String symptom = diseaseData['symptom'];
              String treatment = diseaseData['treatment'];
              String vulnerable = diseaseData['vulnerable'];

              Disease disease = Disease(
                  diseaseName: widget.diseaseName,
                  cause: cause,
                  diagnosis: diagnosis,
                  overview: overview,
                  prevention: prevention,
                  symptom: symptom,
                  treatment: treatment,
                  vulnerable: vulnerable);
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tổng quan:',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      processTextWithLineBreaks(overview),
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.4),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Nguyên nhân gây ra bệnh ' + disease.diseaseName,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      processTextWithLineBreaks(cause),
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.4),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Triệu chứng bệnh ' + disease.diseaseName,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      processTextWithLineBreaks(disease.symptom),
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.4),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Đối tượng nguy cơ bệnh ' + disease.diseaseName,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      processTextWithLineBreaks(disease.vulnerable),
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.4),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Phòng ngừa bệnh ' + disease.diseaseName,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      processTextWithLineBreaks(disease.prevention),
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.4),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Các biện pháp chẩn đoán bệnh ' + disease.diseaseName,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      processTextWithLineBreaks(disease.diagnosis),
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.4),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Các biện pháp điều trị bệnh ' + disease.diseaseName,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      processTextWithLineBreaks(disease.treatment),
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.4),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Text('No data available'));
            }
          }
        },
      ),
    ));
  }
}
