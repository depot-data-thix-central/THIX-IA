import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../domain/entities/message.dart';

/// Bulle de message pour le chat.
/// S'adapte selon que le message est de l'utilisateur ou de THIX.
class ChatBubble extends StatelessWidget {
  final Message message;

  const ChatBubble({super.key, required this.message});

  bool get _isUser => message.role == 'user';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.xs),
      child: Row(
        mainAxisAlignment:
            _isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Avatar THIX (à gauche)
          if (!_isUser) ...[
            _ThixAvatar(),
            const SizedBox(width: AppDimensions.sm),
          ],

          // Bulle
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width *
                    AppDimensions.bubbleMaxWidth,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.md,
                vertical: AppDimensions.sm + 4,
              ),
              decoration: BoxDecoration(
                color: _isUser ? AppColors.userBubble : AppColors.thixBubble,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(AppDimensions.bubbleRadius),
                  topRight: const Radius.circular(AppDimensions.bubbleRadius),
                  bottomLeft: Radius.circular(
                    _isUser ? AppDimensions.bubbleRadius : AppDimensions.xs,
                  ),
                  bottomRight: Radius.circular(
                    _isUser ? AppDimensions.xs : AppDimensions.bubbleRadius,
                  ),
                ),
                border: _isUser
                    ? null
                    : Border.all(
                        color: AppColors.primary.withOpacity(0.15),
                        width: 0.5,
                      ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Contenu du message
                  Text(
                    message.content,
                    style: AppTextStyles.chatMessage(context),
                  ),
                  const SizedBox(height: AppDimensions.xxs),
                  // Timestamp
                  Text(
                    DateFormatter.smartDateTime(message.timestamp),
                    style: AppTextStyles.chatTimestamp(context),
                  ),
                ],
              ),
            ),
          ),

          // Avatar utilisateur (à droite)
          if (_isUser) ...[
            const SizedBox(width: AppDimensions.sm),
            CircleAvatar(
              radius: AppDimensions.avatarSize / 2,
              backgroundColor: AppColors.surfaceLight,
              child: const Icon(
                Icons.person,
                color: AppColors.textSecondary,
                size: AppDimensions.iconMd,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Petit avatar de THIX (rond avec un éclat).
class _ThixAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.avatarSize,
      height: AppDimensions.avatarSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.surfaceLight,
        boxShadow: [
          BoxShadow(
            color: AppColors.thixGlow.withOpacity(0.5),
            blurRadius: AppDimensions.avatarGlowRadius,
            spreadRadius: 0,
          ),
        ],
      ),
      child: const Center(
        child: Text(
          'TH',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
