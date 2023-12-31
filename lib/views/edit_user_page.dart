import 'package:care_on/components/custom_dropdown.dart';
import 'package:care_on/components/textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  List<String> items = ["Nam", "Nữ"];
  late String selectedGender;
  late Future<DocumentSnapshot> userDataFuture;
  bool isInitialized = false;

  void setSelectedGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
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

  //update data
  Future<void> updateUserDataToFirebase() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String currentUserID = user.uid;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('UserID', isEqualTo: currentUserID)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String documentID = querySnapshot.docs.first.id;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(documentID)
            .update({
          'Name': nameController.text,
          'age': ageController.text,
          'height': heightController.text,
          'weight': weightController.text,
          'gender': selectedGender,
        }).then((_) {
          print('User data updated successfully!');
        }).catchError((error) {
          print('Failed to update user data: $error');
        });
      } else {
        print('No user data found for the current user.');
      }
      // Quay về màn hình trước đó
      Navigator.pop(context, true);
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
      appBar: AppBar(
        centerTitle: true,
        iconTheme:
            IconThemeData(color: Colors.black, size: 28 //change your color here
                ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "CHỈNH SỬA HỒ SƠ",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                updateUserDataToFirebase();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Cập nhật thông tin thành công'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: Icon(
                Icons.check,
                size: 28,
              ))
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(), // Show loading indicator
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            // Data fetched successfully, display your content
            DocumentSnapshot userData = snapshot.data!;

            if (!isInitialized) {
              nameController.text = userData['Name'] ?? '';
              ageController.text =
                  userData['age'] != null ? userData['age'].toString() : '';
              heightController.text = userData['height'] != null
                  ? userData['height'].toString()
                  : '';
              weightController.text = userData['weight'] != null
                  ? userData['weight'].toString()
                  : '';

              if (userData['gender'].toString() == "Nam") {
                selectedGender = "Nam";
              } else {
                selectedGender = "Nữ";
              }

              isInitialized = true; // Mark as initialized
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Họ và tên:",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MyTextField(
                        inputType: TextInputType.text,
                        controller: nameController,
                        hintText: "Nhập tên",
                        obscureText: false),
                    SizedBox(height: 16),
                    Text(
                      "Tuổi:",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MyTextField(
                        inputType: TextInputType.number,
                        controller: ageController,
                        hintText: "Nhập tuổi",
                        obscureText: false),
                    SizedBox(height: 16),
                    Text(
                      "Giới tính:",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomDropdown(
                      items: items,
                      selectedItem: selectedGender,
                      onChanged: (newValue) {
                        setSelectedGender(newValue!);
                      },
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Chiều cao:",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MyTextField(
                        inputType: TextInputType.number,
                        controller: heightController,
                        hintText: "Nhập chiều cao",
                        obscureText: false),
                    SizedBox(height: 16),
                    Text(
                      "Cân nặng:",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MyTextField(
                        inputType: TextInputType.number,
                        controller: weightController,
                        hintText: "Nhập cân nặng",
                        obscureText: false),
                  ],
                ),
              ),
            );
          }
        },
      ),
    ));
  }
}
