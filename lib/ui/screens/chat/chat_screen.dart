import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String userName;

  const ChatScreen({super.key, required this.chatId, required this.userName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'id': '1',
      'text': 'Hey there!',
      'isMe': false,
      'time': '2:25 PM',
    },
    {
      'id': '2',
      'text': 'Hello! How are you?',
      'isMe': true, 
      'time': '2:26 PM',
    },
    {
      'id': '3',
      'text': 'I\'m good! Just reading some comics',
      'isMe': false,
      'time': '2:30 PM',
    },
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'text': _messageController.text,
        'isMe': true,
        'time': 'Now',
      });
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),
      appBar: AppBar(
        title: Text(widget.userName, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF12151B),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _MessageBubble(message: message);
              },
            ),
          ),
          
          // Message Input
          Container(
            padding: const EdgeInsets.all(12),
            color: const Color(0xFF12151B),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF1A1F2E),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: const Color(0xFF6D28D9),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final Map<String, dynamic> message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      alignment: message['isMe'] ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message['isMe'] ? const Color(0xFF6D28D9) : const Color(0xFF1A1F2E),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message['text'],
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              message['time'],
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}