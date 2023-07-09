import 'package:flutter_chatgpt_completions/src/chatgpt/models/chat_message.dart';
import 'package:flutter_chatgpt_completions/src/chatgpt/logic/chatgpt_chat.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';

import '../../../consts.dart';

main() {
  const apiKey = kWriteYourChatGPTAPIToken;
  test('chat gpt test', () async {
    String model = 'gpt-3.5-turbo';
    String prompt = 'It is test. Please say, "Hello, ChatGPT."';

    Dio dio = Dio();
    dio.options.headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey"
    };

    try {
      Response response = await dio.post(
        "https://api.openai.com/v1/chat/completions",
        data: {
          "model": model,
          "messages": [
            {"role": "user", "content": prompt}
          ],
          "max_tokens": 1024,
          "temperature": 0.5,
        },
      );

      String message = response.data["choices"][0]["message"]["content"];
      expect(message, 'Hello, ChatGPT.');
    } catch (e) {
      print(e);
    }
  });

  test('setting', () async {
    String model = 'gpt-3.5-turbo';

    Dio dio = Dio();
    dio.options.headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey"
    };

    try {
      Response response = await dio.post(
        "https://api.openai.com/v1/chat/completions",
        data: {
          "model": model,
          "messages": [
            {"role": "system", "content": 'Role as Flutter engneer'},
            {
              "role": "user",
              "content": 'What is good language for app development for iPhone?'
            },
          ],
          "max_tokens": 1024,
          "temperature": 0.5,
        },
      );

      final message = response.data["choices"][0]["message"]["content"];
      print(message);
    } catch (e) {
      print(e);
    }
  });

  test('chat gpt test with class', () async {
    final chatGpt = ChatGPTChat(kWriteYourChatGPTAPIToken);
    String messageForChatGPT = 'This is test. Say just "Hello!"';
    final response = await chatGpt.ask(ChatMessage.user(messageForChatGPT));
    expect(response.content, 'Hello!');
  });

  test('chag gpt history', () async {
    final chatGpt = ChatGPTChat(kWriteYourChatGPTAPIToken, setting: 'setting');
    final result1 = chatGpt.getMessage(5);
    expect(result1.length, 1);
    expect(result1[0].content, 'setting');

    chatGpt.registerMessage(ChatMessage(Role.user, 'message1'),
        ChatMessage(Role.system, 'message2'));

    final result2 = chatGpt.getMessage(5);
    expect(result2.length, 3);
    expect(result2[0].content, 'setting');
    expect(result2[1].content, 'message1');
    expect(result2[2].content, 'message2');

    chatGpt.registerMessage(ChatMessage(Role.user, 'message3'),
        ChatMessage(Role.system, 'message4'));

    final result3 = chatGpt.getMessage(5);
    expect(result3.length, 5);
    expect(result3[0].content, 'setting');
    expect(result3[1].content, 'message1');
    expect(result3[2].content, 'message2');
    expect(result3[3].content, 'message3');
    expect(result3[4].content, 'message4');

    chatGpt.registerMessage(ChatMessage(Role.user, 'message5'),
        ChatMessage(Role.system, 'message6'));

    final result4 = chatGpt.getMessage(5);
    expect(result4.length, 5);
    expect(result4[0].content, 'setting');
    expect(result4[1].content, 'message3');
    expect(result4[2].content, 'message4');
    expect(result4[3].content, 'message5');
    expect(result4[4].content, 'message6');
  });
}
