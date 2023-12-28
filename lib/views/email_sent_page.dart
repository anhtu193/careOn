import 'package:care_on/components/sign_in_button.dart';
import 'package:care_on/views/login_or_register.dart';
import 'package:flutter/material.dart';

class EmailSentPage extends StatelessWidget {
  const EmailSentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme:
            IconThemeData(color: Colors.white, size: 28 //change your color here
                ),
        backgroundColor: Color(0xffF4F6FB),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 65,
            ),
            Container(
              width: 150,
              height: 150,
              child: Image.asset('lib/images/logo.png'),
            ),
            SizedBox(
              height: 52,
            ),
            Text(
              "Đã gửi Email!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 13,
            ),
            Container(
                width: 320,
                child: Text(
                  "Một email thay đổi mật khẩu đã được gửi tới bạn. Vui lòng kiểm tra inbox để lấy lại mật khẩu.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                  maxLines: null,
                )),
            SizedBox(
              height: 29,
            ),
            SignInButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginOrRegisterPage(),
                    ),
                  );
                },
                buttonName: "ĐĂNG NHẬP",
                width: 307)
          ],
        ),
      ),
    ));
  }
}
