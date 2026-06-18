import '../../../../core/errors/app_exception.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_datasource.dart';
import '../datasources/chat_local_datasource.dart';
import '../models/message_model.dart';

/// Implémentation concrète du [ChatRepository].
class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  final ChatLocalDataSource localDataSource;

  ChatRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Message> sendMessage({
    required String content,
    String? conversationId,
    String? model,
  }) async {
    // 1. Créer le message utilisateur
    final userMessage = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      role: 'user',
    );

    // 2. Sauvegarder en local
    if (conversationId != null) {
      await localDataSource.saveMessage(conversationId, userMessage);
    }

    // 3. Préparer le prompt pour l'IA
    try {
      final history = conversationId != null
          ? await localDataSource.getConversation(conversationId)
          : <MessageModel>[];

      // Construire la liste des messages au format attendu par l'API
      final messagesForApi = history.map((m) => {
            'role': m.role,
            'content': m.content,
          }).toList();

      // Ajouter le nouveau message
      messagesForApi.add({'role': 'user', 'content': content});

      // Appeler l'API (chat ou generate, au choix)
      final response = await remoteDataSource.chat(messagesForApi, model: model);

      // Créer le message de réponse
      final assistantMessage = MessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: response,
        role: 'assistant',
      );

      // Sauvegarder en local
      if (conversationId != null) {
        await localDataSource.saveMessage(conversationId, assistantMessage);
      }

      return assistantMessage;
    } catch (e, stack) {
      // Convertir en Failure et laisser la présentation gérer
      final failure = ErrorHandler.mapToFailure(e, stackTrace: stack);
      // Rejeter l'erreur pour que le usecase la transforme
      throw failure;
    }
  }

  @override
  Future<List<Message>> getConversation(String conversationId) async {
    try {
      final models = await localDataSource.getConversation(conversationId);
      return models.map((m) => m as Message).toList();
    } catch (e, stack) {
      throw ErrorHandler.mapToFailure(e, stackTrace: stack);
    }
  }

  @override
  Future<void> deleteConversation(String conversationId) async {
    try {
      await localDataSource.deleteConversation(conversationId);
    } catch (e, stack) {
      throw ErrorHandler.mapToFailure(e, stackTrace: stack);
    }
  }
}
