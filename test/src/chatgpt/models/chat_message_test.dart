import 'package:flutter_chatgpt_completions/src/chatgpt/models/chat_message.dart';
import 'package:flutter_chatgpt_completions/src/chatgpt/models/chat_response.dart';
import 'package:flutter_chatgpt_completions/src/chatgpt/logic/chatgpt_chat.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test ChatResponse without JSON conversion', () {
    final usage =
        Usage(promptTokens: 567, completionTokens: 192, totalTokens: 759);
    final message = ChatMessage(Role.assistant, 'Test content');
    final choice = Choice(message: message, finishReason: 'stop', index: 0);
    final chatResponse = ChatResponse(
      id: 'chatcmpl-712VAFlwVFObwBpRytaSzyqfAu69Y',
      object: 'chat.completion',
      created: 1680482300,
      model: 'gpt-3.5-turbo-0301',
      usage: usage,
      choices: [choice],
    );

    expect(chatResponse.id, 'chatcmpl-712VAFlwVFObwBpRytaSzyqfAu69Y');
    expect(chatResponse.object, 'chat.completion');
    expect(chatResponse.created, 1680482300);
    expect(chatResponse.model, 'gpt-3.5-turbo-0301');
    expect(chatResponse.usage.promptTokens, 567);
    expect(chatResponse.usage.completionTokens, 192);
    expect(chatResponse.usage.totalTokens, 759);
    expect(chatResponse.choices.length, 1);
    expect(chatResponse.choices[0].message.role, Role.assistant);
    expect(chatResponse.choices[0].message.content, 'Test content');
    expect(chatResponse.choices[0].finishReason, 'stop');
    expect(chatResponse.choices[0].index, 0);
  });

  test('Test ChatResponse with JSON conversion', () {
    final json = {
      "id": 'chatcmpl-712VAFlwVFObwBpRytaSzyqfAu69Y',
      "object": 'chat.completion',
      "created": 1680482300,
      "model": 'gpt-3.5-turbo-0301',
      "usage": {
        "prompt_tokens": 567,
        "completion_tokens": 192,
        "total_tokens": 759
      },
      "choices": [
        {
          "message": {"role": 'assistant', "content": 'Test content'},
          "finish_reason": 'stop',
          "index": 0
        }
      ]
    };

    final chatResponse = ChatResponse.fromJson(json);

    expect(chatResponse.id, 'chatcmpl-712VAFlwVFObwBpRytaSzyqfAu69Y');
    expect(chatResponse.object, 'chat.completion');
    expect(chatResponse.created, 1680482300);
    expect(chatResponse.model, 'gpt-3.5-turbo-0301');
    expect(chatResponse.usage.promptTokens, 567);
    expect(chatResponse.usage.completionTokens, 192);
    expect(chatResponse.usage.totalTokens, 759);
    expect(chatResponse.choices.length, 1);
    expect(chatResponse.choices[0].message.role, Role.assistant);
    expect(chatResponse.choices[0].message.content, 'Test content');
    expect(chatResponse.choices[0].finishReason, 'stop');
    expect(chatResponse.choices[0].index, 0);
  });

  test('Messageオブジェクトが正しく作成されること', () {
    final message = ChatMessage(Role.user, 'こんにちは');
    expect(message.role, Role.user);
    expect(message.content, 'こんにちは');
  });

  test('Messageオブジェクトが正しくJSONに変換されること', () {
    final message = ChatMessage(Role.user, 'こんにちは');
    final json = message.toJson();
    expect(json, {'role': 'user', 'content': 'こんにちは'});
  });

  test('JSONからMessageオブジェクトが正しく作成されること', () {
    final json = {'role': 'user', 'content': 'こんにちは'};
    final message = ChatMessage.fromJson(json);
    expect(message.role, Role.user);
    expect(message.content, 'こんにちは');
  });

  test('toJsonとfromJsonを用いた往復変換の整合性', () {
    final originalMessage = ChatMessage(Role.assistant, 'はい、どういたしましょうか？');
    final json = originalMessage.toJson();
    final restoredMessage = ChatMessage.fromJson(json);

    expect(restoredMessage.role, originalMessage.role);
    expect(restoredMessage.content, originalMessage.content);
  });
}
