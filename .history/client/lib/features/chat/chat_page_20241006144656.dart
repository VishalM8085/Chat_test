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
              padding: EdgeInsets.symmetric(horizontal: 12),
              margin: const EdgeInsets.only(
                  bottom: 40, left: 16, right: 16, top: 6),
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
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        filled: false,
                        hintText: "Ask Anything..."
                      ),
                    ),
                  ),
                  const SizedBox(width: 12,),
                  InkWell(child: Icon(Icons.send_rounded,color: Colors.white,)),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      Text('ChatGPT September 2024'),
                      const SizedBox(width: 5,),
                    ],
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
