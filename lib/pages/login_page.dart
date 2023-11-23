import 'package:care_on/components/sign_in_button.dart';
import 'package:care_on/components/square_tile.dart';
import 'package:care_on/components/textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //text controller
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() {}

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
              MyTextField(
                controller: usernameController,
                hintText: 'Email',
                obscureText: false,
              ),
              const SizedBox(
                height: 36,
              ),
              MyTextField(
                controller: passwordController,
                hintText: 'Mật khẩu',
                obscureText: true,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Quên mật khẩu?',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff3bb5ff)),
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
              ),
              const SizedBox(
                height: 33,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Color(0xffb6b6b6),
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'or',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffb7b7b8)),
                      ),
                    ),
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Color(0xffb6b6b6),
                    ))
                  ],
                ),
              ),

              // google sign in
              Container(
                  padding: EdgeInsets.fromLTRB(27, 27, 27, 27),
                  child: SquareTile(imagePath: 'lib/images/gmail.png')),

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
                  Text(
                    "Đăng kí ngay",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff3ab5ff)),
                  )
                ],
              )
            ]),
          ),
        )));
  }
}
