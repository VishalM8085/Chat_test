import 'dart:async';
import 'dart:js_interop';

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
     ChatMessageModel newMessage = ChatMessageModel(role: 'user', content: event.prompt);
      cachedMessage.add(newMessage)
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
// 6. ChatBloc() : super(ChatInitial()) {
// The ChatBloc constructor is called when a ChatBloc object is created.
// super(ChatInitial()) initializes the BLoC with an initial state, ChatInitial. This is the default state when the BLoC is first instantiated. ChatInitial is one of the states defined in chat_state.dart.
// The BLoC starts in the ChatInitial state until it receives an event that triggers a state change.
// 7. on<ChatNewPromptEvent>(_handleNewPrompt);
// This line sets up an event handler for the ChatNewPromptEvent. The on<T> method is used to register a handler for a specific event type (ChatNewPromptEvent in this case).
// When a ChatNewPromptEvent is dispatched (triggered), the _handleNewPrompt method is called to process this event.
// This is a core feature of the BLoC pattern, which responds to events by transitioning to new states.
// 8. Future<void> _handleNewPrompt(
// This is the start of a method definition that handles the ChatNewPromptEvent. It is marked as Future<void>, meaning it performs an asynchronous operation but does not return any value.
// The leading underscore (_) makes this method private to the ChatBloc class, so it can't be accessed from outside the class.
// 9. ChatNewPromptEvent event,
// The first parameter of the _handleNewPrompt method is the event itself. This is the event object containing the data or context needed to process this specific action (e.g., the new prompt the user entered).
// 10. Emitter<ChatState> emit,
// The second parameter is an Emitter<ChatState>. This is provided by the BLoC framework and allows the function to emit new states. When a new state is emitted using emit(), the BLoC's state is updated, and the UI (or whatever listens to the BLoC) is notified.
// You will use emit to transition the BLoC to new states based on the event's logic.
// 11. ) async {}
// This closes the method signature and denotes that the method is asynchronous. It will likely perform asynchronous operations (like API calls or database queries) in the future, but currently, it's an empty function.
// Inside this function, you will implement the actual logic that handles what happens when a ChatNewPromptEvent is dispatched.