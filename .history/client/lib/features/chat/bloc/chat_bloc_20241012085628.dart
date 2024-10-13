import 'dart:async';
//import 'dart:js_interop';

import 'package:bloc/bloc.dart';
import 'package:client/features/chat/models/chat_message_model.dart';
import 'package:client/features/chat/repositories/chat_repo.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<ChatNewPromptEvent>(chatNewPromptEvent);
  }

  // subscribe to the stream
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
     // emit(ChatNewMessageGeneratedState());
      _subscription?.cancel();
      _subscription = getChatGptResponseRepo(cachedMessage).listen((response) {
        print(response.toString());
        for (String line in response.body.split('\n')) {
          print(line);
        }
      });
    } catch (e) {
      print(e.toString());
      emit(ChatNewMessageGeneratingErrorState());
    }
  }
}


// 3. part 'chat_event.dart';
// This line indicates that the file chat_event.dart is part of this file (i.e., it is logically included). It contains the definition of all the events related to this ChatBloc. These events represent actions that the user or the app can trigger (e.g., sending a new prompt, loading more chat history).
// 4. part 'chat_state.dart';
// Similar to the chat_event.dart file, this line includes the chat_state.dart file. It contains the different states that the ChatBloc can emit, such as the initial state when the chat starts, loading states, success states, error states, etc.
// 5. class ChatBloc extends Bloc<ChatEvent, ChatState> {
// This defines the ChatBloc class, which extends the base Bloc class provided by the bloc package.
// The Bloc class takes two generic types:
// ChatEvent: This represents the different events that can happen in the chat (defined in chat_event.dart).
// ChatState: This represents the various states the chat can be in (defined in chat_state.dart).
// class ChatBloc extends Bloc<ChatEvent, ChatState> {
// This declares a ChatBloc class, which extends the Bloc class from the bloc package. ChatBloc is responsible for handling ChatEvents and producing ChatStates.
// ChatEvent represents various user actions, while ChatState represents the possible states of the chat.
// super(ChatInitial()): The initial state of the Bloc is set to ChatInitial(). This means when the bloc is first created, it will be in the ChatInitial state.
// on<ChatNewPromptEvent>(chatNewPromptEvent);
// Here, the bloc listens for a specific event: ChatNewPromptEvent.
// When this event is triggered, the chatNewPromptEvent method is called to handle the event.
// StreamSubscription<http.Response>? _subscription;
// Declares a nullable _subscription variable that will hold the stream subscription to HTTP responses (http.Response).
// It listens to the stream of responses from the chat API (in this case, ChatGPT) to dynamically update the app as the response is being generated.
// List<ChatMessageModel> cachedMessage = [];
//Declares a list cachedMessage of type ChatMessageModel. This list is used to store chat messages between the user and the chatbot.
//  Future<void> chatNewPromptEvent(
//     ChatNewPromptEvent event,
//     Emitter<ChatState> emit,
//   ) async {
// This is the method that gets called when a ChatNewPromptEvent is received.
// It is asynchronous (async) because it involves waiting for network responses and handling events in a non-blocking way.
// event holds the data for the chat prompt, and emit is used to emit new states for the bloc.
// Before starting the API request, the bloc emits a ChatNewMessageGeneratingLoadingState to indicate that the app is currently loading and waiting for a new chat response.
//  ChatMessageModel newMessage =
//           ChatMessageModel(role: 'user', content: event.prompt);
// A new ChatMessageModel instance is created, representing the user's message.
// role: 'user': This indicates that this message is from the user (as opposed to a message from the chatbot).
// content: event.prompt: The content of the message is the prompt that the user entered.
// _subscription?.cancel();
// Cancels any existing stream subscription to ensure that there is no active subscription before starting a new one.
// The ?. operator ensures that the cancellation only happens if _subscription is not null.
// _subscription = getChatGptResponseRepo(cachedMessage).listen((response) {
// Starts a new stream subscription by calling getChatGptResponseRepo(cachedMessage).
// This method presumably sends the cached messages (including the new user prompt) to the ChatGPT API and listens for the response in real time.
// The listen() method subscribes to the response stream, and the provided callback function will handle each response chunk received.