// To parse this JSON data, do
//
//     final conversationModel = conversationModelFromJson(jsonString);

import 'dart:convert';

ConversationModel conversationModelFromJson(String str) => ConversationModel.fromJson(json.decode(str));

String conversationModelToJson(ConversationModel data) => json.encode(data.toJson());

class ConversationModel {
  int id;
  int articleId;
  int userId;

  ConversationModel({
    required this.id,
    required this.articleId,
    required this.userId,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) => ConversationModel(
    id: json["id"],
    articleId: json["article_id"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "article_id": articleId,
    "user_id": userId,
  };
}

