import '../entities/message.dart';

/// Contrat du repository chat (domaine).
abstract class ChatRepository {
  Future<Message> sendMessage({
    required String content,
    String? conversationId,
    String? model,
  });

  Future<List<Message>> getConversation(String conversationId);
  Future<void> deleteConversation(String conversationId);
}
