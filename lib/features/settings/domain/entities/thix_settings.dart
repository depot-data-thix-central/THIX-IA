import 'package:equatable/equatable.dart';

class ThixSettings extends Equatable {
  final String apiEndpoint;
  final String model;
  final double temperature;
  final int maxTokens;
  final bool darkMode;

  const ThixSettings({
    required this.apiEndpoint,
    required this.model,
    required this.temperature,
    required this.maxTokens,
    required this.darkMode,
  });

  static const ThixSettings defaultSettings = ThixSettings(
    apiEndpoint: 'http://localhost:11434',
    model: 'llama3',
    temperature: 0.8,
    maxTokens: 2048,
    darkMode: true,
  );

  ThixSettings copyWith({
    String? apiEndpoint,
    String? model,
    double? temperature,
    int? maxTokens,
    bool? darkMode,
  }) {
    return ThixSettings(
      apiEndpoint: apiEndpoint ?? this.apiEndpoint,
      model: model ?? this.model,
      temperature: temperature ?? this.temperature,
      maxTokens: maxTokens ?? this.maxTokens,
      darkMode: darkMode ?? this.darkMode,
    );
  }

  @override
  List<Object?> get props => [apiEndpoint, model, temperature, maxTokens, darkMode];
}
