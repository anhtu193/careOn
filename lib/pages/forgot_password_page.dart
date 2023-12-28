import 'package:care_on/components/sign_in_button.dart';
import 'package:care_on/components/textfield.dart';
import 'package:care_on/pages/email_sent_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  Future passwordReset() async {
    if (emailController.value.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Vui lòng nhập email để lấy lại mật khẩu!',
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              fontSize: 16),
        ),
        duration: Duration(seconds: 2), // Thời gian hiển thị SnackBar
      ));
    } else {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EmailSentPage(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        print(e);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(e.message.toString()),
              );
            });
      }
    }
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
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 51,
                ),
                Text(
                  "Đổi mật khẩu",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 13,
                ),
                Text(
                  "Vui lòng nhập email của bạn để lấy lại mật khẩu.",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 27,
                ),
                MyTextField(
                    controller: emailController,
                    hintText: "Nhập email",
                    obscureText: false,
                    inputType: TextInputType.text),
                SizedBox(
                  height: 28,
                ),
                SignInButton(
                  onTap: passwordReset,
                  buttonName: "TIẾP TỤC",
                  width: 350,
                )
              ],
            ),
          );
        },
      ),
    ));
  }
}
