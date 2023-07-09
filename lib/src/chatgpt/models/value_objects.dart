/// Model クラスは、異なる GPT モデルを表す列挙型です。
///
/// 現在、サポートされているのは 'gpt-3.5-turbo' だけですが、
/// 他のモデルを追加する場合には、この列挙型に新しい要素を追加してください。
enum Model {
  gtp35Turbo('gpt-3.5-turbo'),
  gpt4('gpt-4');

  const Model(this.modelName);
  final String modelName;

  static Model fromName(String name) {
    final model = Model.values.where((e) => e.modelName == name);
    if (model.length == 1) {
      return model.first;
    }
    throw ArgumentError('Unknown model name: $name');
  }
}

/// MaxTokens クラスは、OpenAI API に対して最大トークン数を設定するためのクラスです。
///
/// このクラスは、整数型の maxTokens を持ち、
/// 0より大きい数値であることが保証されています。
class MaxTokens {
  const MaxTokens(this.maxTokens) : assert(0 < maxTokens);

  final int maxTokens;
  int call() => maxTokens;

  Map<String, dynamic> toJson() => {
        'max_tokens': maxTokens,
      };

  static MaxTokens fromJson(Map<String, dynamic> json) =>
      MaxTokens(json['max_tokens']);
}

/// Temperature クラスは、OpenAI API のサンプリング温度を設定するためのクラスです。
///
/// このクラスは、double型の temperature を持ち、
/// 0以上2以下の範囲であることが保証されています。
class Temperature {
  const Temperature(this.temperature)
      : assert(
          0 <= temperature && temperature <= 2,
          'What sampling temperature to use, between 0 and 2',
        );

  final double temperature;
  double call() => temperature;

  Map<String, dynamic> toJson() => {
        'temperature': temperature,
      };

  static Temperature fromJson(Map<String, dynamic> json) =>
      Temperature(json['temperature']);
}
