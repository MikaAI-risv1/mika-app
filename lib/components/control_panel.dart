import 'package:flutter/material.dart';
import 'theme_server.dart';

class ControlPanel extends StatelessWidget {
  final VoidCallback onRestart;
  final VoidCallback onBackup;
  final VoidCallback onLogs;

  const ControlPanel({
    required this.onRestart,
    required this.onBackup,
    required this.onLogs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.darkBlue.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.accentBlue.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Control Panel',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ActionButton(
                label: 'Restart',
                icon: Icons.restart_alt,
                color: AppTheme.accentBlue,
                onPressed: onRestart,
              ),
              ActionButton(
                label: 'Backup',
                icon: Icons.backup,
                color: AppTheme.accentPurple,
                onPressed: onBackup,
              ),
              ActionButton(
                label: 'Logs',
                icon: Icons.article,
                color: AppTheme.darkPurple,
                onPressed: onLogs,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: color),
      label: Text(
        label,
        style: TextStyle(color: color),
      ),
      style: TextButton.styleFrom(
        backgroundColor: color.withOpacity(0.1),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
