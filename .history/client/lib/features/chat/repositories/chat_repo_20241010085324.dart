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
//The async* indicates that this function is an asynchronous generator. Instead of returning a single result, it can yield multiple values over time (in this case, HTTP responses), making it useful for streaming data.

// http.Response is the object that contains the data returned by the server in response to an HTTP request. You use it to read the server's response, like body, headers, or status code.
//http.Client is a reusable HTTP client that allows you to send multiple requests efficiently, providing more control over the request process and resource management (such as connection pooling).