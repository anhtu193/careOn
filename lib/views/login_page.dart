import 'package:care_on/components/sign_in_button.dart';
import 'package:care_on/components/square_tile.dart';
import 'package:care_on/components/textfield.dart';
import 'package:care_on/views/email_sent_page.dart';
import 'package:care_on/views/forgot_password_page.dart';
import 'package:care_on/views/navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool isHidden = false;

  void signUserIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    //sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      //pop the loading circle
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NavigationPage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      // WRONG EMAIL
      if (e.code == 'invalid-credential') {
        signInErrorMessage();
      }
    }
  }

  void signInErrorMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Email hoặc mật khẩu không hợp lệ!"),
        );
      },
    );
  }

  void toggleVisibleState() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isHidden = true;
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
                height: 71,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 2, 78),
                width: 150,
                height: 150,
                child: Image.asset('lib/images/logo.png'),
              ),
              //email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: MyTextField(
                  inputType: TextInputType.text,
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    MyTextField(
                      inputType: TextInputType.text,
                      controller: passwordController,
                      hintText: 'Mật khẩu',
                      obscureText: isHidden,
                    ),
                    Positioned(
                      bottom: 12,
                      right: 15,
                      child: GestureDetector(
                        onTap: () {
                          toggleVisibleState();
                        },
                        child: SizedBox(
                          height: 25,
                          width: 25,
                          child: isHidden == false
                              ? Image.asset("lib/images/hidden.png")
                              : Image.asset("lib/images/visible.png"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Quên mật khẩu?',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff3bb5ff)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 21,
              ),
              SignInButton(
                buttonName: 'ĐĂNG NHẬP',
                onTap: signUserIn,
                width: 309,
              ),
              const SizedBox(
                height: 128,
              ),

              //Chua co tai khoan ? Dang ki ngay
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Chưa có tài khoản",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Đăng kí ngay",
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
