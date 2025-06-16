import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ha_duong/models/chat_model.dart';
import 'package:ha_duong/utils/constants/api_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatRepo {
  Dio dio = Dio();
  Future<NotificationModel> getHomeNoti(String apartmentId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.notification,
      data: {
        'apartment_id': int.parse(apartmentId),
      },
    );
    return NotificationModel.fromJson(response.data['data']);
  }

  Future<NotiValueModel> getDetailNoti(String notiId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.detailNoti,
      data: {
        'id': int.parse(notiId),
      },
    );
    return NotiValueModel.fromJson(response.data['data']['value']);
  }

  Future<ChatModel> getHomeChat(String apartmentId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.homeChat,
      data: {
        'apartment_id': int.parse(apartmentId),
      },
    );
    return ChatModel.fromJson(response.data['data']);
  }

  Future<List<MessageModel>> loadMoreChat(String chatId, int page) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.loadMore,
      data: {
        'chat_id': int.parse(chatId),
        'page': page,
      },
    );
    return (response.data['value'] as List)
        .map((e) => MessageModel.fromJson(e))
        .toList();
  }

  Future<bool> sendMessage(
      {required String chatId, required String content}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.sendChat,
      data: {
        'chat_id': int.parse(chatId),
        'content': content,
      },
    );
    return response.data["type"] == 'success';
  }

  Future<bool> sendImgMessage({
    required String chatId,
    required List<File> photos,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      dio.options.headers['Authorization'] = 'Bearer $token';

      if (dio.interceptors.whereType<LogInterceptor>().isEmpty) {
        dio.interceptors.add(LogInterceptor(
          responseBody: true,
          requestBody: true,
          logPrint: (obj) => debugPrint('📦 $obj'),
        ));
      }

      List<MultipartFile> photoFiles = await Future.wait(
        photos.map((file) => MultipartFile.fromFile(file.path)),
      );

      final formData = FormData.fromMap({
        'chat_id': chatId,
        'files[]': photoFiles,
      });

      final response = await dio.post(
        ApiPath.sendChatImg,
        data: formData,
        options: Options(
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      debugPrint("✅ API trả về: ${response.data}");

      if (response.data != null && response.data["type"] == 'success') {
        return true;
      } else {
        debugPrint("⚠️ Phản hồi không thành công: ${response.data}");
        return false;
      }
    } on DioException catch (e) {
      debugPrint("❌ DioException: ${e.message}");
      debugPrint("📍 Response: ${e.response?.data}");
      return false;
    } catch (e, stack) {
      debugPrint("❌ Exception không xác định: $e");
      debugPrint("📍 Stack: $stack");
      return false;
    }
  }
}
