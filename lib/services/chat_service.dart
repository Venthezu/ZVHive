import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/supabase_client.dart';
import '../models/message_model.dart';

class ChatService {
  final SupabaseClient client = SupabaseClient.instance;

  Future<List<Message>> getMessages(String chatId) async {
    final response = await client.database
        .from('messages')
        .select()
        .eq('chat_id', chatId)
        .order('created_at', ascending: true);

    return (response as List).map((json) => Message.fromJson(json)).toList();
  }

  Future<void> sendMessage(Message message) async {
    await client.database
        .from('messages')
        .insert(message.toJson());
  }

  Stream<List<Message>> getMessagesStream(String chatId) {
    return client.realtime
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('chat_id', chatId)
        .order('created_at', ascending: true)
        .map((event) => event.map((json) => Message.fromJson(json)).toList());
  }

  Future<List<Map<String, dynamic>>> getChatList(String userId) async {
    final response = await client.database
        .from('chats')
        .select('''
          *,
          last_message:messages(*)
        ''')
        .or('user1_id.eq.$userId,user2_id.eq.$userId')
        .order('updated_at', ascending: false);

    return response as List<Map<String, dynamic>>;
  }
}