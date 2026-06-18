import '../../../../core/storage/local_storage.dart';
import '../../../../core/errors/app_exception.dart';
import '../models/message_model.dart';

/// Source de données locale pour le chat (cache, historique).
abstract class ChatLocalDataSource {
  Future<List<MessageModel>> getConversation(String id);
  Future<void> saveMessage(String conversationId, MessageModel message);
  Future<List<String>> getConversationIds();
  Future<void> deleteConversation(String id);
}

class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  final LocalStorage _storage;
  static const String _prefix = 'chat_conv_';
  static const String _listKey = 'chat_conversations';

  ChatLocalDataSourceImpl(this._storage);

  @override
  Future<List<MessageModel>> getConversation(String id) async {
    try {
      final jsonString = _storage.getString('$_prefix$id');
      if (jsonString == null) return [];
      final List<dynamic> list = jsonString as List<dynamic>;
      return list.map((e) => MessageModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e, stack) {
      throw CacheException(
        message: 'Impossible de charger la conversation $id.',
        code: 'LOCAL_LOAD_ERROR',
        originalError: e,
        stackTrace: stack,
      );
    }
  }

  @override
  Future<void> saveMessage(String conversationId, MessageModel message) async {
    try {
      final messages = await getConversation(conversationId);
      // Éviter les doublons
      final index = messages.indexWhere((m) => m.id == message.id);
      if (index != -1) {
        messages[index] = message;
      } else {
        messages.add(message);
      }
      final json = messages.map((m) => m.toJson()).toList();
      await _storage.setString('$_prefix$conversationId', json.toString());
      // Mettre à jour la liste des IDs
      final ids = await getConversationIds();
      if (!ids.contains(conversationId)) {
        ids.add(conversationId);
        await _storage.setStringList(_listKey, ids);
      }
    } catch (e, stack) {
      throw CacheException(
        message: 'Erreur lors de la sauvegarde du message.',
        code: 'LOCAL_SAVE_ERROR',
        originalError: e,
        stackTrace: stack,
      );
    }
  }

  @override
  Future<List<String>> getConversationIds() async {
    try {
      return _storage.getStringList(_listKey) ?? [];
    } catch (e, stack) {
      throw CacheException(
        message: 'Erreur lors de la récupération des conversations.',
        code: 'LOCAL_IDS_ERROR',
        originalError: e,
        stackTrace: stack,
      );
    }
  }

  @override
  Future<void> deleteConversation(String id) async {
    try {
      await _storage.remove('$_prefix$id');
      final ids = await getConversationIds();
      ids.remove(id);
      await _storage.setStringList(_listKey, ids);
    } catch (e, stack) {
      throw CacheException(
        message: 'Erreur lors de la suppression de la conversation.',
        code: 'LOCAL_DELETE_ERROR',
        originalError: e,
        stackTrace: stack,
      );
    }
  }
}
