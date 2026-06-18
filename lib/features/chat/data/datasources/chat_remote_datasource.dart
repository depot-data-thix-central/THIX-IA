import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/errors/app_exception.dart';

/// Source de données distante pour le chat (Ollama / API compatible).
abstract class ChatRemoteDataSource {
  Future<String> generate(String prompt, {String? model});
  Future<String> chat(List<Map<String, String>> messages, {String? model});
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final ApiClient _client;

  ChatRemoteDataSourceImpl(this._client);

  @override
  Future<String> generate(String prompt, {String? model}) async {
    try {
      final response = await _client.dio.post(
        ApiEndpoints.generate,
        data: {
          'model': model ?? 'llama3',
          'prompt': prompt,
          'stream': false,
        },
      );

      if (response.statusCode == 200) {
        return response.data['response'] as String? ?? '';
      } else {
        throw ServerException(
          message: 'Erreur ${response.statusCode}',
          statusCode: response.statusCode,
          code: 'GENERATE_FAILED',
        );
      }
    } on AppException {
      rethrow;
    } catch (e, stack) {
      throw ServerException(
        message: 'Erreur lors de la génération.',
        code: 'GENERATE_ERROR',
        originalError: e,
        stackTrace: stack,
      );
    }
  }

  @override
  Future<String> chat(List<Map<String, String>> messages, {String? model}) async {
    try {
      final response = await _client.dio.post(
        ApiEndpoints.chat,
        data: {
          'model': model ?? 'llama3',
          'messages': messages,
          'stream': false,
        },
      );

      if (response.statusCode == 200) {
        final choices = response.data['choices'] as List<dynamic>?;
        if (choices != null && choices.isNotEmpty) {
          return choices.first['message']['content'] as String? ?? '';
        }
        return '';
      } else {
        throw ServerException(
          message: 'Erreur ${response.statusCode}',
          statusCode: response.statusCode,
          code: 'CHAT_FAILED',
        );
      }
    } on AppException {
      rethrow;
    } catch (e, stack) {
      throw ServerException(
        message: 'Erreur lors de la conversation.',
        code: 'CHAT_ERROR',
        originalError: e,
        stackTrace: stack,
      );
    }
  }
}
