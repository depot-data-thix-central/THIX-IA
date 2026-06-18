import '../../../../core/errors/failure.dart';
import '../entities/message.dart';
import '../repositories/chat_repository.dart';

/// Usecase : Envoyer un message à THIX.
///
/// Encapsule l'appel au repository et la logique métier.
/// Lance une [Failure] si le repository échoue.
class SendMessage {
  final ChatRepository _repository;

  SendMessage(this._repository);

  Future<Message> call({
    required String content,
    String? conversationId,
    String? model,
  }) async {
    // Validation métier (exemple)
    if (content.trim().isEmpty) {
      throw const ValidationFailure(
        message: 'Le message ne peut pas être vide.',
        code: 'EMPTY_MESSAGE',
      );
    }

    // Appeler le repository
    return await _repository.sendMessage(
      content: content.trim(),
      conversationId: conversationId,
      model: model,
    );
  }
}
