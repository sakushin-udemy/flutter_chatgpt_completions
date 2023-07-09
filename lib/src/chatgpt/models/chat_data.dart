import 'package:flutter_chatgpt_completions/src/chatgpt/models/value_objects.dart';

import 'chat_message.dart';

/// ChatData クラスは、チャットのデータを表現するためのクラスです。
///
/// このクラスは、モデル（Model）、メッセージのリスト（List<ChatMessage>）、
/// 最大トークン数（MaxTokens）、および温度（Temperature）を持ち、
/// JSON との相互変換が可能です。
class ChatData {
  /// [model] は、GPT モデルを表す Model オブジェクトです。
  /// [messages] は、チャットメッセージのリストを表す List<ChatMessage> オブジェクトです。
  /// [maxTokens] は、最大トークン数を表す MaxTokens オブジェクトです。
  /// [temperature] は、サンプリング温度を表す Temperature オブジェクトです。
  const ChatData({
    required this.model,
    required this.messages,
    required this.maxTokens,
    required this.temperature,
  });

  final Model model;
  final List<ChatMessage> messages;
  final MaxTokens maxTokens;
  final Temperature temperature;

  /// ChatData オブジェクトを JSON に変換するメソッドです。
  ///
  /// 返り値は、JSON 形式の Map<String, dynamic> オブジェクトです。
  /// ChatDataのmodel、messages、maxTokens、およびtemperatureをJSON形式に変換します。
  Map<String, dynamic> toJson() => {
        'model': model.modelName,
        'messages': messages.map((message) => message.toJson()).toList(),
        'max_tokens': maxTokens(),
        'temperature': temperature(),
      };

  /// JSON から ChatData オブジェクトを作成する静的メソッドです。
  ///
  /// [json] は、JSON 形式の Map<String, dynamic> オブジェクトです。
  /// JSON から model、messages、maxTokens、およびtemperatureを抽出し、新しい ChatData オブジェクトを返します。
  static ChatData fromJson(Map<String, dynamic> json) {
    return ChatData(
      model: Model.fromName(json['model']),
      messages: (json['messages'] as List<dynamic>)
          .map((messageJson) =>
              ChatMessage.fromJson(messageJson as Map<String, dynamic>))
          .toList(),
      maxTokens: MaxTokens(json['max_tokens'] as int),
      temperature: Temperature(json['temperature'] as double),
    );
  }
}
