import 'package:flutter_chatgpt_completions/src/chatgpt/models/chat_response.dart';
import 'package:flutter_chatgpt_completions/src/chatgpt/logic/chatgpt_chat.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChatResponse', () {
    test('fromJson', () {
      final json = {
        'id': 'responseId',
        'object': 'chat.completion',
        'created': 1234567890,
        'model': 'gpt-3.5-turbo',
        'usage': {
          'prompt_tokens': 10,
          'completion_tokens': 20,
          'total_tokens': 30,
        },
        'choices': [
          {
            'message': {'role': 'assistant', 'content': 'Hello!'},
            'finish_reason': 'stop',
            'index': 0,
          },
        ],
      };

      final chatResponse = ChatResponse.fromJson(json);

      expect(chatResponse.id, 'responseId');
      expect(chatResponse.object, 'chat.completion');
      expect(chatResponse.created, 1234567890);
      expect(chatResponse.model, 'gpt-3.5-turbo');
      expect(chatResponse.usage.promptTokens, 10);
      expect(chatResponse.usage.completionTokens, 20);
      expect(chatResponse.usage.totalTokens, 30);
      expect(chatResponse.choices.length, 1);
      expect(chatResponse.choices[0].message.role, Role.assistant);
      expect(chatResponse.choices[0].message.content, 'Hello!');
      expect(chatResponse.choices[0].finishReason, 'stop');
      expect(chatResponse.choices[0].index, 0);
    });
  });

  group('Usage', () {
    test('fromJson', () {
      final json = {
        'prompt_tokens': 10,
        'completion_tokens': 20,
        'total_tokens': 30,
      };

      final usage = Usage.fromJson(json);

      expect(usage.promptTokens, 10);
      expect(usage.completionTokens, 20);
      expect(usage.totalTokens, 30);
    });
  });

  group('Choice', () {
    test('fromJson', () {
      final json = {
        'message': {'role': 'assistant', 'content': 'Hello!'},
        'finish_reason': 'stop',
        'index': 0,
      };

      final choice = Choice.fromJson(json);

      expect(choice.message.role, Role.assistant);
      expect(choice.message.content, 'Hello!');
      expect(choice.finishReason, 'stop');
      expect(choice.index, 0);
    });
  });
}
