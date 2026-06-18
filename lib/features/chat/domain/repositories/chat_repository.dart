import '../entities/message.dart';

/// Contrat du repository de chat (domaine).
///
/// Définit les opérations que la couche data doit implémenter.
abstract class ChatRepository {
  /// Envoie un message et retourne la réponse de l'assistant.
  /// Peut lever une [Failure] en cas d'erreur.
  Future<Message> sendMessage({
    required String content,
    String? conversationId,
    String? model,
  });

  /// Récupère tous les messages d'une conversation.
  Future<List<Message>> getConversation(String conversationId);

  /// Supprime une conversation.
  Future<void> deleteConversation(String conversationId);
}
