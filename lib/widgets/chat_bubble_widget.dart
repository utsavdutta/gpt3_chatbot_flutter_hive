import 'package:flutter/material.dart';
import 'package:flutter_firebase_login_bloc/models/chat_hive_model.dart';

class ChatBubble extends StatelessWidget {
    final ChatHiveModel chat;
  const ChatBubble({
    Key? key,
    required this.chat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
    // add some padding
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Align(
      // align the child within the container
      alignment: chat.isHuman ? Alignment.centerRight : Alignment.centerLeft,
      child: DecoratedBox(
        // chat bubble decoration
        decoration: BoxDecoration(
          color: chat.isHuman ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            chat.chat,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: chat.isHuman ? Colors.white : Colors.black87),
          ),
        ),
      ),
    ),
  );
  }
}
