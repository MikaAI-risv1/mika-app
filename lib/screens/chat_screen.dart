import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mika_app/components/app_bar.dart';
import 'package:mika_app/components/chat_message.dart';
import 'package:mika_app/components/listening_overlay.dart';
import 'package:mika_app/components/message_input.dart';
import 'package:mika_app/components/theme_chat.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _isListening = false;
  String _transcription = '';

  void _sendMessage(String message) {
    if (message.trim().isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        text: message,
        isUserMessage: true,
      ));

      _messages.add(ChatMessage(
        text: 'I heard: $message',
        isUserMessage: false,
      ));
    });

    _messageController.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOutQuint,
      );
    });
  }

  Future<void> _toggleListening() async {
    var micStatus = await Permission.microphone.request();
    var speechStatus = await Permission.speech.request();

    if (!micStatus.isGranted || !speechStatus.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Microphone and Speech permissions are required')),
      );
      return;
    }

    if (!_isListening) {
      bool available = await _speechToText.initialize();

      if (available) {
        setState(() {
          _isListening = true;
          _transcription = '';
        });

        _speechToText.listen(
          onResult: (val) => setState(() {
            _transcription = val.recognizedWords;
          }),
          listenFor: Duration(seconds: 30),
          pauseFor: Duration(seconds: 5),
          cancelOnError: true,
          partialResults: true,
        );
      }
    } else {
      setState(() {
        _isListening = false;
      });
      _speechToText.stop();

      if (_transcription.isNotEmpty) {
        _sendMessage(_transcription);
      }
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.darkTheme(),
      child: Scaffold(
        body: Container(
          color: AppTheme.darkBackground,
          child: SafeArea(
            child: Column(
              children: [
                CustomAppBar(
                  onSettingsTap: () =>
                      Navigator.pushNamed(context, '/server-status'),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return _messages[index]
                          .animate()
                          .fadeIn(duration: 300.ms)
                          .slide(begin: Offset(index.isEven ? -0.1 : 0.1, 0));
                    },
                  ),
                ),
                if (_isListening)
                  ListeningOverlay(transcription: _transcription),
                MessageInput(
                  controller: _messageController,
                  isListening: _isListening,
                  onSendMessage: () {
                    if (_messageController.text.isNotEmpty) {
                      _sendMessage(_messageController.text);
                    }
                  },
                  onToggleListening: _toggleListening,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
