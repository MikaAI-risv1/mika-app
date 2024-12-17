import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WelcomeScreen extends StatelessWidget {
  final String username;

  const WelcomeScreen({Key? key, this.username = 'Rishi'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome back, $username',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              )
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .move(begin: Offset(0, -20), end: Offset(0, 0)),
              SizedBox(height: 12),
              Text(
                'Mika',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: [
                        Colors.blue.shade400,
                        Colors.purple.shade400,
                      ],
                    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .move(begin: Offset(0, -20), end: Offset(0, 0)),
              Text(
                'Your Personal Companion',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              )
                  .animate()
                  .fadeIn(duration: 700.ms)
                  .move(begin: Offset(0, -20), end: Offset(0, 0)),
              SizedBox(height: 32),
              _buildFeatureList(),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/chat');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(
                      color: Colors.blue.shade200.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ).animate().fadeIn(duration: 800.ms).move(
                    begin: Offset(0, 20),
                    end: Offset(0, 0),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildFeatureItem(
          icon: Icons.speed_outlined,
          text: 'Quick and Responsive',
        ),
        _buildFeatureItem(
          icon: Icons.keyboard_voice_outlined,
          text: 'Voice Interactions',
        ),
        _buildFeatureItem(
          icon: Icons.settings_outlined,
          text: 'Fully Customizable',
        ),
      ],
    );
  }

  Widget _buildFeatureItem({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.blue.shade200.withOpacity(0.7),
            size: 24,
          ),
          SizedBox(width: 16),
          Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
