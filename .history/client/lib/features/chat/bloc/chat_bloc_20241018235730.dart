import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chatflowai/features/chat/models/chat_message_model.dart';
import 'package:chatflowai/features/chat/repositories/chat_repo.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<ChatNewPromptEvent>(chatNewPromptEvent);
    on<ChatNewContentGeneratedEvent>(chatNewContentGeneratedEvent);
  }

  StreamSubscription<http.Response>? _subscription;
  List<ChatMessageModel> cachedMessage = [];

  Future<void> chatNewPromptEvent(
    ChatNewPromptEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatNewMessageGeneratingLoadingState());
    try {
      ChatMessageModel newMessage =
          ChatMessageModel(role: 'user', content: event.prompt);
      cachedMessage.add(newMessage);
      emit(ChatNewMessageGeneratedState());
      cachedMessage.add(ChatMessageModel(role: 'assistant', content: ""));
      _subscription?.cancel();
      _subscription = getChatGptResponseRepo(cachedMessage).listen(
        (response) {
          if (response.statusCode == 200) {
            try {
              Map<String, dynamic> data = jsonDecode(response.body);
              if (data.containsKey('data')) {
                add(ChatNewContentGeneratedEvent(content: data['data']));
              } else {
                print('Response does not contain "data" key: $data');
              }
            } catch (e) {
              print('Error processing response: $e');
              emit(ChatNewMessageGeneratingErrorState());
            }
          } else {
            print('Error response: ${response.statusCode} - ${response.body}');
            emit(ChatNewMessageGeneratingErrorState());
          }
        },
        onError: (error) {
          print('Stream error: $error');
          emit(ChatNewMessageGeneratingErrorState());
        },
      );
    } catch (e) {
      print('Error in chatNewPromptEvent: ${e.toString()}');
      emit(ChatNewMessageGeneratingErrorState());
    }
  }

  FutureOr<void> chatNewContentGeneratedEvent(
      ChatNewContentGeneratedEvent event, Emitter<ChatState> emit) {
    if (cachedMessage.isNotEmpty) {
      ChatMessageModel modelMessage = cachedMessage.last;
      String content = event.content;
      cachedMessage.last = ChatMessageModel(
          role: 'assistant', content: modelMessage.content + content);
      
      emit(ChatNewMessageGeneratedState());
    } else {
      print('Error: cachedMessage is empty');
      emit(ChatNewMessageGeneratingErrorState());
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
// class ChatBloc extends Bloc<ChatEvent, ChatState> {
//class ChatBloc extends Bloc<ChatEvent, ChatState>: Defines the ChatBloc class, which extends the BLoC class. It takes ChatEvent as the input event type and ChatState as the output state type.
// ChatBloc() : super(ChatInitial()) {
//     on<ChatNewPromptEvent>(chatNewPromptEvent);
//     on<ChatNewContentGeneratedEvent>(chatNewContentGeneratedEvent);
//   }
// ChatBloc() : super(ChatInitial()): Calls the parent constructor with an initial state of ChatInitial(), indicating that the chat has just started.
// on<ChatNewPromptEvent>(chatNewPromptEvent);: Registers a handler for the ChatNewPromptEvent which calls the chatNewPromptEvent method.
// on<ChatNewContentGeneratedEvent>(chatNewContentGeneratedEvent);: Registers a handler for the ChatNewContentGeneratedEvent which calls the chatNewContentGeneratedEvent method.
// StreamSubscription<http.Response>? _subscription;
//   List<ChatMessageModel> cachedMessage = [];
// StreamSubscription<http.Response>? _subscription;: A nullable variable to hold the subscription to the HTTP response stream.
// List<ChatMessageModel> cachedMessage = [];: Initializes an empty list to cache chat messages.
// Future<void> chatNewPromptEvent(
//     ChatNewPromptEvent event,
//     Emitter<ChatState> emit,
//   ) async {
// Future<void> chatNewPromptEvent(...): Defines a method to handle new prompt events, taking the event and an Emitter to emit new states.
// Future<void> is a type that represents a computation that will complete in the future and does not return a value upon completion.
//  emit(ChatNewMessageGeneratingLoadingState());
// emit(ChatNewMessageGeneratingLoadingState());: Emits a loading state indicating that a new message is being generated.
// Try-Catch Block for Message Generation

//     try {
// try {: Starts a try-catch block to handle exceptions during message processing.
// Create and Cache New User Message

//       ChatMessageModel newMessage =
//           ChatMessageModel(role: 'user', content: event.prompt);
//       cachedMessage.add(newMessage);
//       emit(ChatNewMessageGeneratedState());
// ChatMessageModel newMessage = ...: Creates a new chat message model for the user, initializing it with the role 'user' and content from the event prompt.
// cachedMessage.add(newMessage);: Adds the new user message to the cached message list.
// emit(ChatNewMessageGeneratedState());: Emits a state indicating that a new user message has been generated.
// Add Assistant Placeholder

//       cachedMessage.add(ChatMessageModel(role: 'assistant', content: ""));
// cachedMessage.add(...): Adds a placeholder for the assistant's response to the cached messages, initially empty.
// Cancel Previous Subscription

//       _subscription?.cancel();
// _subscription?.cancel();: Cancels any existing subscription to avoid multiple active streams.
// Start New Subscription to Response Stream

//       _subscription = getChatGptResponseRepo(cachedMessage).listen(
// _subscription = getChatGptResponseRepo(cachedMessage).listen(...): Starts listening to the HTTP response stream returned by getChatGptResponseRepo, passing the cached messages as input.
// Handling Response

//         (response) {
// (response) {: Defines a callback for processing each incoming response.
// Check for Successful Response

//           if (response.statusCode == 200) {
// if (response.statusCode == 200) {: Checks if the response status code indicates success (HTTP 200).
// Decode and Process JSON Response

//             try {
//               Map<String, dynamic> data = jsonDecode(response.body);
//               if (data.containsKey('data')) {
//                 add(ChatNewContentGeneratedEvent(content: data['data']));
//               } else {
//                 print('Response does not contain "data" key: $data');
//               }
//             } catch (e) {
//               print('Error processing response: $e');
//               emit(ChatNewMessageGeneratingErrorState());
//             }
// try { ... }: Starts a nested try-catch to handle any exceptions while processing the response.
// Map<String, dynamic> data = jsonDecode(response.body);: Decodes the JSON body of the response into a Dart map.
// if (data.containsKey('data')) { ... }: Checks if the decoded data contains the key 'data'.
// add(ChatNewContentGeneratedEvent(content: data['data']));: If the key exists, triggers the ChatNewContentGeneratedEvent to handle the new content.
// print(...): Logs an error message if the key doesn't exist.
// catch (e) { ... }: Catches and logs any exceptions during the JSON decoding, and emits an error state.
// FutureOr<void> chatNewContentGeneratedEvent(
//       ChatNewContentGeneratedEvent event, Emitter<ChatState> emit) {
// FutureOr<void> chatNewContentGeneratedEvent(...): Defines a method to handle content generated events, taking the event and an Emitter.
//In Dart, FutureOr<void> is a type that represents either a Future<void> or a void. This allows for more flexibility in asynchronous programming, particularly when you want to indicate that a function may either perform an asynchronous operation or complete synchronously.
// if (cachedMessage.isNotEmpty) {
Check if cachedMessage is not empty:
This line checks whether the cachedMessage list contains any ChatMessageModel instances. If the list is not empty, it proceeds with the block of code inside the if statement.
dart
Copy code
  ChatMessageModel modelMessage = cachedMessage.last;
Retrieve the last message:
If the list is not empty, this line retrieves the last ChatMessageModel from the cachedMessage list and assigns it to modelMessage. The last property of the list gives you the last element in the list.
dart
Copy code
  String content = event.content;
Get the new content:
This line extracts the content property from the event (which is of type ChatNewContentGeneratedEvent) and assigns it to the content variable. This is the new message that has been generated by the assistant (i.e., the response from ChatGPT).
dart
Copy code
  cachedMessage.last = ChatMessageModel(
      role: 'assistant', content: modelMessage.content + content);
Update the last message:
This line updates the last message in the cachedMessage list to a new ChatMessageModel.
It sets the role to 'assistant', indicating that this message is from the assistant (e.g., ChatGPT).
For the content, it concatenates the previous content of the last message (modelMessage.content) with the new content from the event. This way, if there were multiple parts in the response from the assistant, all parts will be combined into a single message.
dart
Copy code
  emit(ChatNewMessageGeneratedState());
Emit a new state:
After updating the last message in cachedMessage, this line emits a new state, ChatNewMessageGeneratedState, which indicates that a new message has been successfully generated and added to the chat.