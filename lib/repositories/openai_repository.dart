import 'package:flutter_firebase_login_bloc/models/chat_hive_model.dart';
import 'package:flutter_firebase_login_bloc/models/custom_error.dart';
import 'package:flutter_firebase_login_bloc/services/open_ai_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OpenAiRepository {
  final OpenaiServiceApi openaiServiceApi;
  OpenAiRepository({
    required this.openaiServiceApi,
  });

  Future<void> chatPrompt(String message) async {
    Hive.box('chats').add(ChatHiveModel(chat: message, isHuman: true));
    try {
      openaiServiceApi.sendMessage(message).then((liliyaRes) => Hive.box('chats')
          .add(
              ChatHiveModel(chat: liliyaRes.chat, isHuman: false)));
    } catch (e) {
      throw CustomError(message: e.toString());
    }
  }
}
