import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ha_duong/bql_model/home_model.dart';
import 'package:ha_duong/bql_model/info_model_bql.dart';
import 'package:ha_duong/utils/constants/api_path_bql.dart';

import 'package:shared_preferences/shared_preferences.dart';

class NotificationRepo {
  Dio dio = Dio();
  Future<List<BuildingModel>> getListBuilding(
      {required String apartmentId, required String categoryId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPathBql.changeCategory,
      data: {
        'apartment_id': int.parse(apartmentId),
        'category_id': int.parse(categoryId),
      },
    );
    return (response.data['data']['post'] as List)
        .map((e) => BuildingModel.fromJson(e))
        .toList();
  }

  Future<bool> pushNotification({
    required String buildingId,
    required String title,
    required String content,
    required int type,
    required List<int>? apartmentIds,
    required File? file,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    // in ra log lỗi
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
      logPrint: (obj) => debugPrint('📦 $obj'),
    ));
    final formData = FormData.fromMap({
      'apartment_id': apartmentIds?.join(',') ?? '',
      'building_id': int.parse(buildingId),
      'title': title,
      'content': content,
      'type': type + 1,
      if (file != null)
        'file': await MultipartFile.fromFile(file.path,
            filename: file.path.split('/').last),
    });

    await dio.post(
      ApiPathBql.addNoti,
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
      ),
    );

    return true;
  }

  Future<List<NotiValueModel>> getListNoti(
      {required String buildingId,
      required int show,
      required int page,
      required String type}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPathBql.getListNoti,
      data: {
        'building_id': int.parse(buildingId),
        'show': show,
        'page': page,
        'type': type,
      },
    );
    return (response.data['data']['value'] as List)
        .map((e) => NotiValueModel.fromJson(e))
        .toList();
  }
}
