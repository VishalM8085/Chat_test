import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<ChatNewPromptEventt>(ChatNewPromptEvent);
  }
  Future<void> ChatNewPromptEvent (
    ChatNewPromptEventt event, Emitter<C
  )
}
