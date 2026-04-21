import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ha_duong/utils/constants/api_path_bql.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class LoginRepoBql {
  Dio dio = Dio();
  Future<bool> login(String email, String password) async {
    // in ra log lỗi
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
      logPrint: (obj) => debugPrint('📦 $obj'),
    ));
    dio.options.headers['Token'] = 'BMSHD123456789';
    Response response;
    try {
      response = await dio.post(
        ApiPathBql.login,
        data: jsonEncode({
          'email': email,
          'password': md5.convert(utf8.encode(password)).toString(),
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
    return response.data["token"] != null;
  }

  Future<bool> forgotPassWord(
      String phone, String passNew, String rePassword) async {
    // in ra log lỗi
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
      logPrint: (obj) => debugPrint('📦 $obj'),
    ));
    dio.options.headers['Token'] = 'BMSHD123456789';
    Response response;
    try {
      response = await dio.post(
        ApiPathBql.forgotPassword,
        data: jsonEncode({
          'phone': phone,
          'pass_new': md5.convert(utf8.encode(passNew)).toString(),
          're_password': md5.convert(utf8.encode(rePassword)).toString(),
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
    return response.data["token"] != null;
  }

  Future<String> refreshToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    // in ra log lỗi
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
      logPrint: (obj) => debugPrint('📦 $obj'),
    ));
    Response response;
    try {
      response = await dio.get(ApiPathBql.refreshToken);
    } on DioException {
      return '';
    }
    await prefs.setString('token', response.data['data']["refresh_token"]);
    return response.data['data']["refresh_token"];
  }

  Future<String> getToken() async {
    final response = await Dio()
        .get('https://61df53d20f3bdb0017934a35.mockapi.io/se06/swaper');
    String mocktoken = response.data[0]['token'].toString();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', mocktoken);
    return mocktoken;
  }

  Future<bool?> fetchBoolValue() async {
    final url =
        Uri.parse("https://612ced09ab461c00178b5fbb.mockapi.io/api/users/test");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      if (data.isNotEmpty && data[0]['bool'] != null) {
        return data[0]['bool'] as bool;
      }
    }
    return null; // trường hợp lỗi hoặc không có dữ liệu
  }

  Future pushOnesignalId({required String onesignalId}) async {
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
      logPrint: (obj) => debugPrint('📦 $obj'),
    ));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    // dio.options.headers['Token'] = 'BMSHD123456789';
    await dio.post(
      ApiPathBql.pushOnsignalId,
      data: jsonEncode({
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
        await dio.post(ApiPathBql.deleteOnsignalId, data: formData);
      } on DioException {
        return false;
      }
    }
  }
}
