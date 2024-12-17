import 'package:flutter/material.dart';
import 'theme_chat.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback onSettingsTap;

  const CustomAppBar({required this.onSettingsTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.darkSurface.withOpacity(0.5),
        border: Border(
          bottom: BorderSide(
            color: AppTheme.accentBlue.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Mika',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.settings_outlined,
              color: Colors.white.withOpacity(0.7),
            ),
            onPressed: onSettingsTap,
          ),
        ],
      ),
    );
  }
}
