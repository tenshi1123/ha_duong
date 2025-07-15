import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../utils/constants/api_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepo {
  Dio dio = Dio();
  Future<bool> login(
    String code,
  ) async {
    dio.options.headers['Token'] = 'BMSHD123456789';
    Response response;
    try {
      response = await dio.post(
        ApiPath.login,
        data: jsonEncode({
          'phone': code,
        }),
      );
    } on DioException {
      return false;
    }
    if (response.data['status'] == false) {
      return false;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', response.data["refresh_token"]);
    await prefs.setString('refresh_token', response.data["refresh_token"]);
    return response.data["refresh_token"] != null;
  }

  Future<String> refreshToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    try {
      response = await dio.get(ApiPath.refreshToken);
    } on DioException {
      return '';
    }
    await prefs.setString('token', response.data['data']["refresh_token"]);
    return response.data['data']["refresh_token"];
  }

  Future pushOnesignalId(
      {required String apatmentId, required String onesignalId}) async {
    // var formData = FormData.fromMap({
    //   'apartment_id': apatmentId,
    //   'onesignal_id': onesignalId,
    // });
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
      logPrint: (obj) => debugPrint('📦 $obj'),
    ));
    dio.options.headers['Token'] = 'BMSHD123456789';
    await dio.post(
      ApiPath.pushOnsignalId,
      data: jsonEncode({
        'apartment_id': apatmentId,
        'onesignal_id': onesignalId,
      }),
    );
  }

  Future deleteOnesignalId(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    var formData = FormData.fromMap({
      'onesignal_id': id,
    });

    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
      try {
        await dio.post(ApiPath.deleteOnsignalId, data: formData);
      } on DioException {
        return false;
      }
    }
  }
}
