part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}


class ChatNewPromptEvent extends ChatEvent {
  final String prompt;

  ChatNewPromptEvent({required this.prompt});

}