import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ChatService {
  final String _baseUrl = 'https://your-backend-url.com/chat';

  Future<String> getChatResponse(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/text'),
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

  Future<String> getChatResponseWithImage(String prompt, File imageFile) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$_baseUrl/image'));

      request.fields['prompt'] = prompt;

      var stream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();

      var multipartFile = http.MultipartFile(
        'image',
        stream,
        length,
        filename: 'image.jpg',
        contentType: MediaType('image', 'jpeg'),
      );

      request.files.add(multipartFile);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        return responseBody['response'] ?? 'I did not understand that.';
      } else {
        throw Exception('Failed to get AI response for image');
      }
    } catch (e) {
      print('Error in AI Service with image: $e');
      return 'Sorry, I am having trouble processing your image right now.';
    }
  }

  Future<File> compressImage(File file) async {
    try {
      return file;
    } catch (e) {
      print('Error compressing image: $e');
      return file;
    }
  }
}
