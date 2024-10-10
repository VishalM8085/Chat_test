// network function will be here
import 'package:http/http.dart' as http;
import 'package:client/features/chat/models/chat_message_model.dart';

Stream<http.Response> getChatGptResponse(
    List<ChatMessageModel> messages) async* {
  List<Map> mappedMessage = [];
  for(int i=0;i<messages,)
}
