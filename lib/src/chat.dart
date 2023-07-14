import '../flutter_chatgpt_completions.dart';

/// チャットインターフェースを定義する抽象クラスです。
///
/// この抽象クラスは、チャット機能を実装するために使用されます。
/// 継承して具体的なチャット機能を実装してください。
abstract class Chat<T extends ChatMessage> {
  /// ユーザーからのメッセージに対して応答を生成します。
  ///
  /// [message] ユーザーからのメッセージ。
  /// return 応答メッセージを含むFuture。
  Future<T> ask(T message);
}
