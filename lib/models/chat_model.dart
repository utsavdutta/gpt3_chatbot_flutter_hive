import 'package:equatable/equatable.dart';

class Chat extends Equatable {
  final String message;
  final bool isHuman;
  const Chat({
    required this.message,
    this.isHuman = false,
  });

  factory Chat.initial() =>
      const Chat(message: 'How can i help you', isHuman: false);

  Map<String, dynamic> toMap() {
    return {'message': message, 'isHuman': isHuman};
  }

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(message: json["choices"][0]["text"], isHuman: false);
  }

  Chat copyWith({
    String? message,
    bool? isHuman,
  }) {
    return Chat(
      message: message ?? this.message,
      isHuman: isHuman ?? this.isHuman,
    );
  }

  @override
  String toString() => 'Chat(message: $message, isHuman: $isHuman)';

  @override
  List<Object> get props => [message, isHuman];
}
