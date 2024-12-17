import 'package:flutter/material.dart';
import 'theme_chat.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUserMessage;

  const ChatMessage({
    required this.text,
    required this.isUserMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isUserMessage
              ? AppTheme.accentBlue.withOpacity(0.3)
              : AppTheme.accentPurple.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isUserMessage
                ? AppTheme.accentBlue.withOpacity(0.2)
                : AppTheme.accentPurple.withOpacity(0.2),
            width: 1,
          ),
        ),
        padding: EdgeInsets.all(15),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
