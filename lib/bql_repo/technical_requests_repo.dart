import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ha_duong/bql_model/info_model_bql.dart';
import 'package:ha_duong/bql_model/technical_requests_model.dart';
import 'package:ha_duong/utils/constants/api_path_bql.dart';

import 'package:shared_preferences/shared_preferences.dart';

class TechnicalRequestsRepo {
  Dio dio = Dio();
  Future<List<TechnicalSupportModel>> getListTechnicalRequests(
      {required String buildingId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    //try {
    response = await dio.post(
      ApiPathBql.listTechnicalRequests,
      data: {
        "page": 1,
        "show": 999,
        "building_id": buildingId,
      },
    );
    return (response.data['data']['value'] as List)
        .map((e) => TechnicalSupportModel.fromJson(e))
        .toList();
  }

  Future<DetailRequestModel> getDetailRequest(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPathBql.detailTechnicalRequests,
      data: {
        "id": int.tryParse(id),
      },
    );
    return DetailRequestModel.fromJson(response.data['data']);
  }

  Future<bool> changeStatus({
    required String id,
    required String statusId,
    required List<File>? photos,
    required String? noteText,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    // Tạo map cho FormData
    final Map<String, dynamic> formMap = {
      "id": int.tryParse(id),
      "setting_support_status_id": int.tryParse(statusId),
    };

    // Chỉ thêm ảnh nếu có
    if (photos != null && photos.isNotEmpty) {
      List<MultipartFile> photoFiles = await Future.wait(
        photos.map((file) => MultipartFile.fromFile(file.path)),
      );
      formMap["file[]"] = photoFiles;
    }
    // Chỉ thêm note text nếu có
    if (noteText != null) {
      formMap["note_text"] = noteText;
    }
    if (dio.interceptors.whereType<LogInterceptor>().isEmpty) {
      dio.interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
        logPrint: (obj) => debugPrint('📦 $obj'),
      ));
    }

    final formData = FormData.fromMap(formMap);
    await dio.post(
      ApiPathBql.changeStatus,
      data: formData,
    );
    return true;
  }

  Future<List<ResidentPendingModel>> getListChangeInfo(
      {required String buildingId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    //try {
    response = await dio.post(
      ApiPathBql.residentPending,
      data: {
        "page": 1,
        "show": 25,
        "building_id": buildingId,
      },
    );
    return (response.data['data']['value'] as List)
        .map((e) => ResidentPendingModel.fromJson(e))
        .toList();
  }

  Future<DetailPendingModel> getChiTietThayDoi(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPathBql.detailResidentPending,
      data: {
        "id": int.tryParse(id),
      },
    );
    return DetailPendingModel.fromJson(response.data['data']['value']);
  }

  Future<bool> duyetYc({required String id, required int statusId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    // in ra log lỗi
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
      logPrint: (obj) => debugPrint('📦 $obj'),
    ));
    await dio.post(
      ApiPathBql.duyetYc,
      data: {
        "id": int.tryParse(id),
        "status": statusId //1 dyet, 2 tu choi
      },
    );
    return true;
  }
}
