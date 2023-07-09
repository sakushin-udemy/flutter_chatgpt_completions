import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_chatgpt_completions/src/chatgpt/models/value_objects.dart';

import '../../chat.dart';
import '../models/chat_data.dart';
import '../models/chat_message.dart';
import '../models/chat_response.dart';

enum Role {
  /// チャットボットの初期設定
  system,

  /// ユーザーの質問、
  user,

  /// チャットボットの回答
  assistant,
}

/// ChatGPTChat クラスは、ChatGPTを使用してユーザーとのチャットを実現するクラスです。
/// OpenAI APIを利用して、ユーザーからのメッセージに対する返答を生成します。
class ChatGPTChat implements Chat<ChatMessage> {
  /// URL
  static const kUrl = 'https://api.openai.com/v1/chat/completions';

  ChatGPTChat(
    String token, {
    this.setting = '',
    this.model = Model.gtp35Turbo,
  })  : _header = {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        _messages = [ChatMessage(Role.system, setting)];

  final String setting;
  final Model model;
  final Map<String, String> _header;

  /// チャットのメッセージを格納するリストです。
  var _messages = <ChatMessage>[];

  /// ユーザーからのメッセージを受け取り、ChatGPTを利用して返答を生成します。
  @override
  Future<ChatMessage> ask(
    ChatMessage userMessage, {
    int maxHistory = 5,
    MaxTokens maxTokens = const MaxTokens(1024),
    Temperature temperature = const Temperature(1),
  }) async {
    assert(userMessage.role == Role.user);

    // チャットデータを作成し、APIリクエストを送信するための準備を行います
    final chatData = ChatData(
      model: model,
      messages: [
        ...getMessage(maxHistory),
        userMessage,
      ],
      maxTokens: maxTokens,
      temperature: temperature,
    );

    Dio dio = Dio();
    dio.options.headers = _header;

    // APIリクエストを送信し、レスポンスを受け取ります
    final response = await dio.post(
      kUrl,
      data: chatData.toJson(),
    );

    // レスポンスデータからチャットボットの返答を取得します
    final data = ChatResponse.fromJson(response.data as Map<String, dynamic>);

    final systemMessage = data.choices.first.message;
    registerMessage(userMessage, systemMessage);
    return systemMessage;
  }

  /// ユーザーとチャットボットのメッセージを登録します
  void registerMessage(ChatMessage userMessage, ChatMessage systemMessage) {
    _messages = [..._messages, userMessage, systemMessage];
  }

  /// 過去のメッセージ履歴を取得します(最初の設定と最新の maxHistory-1分)
  List<ChatMessage> getMessage(int maxHistory) {
    if (_messages.isEmpty) {
      return [];
    }
    final historyNumber =
        _messages.length < maxHistory ? _messages.length : maxHistory;

    final historyMessages = _messages.getRange(
        _messages.length - historyNumber + 1, _messages.length);
    final result = [_messages[0], ...historyMessages];
    return result;
  }
}
