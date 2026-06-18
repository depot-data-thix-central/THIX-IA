import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/text_styles.dart';

/// Barre de saisie pour envoyer un message à THIX.
class MessageInput extends StatefulWidget {
  final void Function(String) onSend;

  const MessageInput({super.key, required this.onSend});

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_hasText != _controller.text.trim().isNotEmpty) {
        setState(() => _hasText = _controller.text.trim().isNotEmpty);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSend(text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.surfaceLight, width: 0.5),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.md,
        vertical: AppDimensions.sm,
      ),
      child: Row(
        children: [
          // Champ de texte
          Expanded(
            child: TextField(
              controller: _controller,
              onSubmitted: (_) => _send(),
              maxLines: 5,
              minLines: 1,
              textCapitalization: TextCapitalization.sentences,
              style: AppTextStyles.bodyLarge(context),
              decoration: InputDecoration(
                hintText: AppStrings.inputHint,
                hintStyle: const TextStyle(color: AppColors.textHint),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.sm,
                  vertical: AppDimensions.xs,
                ),
              ),
            ),
          ),

          const SizedBox(width: AppDimensions.sm),

          // Bouton d'envoi
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: AppDimensions.sendButtonSize,
            height: AppDimensions.sendButtonSize,
            decoration: BoxDecoration(
              color: _hasText ? AppColors.primary : AppColors.surfaceLight,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_upward_rounded,
                color: _hasText
                    ? AppColors.background
                    : AppColors.textHint,
                size: AppDimensions.iconSm + 4,
              ),
              onPressed: _hasText ? _send : null,
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
