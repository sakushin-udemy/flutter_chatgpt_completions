import 'package:flutter_chatgpt_completions/src/chatgpt/models/chat_data.dart';
import 'package:flutter_chatgpt_completions/src/chatgpt/models/chat_message.dart';
import 'package:flutter_chatgpt_completions/src/chatgpt/logic/chatgpt_chat.dart';

import 'package:flutter_chatgpt_completions/src/chatgpt/models/value_objects.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ChatData toJson and fromJson', () {
    final chatData = ChatData(
      model: Model.gtp35Turbo,
      messages: [
        ChatMessage(Role.system, 'Welcome to ChatGPT!'),
        ChatMessage(Role.user, 'What is the capital of France?'),
        ChatMessage(Role.assistant, 'The capital of France is Paris.'),
      ],
      maxTokens: MaxTokens(100),
      temperature: Temperature(0.8),
    );

    final chatDataJson = chatData.toJson();

    final chatDataFromJson = ChatData.fromJson(chatDataJson);

    expect(chatDataFromJson.model, Model.gtp35Turbo);
    expect(chatDataFromJson.messages[0].role, Role.system);
    expect(chatDataFromJson.messages[0].content, 'Welcome to ChatGPT!');
    expect(chatDataFromJson.messages[1].role, Role.user);
    expect(
        chatDataFromJson.messages[1].content, 'What is the capital of France?');
    expect(chatDataFromJson.messages[2].role, Role.assistant);
    expect(chatDataFromJson.messages[2].content,
        'The capital of France is Paris.');
    expect(chatDataFromJson.maxTokens.maxTokens, 100);
    expect(chatDataFromJson.temperature.temperature, 0.8);
  });

  test('ChatData direct member access', () {
    final chatData = ChatData(
      model: Model.gtp35Turbo,
      messages: [
        ChatMessage(Role.system, 'Welcome to ChatGPT!'),
        ChatMessage(Role.user, 'What is the capital of Japan?'),
        ChatMessage(Role.assistant, 'The capital of Japan is Tokyo.'),
      ],
      maxTokens: MaxTokens(150),
      temperature: Temperature(0.6),
    );

    expect(chatData.model, Model.gtp35Turbo);
    expect(chatData.messages[0].role, Role.system);
    expect(chatData.messages[0].content, 'Welcome to ChatGPT!');
    expect(chatData.messages[1].role, Role.user);
    expect(chatData.messages[1].content, 'What is the capital of Japan?');
    expect(chatData.messages[2].role, Role.assistant);
    expect(chatData.messages[2].content, 'The capital of Japan is Tokyo.');
    expect(chatData.maxTokens.maxTokens, 150);
    expect(chatData.temperature.temperature, 0.6);
  });

  test('Test with actual data used', () {
    final json = {
      "model": 'gpt-3.5-turbo',
      "messages": [
        {
          "role": "system",
          "content": 'あなたはChatbotとして、ロールプレイを行います。',
        },
        {"role": "user", "content": '俺は俺の責務を全うしないといけませんか'},
      ],
      "max_tokens": 1024,
      "temperature": 0.5,
    };

    final chatData = ChatData.fromJson(json);
    expect(chatData.model, Model.gtp35Turbo);
    expect(chatData.messages[0].role, Role.system);
    expect(chatData.messages[0].content, 'あなたはChatbotとして、ロールプレイを行います。');
    expect(chatData.messages[1].role, Role.user);
    expect(chatData.messages[1].content, '俺は俺の責務を全うしないといけませんか');
    expect(chatData.maxTokens.maxTokens, 1024);
    expect(chatData.temperature.temperature, 0.5);

    expect(chatData.toJson(), json);
  });
}
