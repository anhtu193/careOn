import 'package:care_on/components/sign_in_button.dart';
import 'package:care_on/components/square_tile.dart';
import 'package:care_on/components/textfield.dart';
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
      if (passwordController.text == repeatPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        //pop the loading circle
        Navigator.pop(context);
      } else {
        //pop the loading circle
        Navigator.pop(context);
        //show error message
        showErrorMessage("Mật khẩu không trùng nhau!");
      }
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      // WRONG EMAIL
      if (e.code == 'email-already-in-use') {
        showErrorMessage("Email đã được sử dụng!");
      }
      if (e.code == 'weak-password') {
        showErrorMessage("Mật khẩu quá yếu!");
      }
    }
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
              MyTextField(
                controller: nameController,
                hintText: 'Họ tên',
                obscureText: false,
              ),
              const SizedBox(
                height: 32,
              ),
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),
              const SizedBox(
                height: 32,
              ),
              MyTextField(
                controller: passwordController,
                hintText: 'Mật khẩu',
                obscureText: true,
              ),
              const SizedBox(
                height: 32,
              ),
              MyTextField(
                controller: repeatPasswordController,
                hintText: 'Nhập lại mật khẩu',
                obscureText: true,
              ),

              const SizedBox(
                height: 42,
              ),
              SignInButton(
                buttonName: 'ĐĂNG KÝ',
                onTap: signUserUp,
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
