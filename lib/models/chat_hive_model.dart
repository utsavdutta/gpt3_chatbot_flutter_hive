import 'dart:convert';

import 'package:hive/hive.dart';

part 'chat_hive_model.g.dart';

@HiveType(typeId: 0)
class ChatHiveModel extends HiveObject {
  @HiveField(0)
  final String chat;
  @HiveField(1)
  final bool isHuman;
  ChatHiveModel({
    required this.chat,
    required this.isHuman,
  });

  @override
  String toString() => 'ChatHiveModel(chat: $chat, isHuman: $isHuman)';

   factory ChatHiveModel.fromJson(Map<String, dynamic> json) {
    return ChatHiveModel(chat: json["choices"][0]["text"], isHuman: false);
  }
}
