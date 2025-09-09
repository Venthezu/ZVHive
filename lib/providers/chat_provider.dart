import 'package:flutter/material.dart';
import '../models/message_model.dart';
import '../services/chat_service.dart';

class ChatProvider with ChangeNotifier {
  final ChatService _chatService = ChatService();
  List<Message> _messages = [];
  bool _isLoading = false;
  String? _error;

  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadMessages(String chatId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _messages = await _chatService.getMessages(chatId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Failed to load messages';
      notifyListeners();
    }
  }

  Future<void> sendMessage(String chatId, String content, String receiverId) async {
    try {
      final message = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        chatId: chatId,
        senderId: 'current_user_id', // Get from auth
        receiverId: receiverId,
        content: content,
        createdAt: DateTime.now(),
      );

      await _chatService.sendMessage(message);
      
      // Add to local messages
      _messages.add(message);
      notifyListeners();
    } catch (e) {
      _error = 'Failed to send message';
      notifyListeners();
    }
  }

  Stream<List<Message>> getMessagesStream(String chatId) {
    return _chatService.getMessagesStream(chatId);
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}