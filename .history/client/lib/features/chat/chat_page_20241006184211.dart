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
              height: 120,
              padding: const EdgeInsets.all(16),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 200,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withOpacity(0.1).)
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              margin: const EdgeInsets.only(left: 16, right: 16, top: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          filled: false,
                          hintText: "Ask Anything..."),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  InkWell(
                      child: Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                  )),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text(
                    'ChatGPT September 2024',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text('Free Research Preview'),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
