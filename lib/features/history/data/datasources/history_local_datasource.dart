import 'package:equatable/equatable.dart';

/// Entité représentant une conversation.
class Conversation extends Equatable {
  final String id;
  final String title; // Titre affiché (basé sur le premier message)
  final DateTime updatedAt;
  final int messageCount;

  const Conversation({
    required this.id,
    required this.title,
    required this.updatedAt,
    this.messageCount = 0,
  });

  @override
  List<Object?> get props => [id, title, updatedAt, messageCount];
}
