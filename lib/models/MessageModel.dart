import 'dart:convert';

import 'package:dash_chat_2/dash_chat_2.dart';

MessageModel messageModelFromJson(String str) => MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  int? id;
  int? conversation_id;
  String? content;
  int? user_id;

  MessageModel({
    this.id,
    this.conversation_id,
    this.content,
    this.user_id,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    id: json["id"],
    conversation_id: json["conversation_id"],
    content: json["content"],
    user_id: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "conversation_id": conversation_id,
    "content": content,
    "user_id":user_id,
  };
  ChatMessage toChatMessage() {
    return ChatMessage(
      text: '${this.content}',
      user: ChatUser(
        id: '${this.user_id}',
        firstName: '',
        lastName: '',
        profileImage: '',
      ),
      createdAt: DateTime.now(),
    );
  }
}




