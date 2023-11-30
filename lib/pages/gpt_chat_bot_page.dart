import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class ChatGPTPage extends StatefulWidget {
  const ChatGPTPage({super.key});

  @override
  State<ChatGPTPage> createState() => _ChatGPTPageState();
}

class _ChatGPTPageState extends State<ChatGPTPage> {
  final _openAI = OpenAI.instance.build(
      token: "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",
      baseOption: HttpSetup(
          receiveTimeout: const Duration(
        seconds: 5,
      )),
      enableLog: true);
  final ChatUser _currentUser = ChatUser(id: '1');
  final ChatUser _gptChatUser =
      ChatUser(id: '2', firstName: "Care", lastName: "On");

  List<ChatMessage> _messages = <ChatMessage>[];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
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
        body: DashChat(
            currentUser: _currentUser,
            onSend: (ChatMessage m) {
              getChatResponse(m);
            },
            messageOptions: const MessageOptions(
                currentUserContainerColor: Color(0xff3AB5FF),
                containerColor: Color(0xff3AB5FF),
                textColor: Colors.white),
            messages: _messages),
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      _messages.insert(0, m);
    });
    List<Messages> _messagesHistory = _messages.reversed.map((m) {
      if (m.user == _currentUser) {
        return Messages(role: Role.user, content: m.text);
      } else {
        return Messages(role: Role.assistant, content: m.text);
      }
    }).toList();
    final request = ChatCompleteText(
        model: GptTurbo0301ChatModel(),
        messages: _messagesHistory,
        maxToken: 200);
    final response = await _openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      if (element.message != null) {
        setState(() {
          _messages.insert(
              0,
              ChatMessage(
                  user: _gptChatUser,
                  createdAt: DateTime.now(),
                  text: element.message!.content));
        });
      }
    }
  }
}
