import 'package:flutter_chatgpt_completions/src/chatgpt/models/chat_message.dart';
import 'package:flutter_chatgpt_completions/src/chatgpt/models/value_objects.dart';

class UserChatMessage extends ChatMessage {
  UserChatMessage(
    String content, {
    this.maxTokens = const MaxTokens(1024),
    this.temperature = const Temperature(1),
  }) : super.user(content);

  final MaxTokens maxTokens;
  final Temperature temperature;
}
