import 'package:flutter/material.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final List<Map<String, dynamic>> _chats = [
    {
      'id': '1',
      'name': 'Alice',
      'avatar': 'https://example.com/avatar1.jpg',
      'lastMessage': 'Hey, how are you?',
      'time': '2:30 PM',
      'unread': 3,
    },
    {
      'id': '2', 
      'name': 'Bob',
      'avatar': 'https://example.com/avatar2.jpg',
      'lastMessage': 'Check out this new chapter!',
      'time': '1:15 PM',
      'unread': 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),
      appBar: AppBar(
        title: const Text('Messages', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF12151B),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _chats.length,
        itemBuilder: (context, index) {
          final chat = _chats[index];
          return _ChatListItem(chat: chat);
        },
      ),
    );
  }
}

class _ChatListItem extends StatelessWidget {
  final Map<String, dynamic> chat;

  const _ChatListItem({required this.chat});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF12151B),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(chat['avatar']),
        ),
        title: Text(
          chat['name'],
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          chat['lastMessage'],
          style: TextStyle(color: Colors.grey[400]),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              chat['time'],
              style: TextStyle(color: Colors.grey[400], fontSize: 12),
            ),
            if (chat['unread'] > 0)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xFF6D28D9),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  chat['unread'].toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(chatId: chat['id'], userName: chat['name']),
            ),
          );
        },
      ),
    );
  }
}