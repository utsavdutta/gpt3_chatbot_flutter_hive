import 'dart:convert';
import 'package:flutter_firebase_login_bloc/exceptions/http_exception.dart';
import 'package:flutter_firebase_login_bloc/models/chat_hive_model.dart';
import 'package:flutter_firebase_login_bloc/services/http_error_handler.dart';
import 'package:http/http.dart' as http;

class OpenaiServiceApi {
  final http.Client httpClient;
  OpenaiServiceApi({
    required this.httpClient,
  });

  Future<ChatHiveModel> sendMessage(String prompt) async {
    try {
      http.Response response = await http.post(
          Uri.parse(
              "https://api.openai.com/v1/engines/text-babbage-001/completions"),
          headers: {
            "Authorization":
                "Bearer ${'secret key'}",
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "prompt": prompt,
            "max_tokens": 20,
            "temperature": 0.4,
          }));
      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      final responseBody = jsonDecode(response.body);
      if (responseBody.isEmpty) {
        throw HttpException('Cannot get the response of $prompt');
      }
      final liliyaResponse = ChatHiveModel.fromJson(responseBody);
      return liliyaResponse;
    } catch (e) {
      rethrow;
    }
  }
}
