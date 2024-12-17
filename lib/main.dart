import 'package:flutter/material.dart';
import 'package:mika_app/screens/chat_screen.dart';
import 'package:mika_app/screens/server_status_screen.dart';
import 'package:mika_app/screens/welcome_screen.dart';

void main() {
  runApp(MikaAssistantApp());
}

class MikaAssistantApp extends StatelessWidget {
  const MikaAssistantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      home: WelcomeScreen(),
      routes: {
        '/chat': (context) => ChatScreen(),
        '/server-status': (context) => ServerStatusScreen(),
      },
    );
  }
}
