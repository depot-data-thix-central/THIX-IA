import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../domain/entities/conversation.dart';

class ConversationTile extends StatelessWidget {
  final Conversation conversation;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const ConversationTile({
    super.key,
    required this.conversation,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.md,
        vertical: AppDimensions.xs,
      ),
      leading: CircleAvatar(
        backgroundColor: AppColors.surfaceLight,
        child: Text(
          conversation.id.substring(0, 2).toUpperCase(),
          style: const TextStyle(color: AppColors.primary),
        ),
      ),
      title: Text(
        conversation.title.isNotEmpty ? conversation.title : 'Nouvelle conversation',
        style: AppTextStyles.bodyLarge(context),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '${conversation.messageCount} messages · ${DateFormatter.smartDateTime(conversation.updatedAt)}',
        style: AppTextStyles.caption(context),
      ),
      onTap: onTap,
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline, color: AppColors.textHint),
        onPressed: onDelete,
      ),
    );
  }
}
