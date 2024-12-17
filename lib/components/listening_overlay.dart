import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'theme_chat.dart';

class ListeningOverlay extends StatelessWidget {
  final String transcription;

  const ListeningOverlay({required this.transcription});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: AppTheme.darkSurface.withOpacity(0.5),
        border: Border(
          top: BorderSide(
            color: AppTheme.accentBlue.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Listening...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            )
                .animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 1500.ms),
            SizedBox(height: 20),
            Text(
              transcription,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Container(
              width: 300,
              height: 50,
              child: CustomPaint(
                painter: _WaveformPainter(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WaveformPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.accentBlue.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    path.moveTo(0, size.height / 2);

    for (double x = 0; x < size.width; x += 10) {
      final y = size.height / 2 +
          (size.height / 2) *
              (1 *
                  sin(x / 20 + DateTime.now().millisecondsSinceEpoch / 200) *
                  (1 - x / size.width));
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
