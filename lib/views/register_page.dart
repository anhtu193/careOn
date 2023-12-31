import 'package:care_on/components/sign_in_button.dart';
import 'package:care_on/components/square_tile.dart';
import 'package:care_on/components/textfield.dart';
import 'package:care_on/views/login_or_register.dart';
import 'package:care_on/views/login_page.dart';
import 'package:care_on/views/navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controller
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final repeatPasswordController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  //sign user up
  void signUserUp() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    //try creating user
    try {
      //create User
      if (passwordController.text == repeatPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
        //pop the loading circle
        Navigator.pop(context);
        //add user detail to Firestore
        addUserDetails(nameController.text, emailController.text);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Tạo tài khoản thành công!',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 16),
          ),
          duration: Duration(seconds: 2), // Thời gian hiển thị SnackBar
        ));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NavigationPage(),
          ),
        );
      } else {
        //pop the loading circle
        Navigator.pop(context);
        //show error message
        showErrorMessage("Mật khẩu không trùng nhau!");
      }
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      // WRONG EMAIL0
      if (e.code == 'email-already-in-use') {
        showErrorMessage("Email đã được sử dụng!");
      }
      if (e.code == 'weak-password') {
        showErrorMessage("Mật khẩu quá yếu!");
      }
    }
  }

  Future addUserDetails(String name, String email) async {
    final User? user = auth.currentUser;
    final uid = user?.uid;
    await FirebaseFirestore.instance.collection('users').add({
      'Name': name,
      'Email': email,
      'UserID': uid,
      'height': "__",
      'weight': "__",
      'age': '__',
      'gender': '__',
    });
  }

  void showErrorMessage(String text) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(text),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      "Tạo tài khoản \ncủa bạn",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 43,
              ),
              //email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: MyTextField(
                  inputType: TextInputType.text,
                  controller: nameController,
                  hintText: 'Họ tên',
                  obscureText: false,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: MyTextField(
                  inputType: TextInputType.text,
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: MyTextField(
                  inputType: TextInputType.text,
                  controller: passwordController,
                  hintText: 'Mật khẩu',
                  obscureText: true,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: MyTextField(
                  inputType: TextInputType.text,
                  controller: repeatPasswordController,
                  hintText: 'Nhập lại mật khẩu',
                  obscureText: true,
                ),
              ),

              const SizedBox(
                height: 42,
              ),
              SignInButton(
                buttonName: 'ĐĂNG KÝ',
                onTap: signUserUp,
                width: 307,
              ),
              const SizedBox(
                height: 192,
              ),

              //Chua co tai khoan ? Dang ki ngay
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Đã có tài khoản?",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Đăng nhập",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff3ab5ff)),
                    ),
                  )
                ],
              )
            ]),
          ),
        )));
  }
}
