import 'package:intl/intl.dart';

class ChatModel {
  final String chatId;
  final String hotline;
  final List<MessageModel> messages;
  ChatModel({
    required this.chatId,
    required this.hotline,
    required this.messages,
  });
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      chatId: json['chat_id'] ?? '',
      hotline: json['building']['hotline'] ?? '',
      messages: (json['value'] as List<dynamic>? ?? [])
          .map((x) => MessageModel.fromJson(x))
          .toList(),
    );
  }
}

class MessageModel {
  final String id;
  final String content;
  final String chatId;
  final String messageType;
  final String senderType;
  final DateTime createdAt;

  MessageModel({
    required this.id,
    required this.content,
    required this.chatId,
    required this.messageType,
    required this.senderType,
    required this.createdAt,
  });
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] ?? '',
      content: json['content'] ?? '',
      chatId: json['chat_id'] ?? '',
      messageType: json['message_type'] ?? '',
      senderType: json['sender_type'] ?? '',
      createdAt:
          DateFormat("yyyy-MM-dd hh:mm:ss").parse(json['created_at'] ?? ''),
    );
  }
}

class NotificationModel {
  final List<NotiTypeModel> listNotiType;
  final List<NotiValueModel> listNoti;
  NotificationModel({
    required this.listNotiType,
    required this.listNoti,
  });
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      listNotiType: (json['notification_type'] as List<dynamic>? ?? [])
          .map((x) => NotiTypeModel.fromJson(x))
          .toList(),
      listNoti: (json['value'] as List<dynamic>? ?? [])
          .map((x) => NotiValueModel.fromJson(x))
          .toList(),
    );
  }
}

class NotiValueModel {
  final String id;
  final String title;
  final String content;
  final String type;
  final DateTime createdAt;
  final String isActive;
  NotiValueModel({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    required this.createdAt,
    required this.isActive,
  });
  factory NotiValueModel.fromJson(Map<String, dynamic> json) {
    return NotiValueModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      type: json['type'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? ''),
      isActive: json['is_active'] ?? '',
    );
  }
}

class NotiTypeModel {
  final int value;
  final String name;
  final String total;
  NotiTypeModel({
    required this.value,
    required this.name,
    required this.total,
  });
  factory NotiTypeModel.fromJson(Map<String, dynamic> json) {
    return NotiTypeModel(
        value: json['value'] ?? 0,
        name: json['name'] ?? '',
        total: json['total'] ?? '');
  }
}
