import '../logic/chatgpt_chat.dart';

/// ChatMessage クラスは、チャットメッセージを表現するためのクラスです。
///
/// このクラスは、役割（Role）と内容（String）を持ち、
/// JSON との相互変換が可能です。
class ChatMessage {
  /// [role] は、メッセージの送信者の役割（システム、ユーザー、AI）を表す Role オブジェクトです。
  /// [content] は、メッセージの内容を表す String オブジェクトです。

  ChatMessage(this.role, this.content);
  final Role role;
  final String content;

  ChatMessage.user(String content) : this(Role.user, content);
  ChatMessage.assistant(String content) : this(Role.assistant, content);

  /// JSONからChatMessageオブジェクトを作成するファクトリーメソッドです。
  ///
  /// [json] は、JSON 形式の Map<String, dynamic> オブジェクトです。
  /// JSONからRoleとcontentを抽出し、新しいChatMessageオブジェクトを返します。

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      Role.values.where((e) => e.name == json['role'] as String).first,
      json['content'] as String,
    );
  }

  /// ChatMessageオブジェクトをJSONに変換するメソッドです。
  ///
  /// 返り値は、JSON 形式の Map<String, dynamic> オブジェクトです。
  /// ChatMessageのroleとcontentをJSON形式に変換します。
  Map<String, dynamic> toJson() {
    return {
      'role': role.name,
      'content': content,
    };
  }
}
