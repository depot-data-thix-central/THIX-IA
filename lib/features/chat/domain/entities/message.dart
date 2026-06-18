import 'package:equatable/equatable.dart';

/// Entité Message (domaine pur).
///
/// Représente un message dans une conversation.
/// Aucune dépendance vers la couche data ou présentation.
class Message extends Equatable {
  final String id;
  final String content;
  final String role; // 'user', 'assistant', 'system'
  final DateTime timestamp;
  final bool isStreaming;

  const Message({
    required this.id,
    required this.content,
    required this.role,
    DateTime? timestamp,
    this.isStreaming = false,
  }) : timestamp = timestamp ?? DateTime.now();

  /// Copie l'entité en modifiant certains champs.
  Message copyWith({
    String? id,
    String? content,
    String? role,
    DateTime? timestamp,
    bool? isStreaming,
  }) {
    return Message(
      id: id ?? this.id,
      content: content ?? this.content,
      role: role ?? this.role,
      timestamp: timestamp ?? this.timestamp,
      isStreaming: isStreaming ?? this.isStreaming,
    );
  }

  @override
  List<Object?> get props => [id, content, role, timestamp, isStreaming];
}
