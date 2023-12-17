import 'package:care_on/pages/edit_user_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:care_on/pages/chat_bot_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late Future<DocumentSnapshot> userDataFuture;
  String userName = "Lý Thanh Tú Anh";
  String age = "20";
  String gender = "Nam";
  String height = "165 cm";
  String weight = "60 kg";

  //sign user out
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  // Điều hướng đến trang chỉnh sửa thông tin người dùng
  void toEditUserPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditUserPage()),
    );

    if (result != null && result is bool && result) {
      // Nếu thông tin đã được cập nhật, gọi lại hàm lấy dữ liệu để cập nhật trang UserPage
      setState(() {
        userDataFuture = getUserDataFromFirebase();
      });
    }
  }

  //fetch data from firebase
  Future<DocumentSnapshot> getUserDataFromFirebase() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String currentUserID = user.uid;

      return FirebaseFirestore.instance
          .collection('users')
          .where('UserID', isEqualTo: currentUserID)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          return querySnapshot.docs.first;
        } else {
          throw Exception('No user data found for the current user.');
        }
      });
    } else {
      throw Exception('User is not signed in.');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDataFuture = getUserDataFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xffF4F6FB),
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xffF4F6FB),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.edit),
                color: Colors.black,
                onPressed: toEditUserPage,
              ),
            )
          ],
          title: Text(
            "HỒ SƠ",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          )),
      body: FutureBuilder<DocumentSnapshot>(
        future: userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            DocumentSnapshot userData = snapshot.data!;
            String userName = userData['Name'] ?? '';
            String age =
                userData['age'] != null ? userData['age'].toString() : '';
            String gender = userData['gender'] ?? '';
            String height =
                userData['height'] != null ? userData['height'].toString() : '';
            String weight =
                userData['weight'] != null ? userData['weight'].toString() : '';

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: Container(
                    width: 200,
                    child: Text(
                      userName,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )),
                  SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 153,
                          height: 87,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 14, bottom: 14, left: 20),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset("lib/images/age.png"),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Tuổi",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    age,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff667085)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 153,
                          height: 87,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 14, bottom: 14, left: 20),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset("lib/images/gender.png"),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Giới tính",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    gender,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff667085)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 153,
                          height: 87,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 14, bottom: 14, left: 20),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset("lib/images/height.png"),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Chiều cao",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    height,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff667085)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 153,
                          height: 87,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 14, bottom: 14, left: 20),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset("lib/images/weight.png"),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Cân nặng",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    weight,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff667085)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  GestureDetector(
                    onTap: signUserOut,
                    child: Container(
                      height: 28,
                      width: 128,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 28,
                              width: 28,
                              child: Image.asset("lib/images/logout.png"),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Đăng xuất",
                              style: TextStyle(fontSize: 16),
                            )
                          ]),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    ));
  }
}
