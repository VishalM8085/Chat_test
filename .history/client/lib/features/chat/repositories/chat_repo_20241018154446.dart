// network function will be here
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chatflowai/features/chat/models/chat_message_model.dart';

class ChatRepo {
  final String apiUrl = 'https://your-api-endpoint.com/chat';
  final String apiKey = 'your-api-key';

 st Stream<String> getChatGptResponseRepo(List<ChatMessageModel> messages) async* {
    final request = http.Request('POST', Uri.parse(apiUrl));
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    });

    final body = jsonEncode({
      'messages': messages.map((m) => m.toJson()).toList(),
      'stream': true,
    });
    request.body = body;

    final response = await http.Client().send(request);
    String buffer = '';

    await for (var chunk in response.stream.transform(utf8.decoder)) {
      buffer += chunk;
      while (buffer.contains('\n')) {
        final index = buffer.indexOf('\n');
        final line = buffer.substring(0, index);
        buffer = buffer.substring(index + 1);

        if (line.startsWith('data: ')) {
          final jsonStr = line.substring(6);
          if (jsonStr.trim().isNotEmpty) {
            try {
              final json = jsonDecode(jsonStr);
              if (json['data'] != null) {
                yield json['data'].toString();
              }
            } catch (e) {
              print('Error parsing JSON: $e');
              print('Problematic line: $line');
            }
          }
        }
      }
    }
  }
}
// Stream<http.Response> getChatGptResponseRepo(
//     List<ChatMessageModel> messages) async* {
//   List<Map> mappedMessage = [];
//   for (int i = 0; i < messages.length; i++) {
//     mappedMessage.add(messages[i].toMap());
//   }
//   http.Client client = http.Client();
//   http.Request request = http.Request(
//       "POST", Uri.parse("https://chatflowai.onrender.com/api/v1/generate_response"));

//   request.headers['Accept'] = "text/event-stream";
//   request.headers["Cache-Control"] = "no-cache";
//   request.headers['Content-Type'] = "application/json";

//   request.body = jsonEncode({"messages": mappedMessage});

//   final response = await client.send(request);
//   Stream<http.Response> mappedStream =
//       response.stream.transform(Utf8Decoder()).map((jsonData) {
//     return http.Response(jsonData, response.statusCode,
//         headers: response.headers);
//   });
//   yield* mappedStream;
// }

// This defines a function called getChatGptResponse.
// It returns a Stream of http.Response objects, which allows you to handle a sequence of HTTP responses asynchronously over time.

// A Stream is like an asynchronous sequence of events, useful when you are receiving data bit by bit.
//The async* indicates that this function is an asynchronous generator. Instead of returning a single result, it can yield multiple values over time (in this case, HTTP responses), making it useful for streaming data.

// http.Response is the object that contains the data returned by the server in response to an HTTP request. You use it to read the server's response, like body, headers, or status code.
//http.Client is a reusable HTTP client that allows you to send multiple requests efficiently, providing more control over the request process and resource management (such as connection pooling).

// In Dart, final is a keyword used to declare a variable that can only be set once. Once a variable is assigned a value using final, it cannot be reassigned to a different value. This makes final a useful tool for creating immutable variables, which can help prevent unintended changes to data and enhance code readability and maintainability.


// http.Client client = http.Client();
// Purpose: This line creates a new instance of http.Client, which is used to send HTTP requests and receive responses.
// Usage: The client will handle the underlying network operations for making requests.
// http.Request request = http.Request(
//     "POST", Uri.parse("http://localhost:3000/api/v1/generate_response"));
// Purpose: This line creates a new HTTP request.
// Parameters:
// "POST": The HTTP method for the request, indicating that you're sending data to the server.
// Uri.parse("http://localhost:3000/api/v1/generate_response"): This constructs a Uri object from the provided string, representing the endpoint you are trying to access.
// Usage: The request object will carry the details of the HTTP request, including the method, URL, headers, and body (if any).
// request.headers['Accept'] = "text/event-stream";
// Purpose: This line sets the Accept header of the request.
// Header Value: "text/event-stream" indicates that the client expects to receive data in a streaming format (often used for server-sent events).
// Usage: This header tells the server what kind of data the client is willing to accept in the response.
// request.headers["Cache-Control"] = "no-cache";
// Purpose: This sets the Cache-Control header of the request.
// Header Value: "no-cache" instructs the server not to use cached data and to fetch a fresh response.
// Usage: This can be important when you want to ensure that the data you receive is the most current version.

// request.headers['Content-Type'] = "application/json";
// Purpose: This line sets the Content-Type header of the request.
// Header Value: "application/json" indicates that the body of the request (if present) will be in JSON format.
// Usage: This informs the server about the type of data being sent, which is essential for correct parsing on the server side.

// final response = await client.send(request);
// Purpose: This line sends the HTTP request using the client and waits for the response asynchronously.
// Usage: The await keyword is used because sending the request is an asynchronous operation, meaning the code will pause here until the request completes.
// Response Type: The result is stored in the response variable, which is an instance of StreamedResponse.

// Stream<http.Response> mappedStream =
//     response.stream.transform(Utf8Decoder()).map((jsonData) {
//   return http.Response(jsonData, response.statusCode,
//       headers: response.headers);
// });
// Purpose: This block processes the streamed response data.
// Explanation:
// response.stream: This gets the stream of data from the StreamedResponse.
// .transform(Utf8Decoder()): This decodes the byte stream into a UTF-8 string. It transforms the incoming byte stream into a string format.
// .map((jsonData) { ... }): This applies a transformation function to each piece of data emitted by the stream.
// Inside the map function:
// http.Response(jsonData, response.statusCode, headers: response.headers): Creates a new http.Response object using the decoded JSON data, the status code from the original response, and the headers from the original response.
// Usage: The mappedStream variable now holds a stream of http.Response objects, which are the decoded responses.

// yield* mappedStream;
// Purpose: This line yields each response from the mappedStream to the caller of the Stream function.
// Usage: The yield* operator allows you to yield all the elements from another stream, making it possible to emit multiple responses one after the other.

// response.stream.transform(Utf8Decoder())
// If you were to return the raw stream or the transformed data directly (e.g., the result of response.stream.transform(Utf8Decoder())), you would be returning a stream of strings instead of a stream of http.Response objects.
//This would limit what you can do with the data later on since the calling code would have to deal with strings instead of fully formed response objects.

// response.stream.transform(Utf8Decoder()).map((jsonData) {
    // return http.Response(jsonData, response.statusCode,
    //     headers: response.headers);
// Detailed Breakdown
// Stream of Raw Bytes:

// When you receive a response from an HTTP request, the body of the response is typically in the form of raw bytes. This is what response.stream contains initially.
// Transforming Bytes to Strings:

// The transform(Utf8Decoder()) function converts these raw bytes into strings, using UTF-8 encoding. This transformation allows you to work with the data in a human-readable format (e.g., JSON).
// Mapping Each String to http.Response:

// The map((jsonData) { ... }) function is where you define how to handle each of these strings. Here’s what happens:
// Each string produced by the Utf8Decoder is passed to the callback function, where it is represented by the variable jsonData.
// Inside the callback, you create an http.Response object using this string as the body of the response.

// You're reconstructing a new http.Response because the original response is in a stream, and once you've processed (read) the stream, you can't reuse the original response object as is. 
//Therefore, you're essentially repackaging the body (jsonData) and combining it with the status code and headers from the original response to create a new, easily usable http.Response object for downstream use in your app.