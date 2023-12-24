import 'package:care_on/components/custom_button.dart';
import 'package:care_on/pages/add_note_page.dart';
import 'package:care_on/pages/note_page.dart';
import 'package:care_on/pages/reminder_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:care_on/pages/chat_bot_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = "Loading...";
  String userHeight = "__";
  String userWeight = "__";
  String bodyCondition = "";
  String adviceText = "";
  double bmi = 0;

  void setCondition(double bmi) {
    if (bmi > 0 && bmi < 18.5) {
      setState(() {
        bodyCondition = "Thiếu cân";
        adviceText =
            "Bạn đang gặp phải tình trạng thiếu cân, vì thế nên áp dụng các phương pháp ăn uống và luyện tập để tăng trọng lượng cơ thể.";
      });
    }
    if (bmi >= 18.5 && bmi < 25) {
      setState(() {
        bodyCondition = "Bình thường";
        adviceText =
            "Bạn đang sở hữu cân nặng khỏe mạnh, cần duy trì quá trình ăn uống và sinh hoạt như thường ngày.";
      });
    }
    if (bmi >= 25 && bmi < 30) {
      setState(() {
        bodyCondition = "Thừa cân";
        adviceText =
            "Bạn đang trong tình trạng thừa cân, cần áp dụng thực đơn ăn kiêng hợp lý cùng việc luyện tập khoa học để lấy lại vóc dáng chuẩn nhất.";
      });
    }
    if (bmi >= 30) {
      setState(() {
        bodyCondition = "Béo phì";
        adviceText =
            "Bạn đang bị béo phì và tình trạng này có thể khiến bạn gặp rất nhiều vấn đề về sức khỏe cũng như trong sinh hoạt. Bạn cần áp dụng thực đơn hợp lý cùng việc luyện tập khoa học để giảm cân một cách hiệu quả nhất.";
      });
    }
  }

  Future<String> getUserNameFromFirebase() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('UserID', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userDocument = querySnapshot.docs[0];
        userName = userDocument['Name'];

        print('Đang đăng nhập với user: $userName');
        return userName;
      } else {
        print('Không tìm thấy Document cho userId: $userId');
        return "Unknown user!";
      }
    } else {
      return "User's not signed in!";
    }
  }

  Future<String> getUserHeightFromFirebase() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('UserID', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userDocument = querySnapshot.docs[0];
        userHeight = userDocument['height'];

        print('$userName : cao $userHeight cm');
        return userHeight;
      } else {
        print('Không tìm thấy Document cho userId: $userId');
        return " ";
      }
    } else {
      return " ";
      ;
    }
  }

  Future<String> getUserWeightFromFirebase() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('UserID', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userDocument = querySnapshot.docs[0];
        userWeight = userDocument['weight'];

        print('$userName : nặng $userWeight kg');
        return userWeight;
      } else {
        print('Không tìm thấy Document cho userId: $userId');
        return " ";
      }
    } else {
      return " ";
    }
  }

  double calculateBMI(String height, String weight) {
    if (height != "__" && weight != "__" && height != "0" && weight != "0") {
      double dHeight = double.parse(height);
      double dWeight = double.parse(weight);
      dHeight = dHeight / 100;
      double bmi = dWeight / (dHeight * dHeight);
      return bmi;
    }
    return 0;
  }

  @override
  void initState() {
    super.initState();
    getUserDataFromFirebase();
  }

  Future<void> getUserDataFromFirebase() async {
    String height = await getUserHeightFromFirebase();
    String weight = await getUserWeightFromFirebase();

    setState(() {
      userHeight = height;
      userWeight = weight;
      bmi = calculateBMI(userHeight, userWeight);
      setCondition(bmi);
    });
  }

  //sign user out
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  Color bodyConditionColor(String bodyCondition) {
    if (bodyCondition == "Bình thường") return Color(0xff14ff00);
    if (bodyCondition == "Thiếu cân") return Color(0xff3AB5FF);
    if (bodyCondition == "Thừa cân") return Color(0xffFF6B00);
    if (bodyCondition == "Béo phì") return Color(0xffFF0000);
    return Color(0xff14ff00);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(31, 45, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(1, 0, 32, 24.5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 119, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "👋 Xin chào",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Center(
                          child: FutureBuilder<String>(
                            future: getUserNameFromFirebase(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return Text(
                                    snapshot.data ?? "Unknown user!",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                    height: 31,
                    width: 31,
                    child: Image.asset('lib/images/bell.png'),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 30, 29.5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReminderPage(),
                          ));
                    },
                    child: CustomButton(
                      imagePath: "lib/images/reminder.png",
                      buttonFunctionName: "Nhắc nhở",
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotePage(),
                        ),
                      );
                    },
                    child: CustomButton(
                        imagePath: "lib/images/note.png",
                        buttonFunctionName: "Ghi chú"),
                  ),
                  Spacer(),
                  CustomButton(
                      imagePath: "lib/images/hospital.png",
                      buttonFunctionName: "Bệnh viện")
                ],
              ),
            ),
            Container(
              margin: bmi == 0
                  ? EdgeInsets.fromLTRB(0, 0, 33, 0)
                  : EdgeInsets.fromLTRB(0, 0, 33, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 14),
                    child: Text(
                      'Tình trạng của tôi',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // chieu cao
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 11),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Chiều cao:',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(22, 0, 0, 0),
                                      child: FutureBuilder<String>(
                                        future: getUserHeightFromFirebase(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return CircularProgressIndicator();
                                          } else {
                                            if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            } else {
                                              return Text(
                                                userHeight + " cm",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              );
                                            }
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              // can nang
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text("Cân nặng:",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(23, 0, 0, 0),
                                      child: FutureBuilder<String>(
                                        future: getUserWeightFromFirebase(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return CircularProgressIndicator();
                                          } else {
                                            if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            } else {
                                              return Text(
                                                userWeight + " kg",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              );
                                            }
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 3.5),
                                  child: Text(
                                    "BMI",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  bmi.toStringAsFixed(1).toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff3ab5ff),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: bmi == 0
                        ? Text(
                            "Hãy cho biết cả chiều cao và cân nặng của bạn ở phần Hồ sơ để biết được tình trạng cơ thể của mình nhé!",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bmi == 0 ? "" : "Tình trạng cơ thể:   ",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                bodyCondition,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: bodyConditionColor(bodyCondition)),
                              )
                            ],
                          ),
                  ),
                  Container(
                    margin: bmi == 0
                        ? EdgeInsets.only(top: 0)
                        : EdgeInsets.only(top: 15),
                    child: RichText(
                      text: TextSpan(
                        text: bmi == 0 ? "" : "Lời khuyên: ",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontFamily: 'Montserrat'),
                        children: <TextSpan>[
                          TextSpan(
                            text: adviceText,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nhắc nhở",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
