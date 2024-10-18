// network function will be here
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chatflowai/features/chat/models/chat_message_model.dart';

Stream<http.Response> getChatGptResponseRepo(
    List<ChatMessageModel> messages) async* {
    List<Map> mappedMessage = [];
  for (int i = 0; i < messages.length; i++) {
    mappedMessage.add(messages[i].toMap());
  }
  http.Client client = http.Client();
  http.Request request = http.Request(
      "POST", Uri.parse("https://chatflowai.onrender.com/api/v1/generate_response"));

  request.headers['Accept'] = "text/event-stream";
  request.headers["Cache-Control"] = "no-cache";
  request.headers['Content-Type'] = "application/json";

  request.body = jsonEncode({"messages": mappedMessage});
   
  final response = await client.send(request);
  
  // Add error handling
  if (response.statusCode != 200) {
    yield http.Response('Error: ${response.statusCode}', response.statusCode);
    return;
  }

  // Modify the stream transformation
  yield* response.stream
    .transform(utf8.decoder)
    .transform(const LineSplitter())
    .where((line) => line.trim().isNotEmpty)
    .map((line) {
      if (line.startsWith('data: ')) {
        line = line.substring(6);
      }
      try {
        Map<String, dynamic> data = jsonDecode(line);
        return http.Response(jsonEncode(data), response.statusCode,
            headers: response.headers);
      } catch (e) {
        print('Error decoding JSON: $e');
        return http.Response('Error decoding JSON', 500);
      }
    });
}

// Stream<http.Response> getChatGptResponseRepo(List<ChatMessageModel> messages) async* {
// Defines a function getChatGptResponseRepo that takes a list of ChatMessageModel objects as input.
// The function returns a stream (Stream<http.Response>), which will continuously provide HTTP responses.
// async* is used to create an asynchronous generator, meaning it can yield values over time in a non-blocking manner.
// List<Map> mappedMessage = [];
// for (int i = 0; i < messages.length; i++) {
//   mappedMessage.add(messages[i].toMap());
// }
// mappedMessage is initialized as an empty list that will store the chat messages in map format.
// The loop iterates over each ChatMessageModel in the messages list, converts each message to a map using the toMap() method, and adds the map to mappedMessage.
// http.Client client = http.Client();
// http.Request request = http.Request(
//     "POST", Uri.parse("https://chatflowai.onrender.com/api/v1/generate_response"));
// client: Creates an instance of http.Client, which will be used to send HTTP requests.
// request: Defines an HTTP POST request targeting the specified URL (a server endpoint to generate responses).
// Sets the headers for the request:
// Accept: text/event-stream: Specifies that the response will be an event stream.
// Cache-Control: no-cache: Ensures the client doesn't cache the response.
// Content-Type: application/json: Indicates the content type of the request body is JSON.
// request.body = jsonEncode({"messages": mappedMessage});
Encodes //the mappedMessage list (which contains the mapped chat messages) into JSON format and sets it as the request body.