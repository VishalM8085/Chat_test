import 'package:client/design/app_colors.dart';
import 'package:client/features/chat/bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatBloc chatBloc = ChatBloc();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ChatGPT",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        bloc: chatBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Container(
            child: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  padding: const EdgeInsets.only(top: 12),
                  itemCount: chatBloc.cachedMessage.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color:
                              chatBloc.cachedMessage[index].role == 'assistant'
                                  ? AppColors.messageBgColor
                                  : Colors.transparent),
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 8, top: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          chatBloc.cachedMessage[index].role == 'assistant'
                              ? Container(
                                  height: 32,
                                  width: 32,
                                  child: SvgPicture.asset(
                                    "assets/chatgpt.svg",
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  height: 32,
                                  width: 32,
                                  child: SvgPicture.asset(
                                    "assets/randomperson.svg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              chatBloc.cachedMessage[index].content,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )),
                Container(
                  height: 100,
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      promptContainer("Tell me something about Bill Gates"),
                      promptContainer(
                          "What are the achievements of Steve Jobs?"),
                      promptContainer(
                          "Explain the significance of artificial intelligence."),
                      promptContainer(
                          "Tell me about the history of the internet."),
                      promptContainer(
                          "Who is Elon Musk and what is he known for?"),
                      promptContainer(
                          "What are the key benefits of renewable energy?"),
                      promptContainer(
                          "Describe the impact of climate change on the environment.")
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
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          cursorColor: Colors.white,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              filled: false,
                              hintText: "Ask Anything..."),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      InkWell(
                          onTap: () {
                            if (controller.text.isNotEmpty) {
                              String text = controller.text;
                              controller.clear();
                              chatBloc.add(ChatNewPromptEvent(prompt: text));
                            }
                          },
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
          );
        },
      ),
    );
  }

  Widget promptContainer(String text) {
    return InkWell(
      on
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        width: 200,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.0),
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(text),
      ),
    );
  }
}
