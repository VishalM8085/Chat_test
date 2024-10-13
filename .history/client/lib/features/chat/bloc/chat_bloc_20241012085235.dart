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
