import 'dart:convert'; // son.encode() and json.decode() functions in the code to handle JSON data.

class ChatMessageModel {
  final String role;
  final String content;

  ChatMessageModel({required this.role, required this.content});

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'content': content,
    };
  }

  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      role: map['role'] ?? '',
      content: map['content'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessageModel.fromJson(String source) => ChatMessageModel.fromMap(json.decode(source));
  // This factory constructor creates an instance of ChatMessageModel from a JSON string.
It uses json.decode() to convert the JSON string into a map.
Then it calls the fromMap() constructor to create a ChatMessageModel object from the decoded map.
}

// This factory constructor creates an instance of ChatMessageModel from a map.
//factory indicates that this is a factory constructor, which means it can return an instance of ChatMessageModel based on some input (in this case, a map).
