import 'package:flutter/material.dart';
import 'theme_chat.dart';

class MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSendMessage;
  final VoidCallback onToggleListening;
  final bool isListening;

  const MessageInput({
    required this.controller,
    required this.onSendMessage,
    required this.onToggleListening,
    required this.isListening,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.darkSurface.withOpacity(0.5),
        border: Border(
          top: BorderSide(
            color: AppTheme.accentBlue.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: AppTheme.darkBackground.withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: AppTheme.accentBlue.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            _ActionButton(
              icon: isListening ? Icons.stop : Icons.mic,
              onPressed: onToggleListening,
              color: AppTheme.accentBlue,
            ),
            SizedBox(width: 10),
            _ActionButton(
              icon: Icons.send,
              onPressed: onSendMessage,
              color: AppTheme.accentPurple,
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  const _ActionButton({
    required this.icon,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.all(12),
            child: Icon(
              icon,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ),
      ),
    );
  }
}
