import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/chat_repository.dart';
import '../../domain/usecases/send_message.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../data/datasources/chat_remote_datasource.dart';
import '../../data/datasources/chat_local_datasource.dart';
import '../../data/datasources/chat_remote_datasource.dart' as remote;
import '../../data/datasources/chat_local_datasource.dart' as local;

// ───── Providers de base (data) ─────

final chatRemoteDataSourceProvider = Provider<ChatRemoteDataSource>((ref) {
  return ChatRemoteDataSourceImpl(ref.watch(apiClientProvider));
});

final chatLocalDataSourceProvider = Provider<ChatLocalDataSource>((ref) {
  return ChatLocalDataSourceImpl(ref.watch(localStorageProvider));
});

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepositoryImpl(
    remoteDataSource: ref.watch(chatRemoteDataSourceProvider),
    localDataSource: ref.watch(chatLocalDataSourceProvider),
  );
});

final sendMessageUseCaseProvider = Provider<SendMessage>((ref) {
  return SendMessage(ref.watch(chatRepositoryProvider));
});

// ───── État du chat ─────

enum ChatStatus { initial, loading, success, error }

class ChatState {
  final List<Message> messages;
  final ChatStatus status;
  final Failure? error;
  final String? currentConversationId;
  final bool isStreaming;

  const ChatState({
    this.messages = const [],
    this.status = ChatStatus.initial,
    this.error,
    this.currentConversationId,
    this.isStreaming = false,
  });

  ChatState copyWith({
    List<Message>? messages,
    ChatStatus? status,
    Failure? error,
    String? currentConversationId,
    bool? isStreaming,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      status: status ?? this.status,
      error: error,
      currentConversationId: currentConversationId ?? this.currentConversationId,
      isStreaming: isStreaming ?? this.isStreaming,
    );
  }
}

// ───── Notifier ─────

class ChatNotifier extends StateNotifier<ChatState> {
  final SendMessage _sendMessage;
  final ChatRepository _repository;

  ChatNotifier(this._sendMessage, this._repository) : super(const ChatState());

  /// Charge une conversation existante.
  Future<void> loadConversation(String id) async {
    state = state.copyWith(
      status: ChatStatus.loading,
      currentConversationId: id,
    );
    try {
      final messages = await _repository.getConversation(id);
      state = state.copyWith(
        messages: messages,
        status: ChatStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        status: ChatStatus.error,
        error: e is Failure ? e : const Failure(message: 'Erreur inconnue'),
      );
    }
  }

  /// Envoie un message utilisateur et reçoit la réponse.
  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    // Message utilisateur temporaire pour l'affichage immédiat
    final userMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content.trim(),
      role: 'user',
    );

    state = state.copyWith(
      messages: [...state.messages, userMessage],
      status: ChatStatus.loading,
      error: null,
      isStreaming: true,
    );

    try {
      final response = await _sendMessage(
        content: content.trim(),
        conversationId: state.currentConversationId,
      );

      // Mettre à jour la liste des messages avec la réponse
      state = state.copyWith(
        messages: [...state.messages, response],
        status: ChatStatus.success,
        isStreaming: false,
      );
    } catch (e) {
      state = state.copyWith(
        status: ChatStatus.error,
        error: e is Failure ? e : const Failure(message: 'Erreur inconnue'),
        isStreaming: false,
      );
    }
  }

  /// Réinitialise l'erreur.
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Crée une nouvelle conversation.
  void newConversation() {
    state = const ChatState();
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  return ChatNotifier(
    ref.watch(sendMessageUseCaseProvider),
    ref.watch(chatRepositoryProvider),
  );
});
