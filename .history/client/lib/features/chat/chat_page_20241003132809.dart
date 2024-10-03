import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ChatGPT",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: ListView()),
            Container(
              margin: const EdgeInsets.only(),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          fillColor: Colors.white.withOpacity(0.1)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
