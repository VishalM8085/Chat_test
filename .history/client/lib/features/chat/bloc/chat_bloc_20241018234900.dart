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


