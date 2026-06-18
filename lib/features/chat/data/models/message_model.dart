import '../../domain/entities/message.dart';

/// Modèle de données pour un message de chat (couche Data).
///
/// Extends l'entité [Message] pour hériter de ses propriétés.
/// Ajoute des méthodes de conversion JSON.
class MessageModel extends Message {
  const MessageModel({
    required super.id,
    required super.content,
    required super.role,
    super.timestamp,
    super.isStreaming,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String? ?? DateTime.now().millisecondsSinceEpoch.toString(),
      content: json['content'] as String? ?? '',
      role: json['role'] as String? ?? 'user',
      timestamp: json['timestamp'] != null
          ? DateTime.tryParse(json['timestamp'] as String) ?? DateTime.now()
          : DateTime.now(),
      isStreaming: json['isStreaming'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'role': role,
      'timestamp': timestamp.toIso8601String(),
      'isStreaming': isStreaming,
    };
  }

  /// Conversion depuis l'entité.
  factory MessageModel.fromEntity(Message entity) {
    if (entity is MessageModel) return entity;
    return MessageModel(
      id: entity.id,
      content: entity.content,
      role: entity.role,
      timestamp: entity.timestamp,
      isStreaming: entity.isStreaming,
    );
  }
}
