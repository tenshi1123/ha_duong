import 'package:intl/intl.dart';

class ConversationModel {
  final String? chatName;
  final String chatType;
  final String teacherChatName;
  final DateTime createdAt;
  final String content;
  final String chatId;
  final String messageType;
  final String? teacherName;
  final String unreadMessage;
  final String teacherAvatar;
  ConversationModel({
    required this.chatName,
    required this.chatType,
    required this.teacherChatName,
    required this.createdAt,
    required this.content,
    required this.chatId,
    required this.messageType,
    required this.teacherName,
    required this.unreadMessage,
    required this.teacherAvatar,
  });
  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
        chatName: json['chat_name'],
        chatType: json['chat_type'],
        teacherChatName: json['teachers_chat_full_name'],
        createdAt: DateFormat("yyyy-MM-dd hh:mm:ss").parse(json['created_at']),
        content: json['content'],
        chatId: json['chat_id'],
        messageType: json['message_type'],
        teacherName: json['teachers_full_name'],
        unreadMessage: json['unread_messages_count'],
        teacherAvatar: json['teachers_chat_avatar'] ?? '');
  }
}

class MessageModel {
  var content;

  final String senderType;
  final DateTime createdAt;

  MessageModel({
    required this.content,
    required this.senderType,
    required this.createdAt,
  });
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      content: json['content'],
      senderType: json['sender_type'],
      createdAt: DateFormat("yyyy-MM-dd hh:mm:ss").parse(json['created_at']),
    );
  }
}

class TeacherModel {
  final String id;
  final String fullName;
  final String phone;
  final String avatar;
  TeacherModel(
      {required this.id,
      required this.fullName,
      required this.phone,
      required this.avatar});
  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      id: json['id'] ?? '',
      fullName: json['full_name'] ?? '',
      phone: json['phone'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }
}
