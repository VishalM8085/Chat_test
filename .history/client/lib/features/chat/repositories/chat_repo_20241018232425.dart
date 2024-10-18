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
//Encodes the mappedMessage list (which contains the mapped chat messages) into JSON format and sets it as the request body.
// final response = await client.send(request);
// Sends the HTTP request using client.send(request) and awaits the response. This response will be a stream of data (since the endpoint returns text/event-stream).
//  yield* response.stream
// This line yields each value from the response stream, allowing the function to continue sending values as they come in from the server. The response.stream is a continuous flow of data (because the server is sending it as a text/event-stream). This means you are reading the response as it is being sent, piece by piece, instead of waiting for the entire response to be available.

// response.stream: This is a stream of bytes from the HTTP response body. Since the server is sending data over time (not all at once), we work with it as a stream.
// 2. .transform(utf8.decoder)
// This line converts the raw stream of bytes (which is what response.stream is) into readable UTF-8 characters (text). Since the server is sending data in text form, it needs to be decoded from bytes to a string.

// utf8.decoder: This transformer takes the stream of bytes and decodes it into a stream of characters (a string in UTF-8 format).
// 3. .transform(const LineSplitter())
// Once the raw bytes are decoded into text, this line splits the text into individual lines. Event streams (like text/event-stream) often send each piece of data as a line of text, with one piece of information on each line.

// LineSplitter(): This transformer splits the decoded text into lines. Each line represents a single event or piece of data sent by the server.
// 4. .where((line) => line.trim().isNotEmpty)
// Now that we have a stream of lines, this line filters out any empty lines. The text/event-stream format sometimes includes extra empty lines, and we don't want to process those.

// where((line) => line.trim().isNotEmpty): This filters the lines so only lines that are not empty (after trimming whitespace) are passed on. If a line contains only spaces or is empty, it is discarded.
// 5. .map((line) { if (line.startsWith('data: ')) { line = line.substring(6); }
// This line processes each line that was not filtered out, transforming it if it starts with the string data: .

// .map((line) {...}): The map function takes each line (which is not empty) and applies a transformation.
// if (line.startsWith('data: ')): This checks if the line starts with the prefix data: , which is common in event-stream responses (the data of each event is often prefixed by data: ).
// line = line.substring(6): If the line starts with data: , this removes that prefix. The substring(6) takes everything after the first 6 characters (which skips over data: ). This ensures that you’re left with the actual content of the line, without the prefix.
// try {
  Map<String, dynamic> data = jsonDecode(line);
  return http.Response(jsonEncode(data), response.statusCode, headers: response.headers);
} catch (e) {
  print('Error decoding JSON: $e');
  return http.Response('Error decoding JSON', 500);
}
Tries to decode the line into a JSON object using jsonDecode.
If successful, the JSON object is encoded back into a string (jsonEncode(data)) and returned in an http.Response object along with the status code and headers.
If an error occurs during JSON decoding, it catches the exception and yields an error response with status code 500.