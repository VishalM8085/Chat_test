// network function will be here
import 'package:http/http.dart' as http;
import 'package:client/features/chat/models/chat_message_model.dart';

Stream<http.Response> getChatGptResponse(
    List<ChatMessageModel> messages) async* {
  List<Map> mappedMessage = [];
  for (int i = 0; i < messages.length; i++) {
    mappedMessage.add(messages[i].toMap());
  }
}


// This defines a function called getChatGptResponse.
// It returns a Stream of http.Response objects, which allows you to handle a sequence of HTTP responses asynchronously over time.
// A Stream is like an asynchronous sequence of events, useful when you are receiving data bit by bit.
// 