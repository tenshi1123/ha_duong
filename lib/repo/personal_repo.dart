import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ha_duong/models/apartment_model.dart';
import 'package:ha_duong/models/info_model.dart';
import 'package:ha_duong/utils/constants/api_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalRepo {
  Dio dio = Dio();

  Future<List<VehicleModel>> getListPhuongTien() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.listPhuongTien,
    );
    final List<VehicleModel> listVehicle =
        (response.data['data']['value'] as List)
            .map((e) => VehicleModel.fromJson(e))
            .toList();
    return listVehicle;
  }

  Future<Map<String, dynamic>> getApartmentProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await dio.post(ApiPath.apartment);
    final resident = ResidentModel.fromJson(response.data['data']['value']);
    final List<ApartmentModel> listApartment =
        (response.data['data']['apartment'] as List)
            .map((e) => ApartmentModel.fromJson(e))
            .toList();
    return {
      'resident': resident,
      'apartment': listApartment,
    };
  }

  // Sửa thông tin chủ hộ
  Future<bool> editChuHo({
    required String fullName,
    required String cccdCmt,
    required String phone,
    required String email,
    required String dob,
    required List<File> photos,
    required int
        type, //0: Thêm thành viên, 1: Chỉnh sửa thông tin thành viên, 2: Sửa thông tin chủ hộ
    String? relationshipType,
    String? apartmentId = '',
    String? residentId = '',
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
    try {
      // Chuyển đổi danh sách File -> List<MultipartFile>
      List<MultipartFile> photoFiles = await Future.wait(
        photos.map(
          (file) => MultipartFile.fromFile(file.path),
        ),
      );

      final formData = FormData.fromMap({
        'full_name': fullName,
        'cccd_cmt': cccdCmt,
        'phone': phone,
        'email': email,
        'dob': dob,
        'files[]': photoFiles,
      });
      // type, 0: Thêm thành viên, 1: Chỉnh sửa thông tin thành viên, 2: Sửa thông tin chủ hộ
      // mỗi type một api khác nhau
      //khai báo response
      Response response;
      if (type == 0) {
        formData.fields
            .add(MapEntry('relationship_type', relationshipType ?? 'other'));
        formData.fields.add(MapEntry('apartment_id', apartmentId ?? ''));
        response = await dio.post(ApiPath.addThanhVien, data: formData);
      } else if (type == 1) {
        formData.fields
            .add(MapEntry('relationship_type', relationshipType ?? 'other'));
        formData.fields.add(MapEntry('apartment_id', apartmentId ?? ''));
        response = await dio.post(ApiPath.editThanhVien, data: formData);
      } else {
        response = await dio.post(ApiPath.editChuho, data: formData);
      }
      return response.data['status'] == true;
    } on DioException {
      return false;
    } catch (e) {
      return false;
    }
  }

  // Xem chi tiết thanh vien
  Future<List<ResidentModel>> getApartmentResident(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.apartmentResident,
      data: {
        'apartment_id': int.parse(id),
      },
    );
    return (response.data['data']['value'] as List)
        .map((e) => ResidentModel.fromJson(e))
        .toList();
  }
}
