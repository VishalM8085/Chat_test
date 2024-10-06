import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<ChatNewPromptEvent>(_handleNewPromptt);
  }

  Future<void> _handleNewPrompt(
    ChatNewPromptEvent event,
    Emitter<ChatState> emit,
  ) async {
    // Add your logic here
    // For example:
    // emit(ChatLoading());
    // try {
    //   // Process the prompt
    //   // emit(ChatSuccess(response));
    // } catch (e) {
    //   emit(ChatError(e.toString()));
    // }
  }
}