import 'dart:convert';

import 'package:care_on/components/messages_screen.dart';
import 'package:care_on/components/textfield.dart';
import 'package:care_on/pages/home_page.dart';
import 'package:care_on/pages/navigator.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late SharedPreferences _prefs;
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();
  late ScrollController _scrollController;
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    _scrollController = ScrollController();
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
      // Khôi phục tin nhắn khi mở lại ứng dụng
      restoreMessages();
    });
    super.initState();
  }

  void restoreMessages() {
    final List<String>? encodedMessages = _prefs.getStringList('savedMessages');
    if (encodedMessages != null) {
      setState(() {
        messages = encodedMessages
            .map((encodedMessage) => Map<String, dynamic>.from(
                json.decode(encodedMessage))) // Phục hồi tin nhắn từ chuỗi
            .toList();
      });
    }
  }

  void saveMessages() {
    final List<String> encodedMessages = messages
        .map((message) => message.toString()) // Chuyển đổi tin nhắn thành chuỗi
        .toList();
    _prefs.setStringList('savedMessages', encodedMessages);
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
    saveMessages();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF4F6FB),
        appBar: AppBar(
          elevation: 0,
          title: Column(
            children: [
              Text(
                'CHAT',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Giải đáp các vấn đề sức khỏe',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w200),
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Container(
          child: Column(children: [
            Expanded(
                child: MessagesScreen(
              messages: messages,
              scrollController: _scrollController,
            )),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: MyTextField(
                        controller: _controller,
                        hintText: "Nhập tin nhắn của bạn",
                        obscureText: false),
                  )),
                  IconButton(
                      onPressed: () {
                        sendMessage(_controller.text);
                        _controller.clear();
                      },
                      icon: Icon(
                        Icons.send,
                        color: Color(0xff3AB5FF),
                      ))
                ]),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
