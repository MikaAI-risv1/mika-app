import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  final String _baseUrl = 'https://your-backend-url.com/chat';

  Future<String> getChatResponse(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'prompt': prompt}),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        return responseBody['response'] ?? 'I did not understand that.';
      } else {
        throw Exception('Failed to get AI response');
      }
    } catch (e) {
      print('Error in AI Service: $e');
      return 'Sorry, I am having trouble responding right now.';
    }
  }
}
