part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

class ChatNewMessageGeneratingLoadingState extends ChatState {}
class ChatNewMessageGeneratingEState extends ChatState {}