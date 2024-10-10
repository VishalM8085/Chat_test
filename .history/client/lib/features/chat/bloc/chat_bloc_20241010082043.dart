import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<ChatNewPromptEvent>(_handleNewPrompt);
  }

  Future<void> _handleNewPrompt(
    ChatNewPromptEvent event,
    Emitter<ChatState> emit,
  ) {}
}
