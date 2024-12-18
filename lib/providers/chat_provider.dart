import 'package:flutter/material.dart';
import '../models/message.dart';
import '../services/chat_service.dart';

class ChatProvider with ChangeNotifier {
  final List<Message> _messages = [];
  final ChatService _aiService = ChatService();

  List<Message> get messages => _messages;

  void sendMessage(String text) {
    _messages.add(Message(
      text: text,
      isUserMessage: true,
      timestamp: DateTime.now(),
    ));
    notifyListeners();

    _generateAIResponse(text);
  }

  Future<void> _generateAIResponse(String userMessage) async {
    try {
      final response = await _aiService.getChatResponse(userMessage);
      _messages.add(Message(
        text: response,
        isUserMessage: false,
        timestamp: DateTime.now(),
      ));
      notifyListeners();
    } catch (e) {
      _messages.add(Message(
        text: 'Sorry, I encountered an error.',
        isUserMessage: false,
        timestamp: DateTime.now(),
      ));
      notifyListeners();
    }
  }
}
