import 'package:flutter_chatgpt_completions/src/chatgpt/models/value_objects.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Model', () {
    test('fromName', () {
      final model = Model.fromName('gpt-3.5-turbo');
      expect(model, Model.gtp35Turbo);
    });

    test('fromName should throw ArgumentError for unknown names', () {
      expect(() => Model.fromName('unknown'), throwsA(isA<ArgumentError>()));
    });
  });

  group('MaxTokens', () {
    test('constructor', () {
      final maxToken = MaxTokens(42);
      expect(maxToken.maxTokens, 42);
    });

    test('constructor should throw AssertionError for non-positive maxToken',
        () {
      expect(() => MaxTokens(0), throwsA(isA<AssertionError>()));
      expect(() => MaxTokens(-1), throwsA(isA<AssertionError>()));
    });

    test('toJson', () {
      final maxToken = MaxTokens(42);
      final json = maxToken.toJson();
      expect(json, {'max_tokens': 42});
    });

    test('fromJson', () {
      final json = {'max_tokens': 42};
      final maxToken = MaxTokens.fromJson(json);
      expect(maxToken.maxTokens, 42);
    });
  });

  group('Temperature', () {
    test('constructor', () {
      final temperature = Temperature(1.5);
      expect(temperature.temperature, 1.5);
    });

    test('constructor should throw AssertionError for invalid temperature', () {
      expect(() => Temperature(-0.1), throwsA(isA<AssertionError>()));
      expect(() => Temperature(2.1), throwsA(isA<AssertionError>()));
    });

    test('toJson', () {
      final temperature = Temperature(1.5);
      final json = temperature.toJson();
      expect(json, {'temperature': 1.5});
    });

    test('fromJson', () {
      final json = {'temperature': 1.5};
      final temperature = Temperature.fromJson(json);
      expect(temperature.temperature, 1.5);
    });
  });
}
