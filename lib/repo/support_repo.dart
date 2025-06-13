import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ha_duong/models/info_model.dart';
import 'package:ha_duong/models/suport_model.dart';
import 'package:ha_duong/utils/constants/api_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupportRepo {
  final dio = Dio();
  // call api to get support data
  Future<List<TechnicalSupportModel>> getSupportData(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.homeSupport,
      data: {
        'apartment_id': int.parse(id),
      },
    );
    return (response.data['data']['value'] as List)
        .map((e) => TechnicalSupportModel.fromJson(e))
        .toList();
  }

  Future<ListTechnicalSupportModel> getListSupport(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.listSupport,
      data: {
        'apartment_id': int.parse(id),
      },
    );
    return ListTechnicalSupportModel.fromJson(response.data['data']);
  }

  Future<List<RequestStatusModel>> getRequestStatus(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.supportDetail,
      data: {
        'id': int.parse(id),
      },
    );
    return (response.data['data']['technicalRequestsStatus'] as List)
        .map((e) => RequestStatusModel.fromJson(e))
        .toList();
  }

  Future<List<PostModel>> getDepartment(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.showSupportPopup,
      data: {
        'apartment_id': int.parse(id),
      },
    );
    return (response.data['data']['value'] as List)
        .map((e) => PostModel.fromJson(e))
        .toList();
  }

  Future<FullRequestModel> getShowRequest(String apartmentId, String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    // change timeout to 10 seconds
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.options.sendTimeout = const Duration(seconds: 10);
    Response response;
    response = await dio.post(
      ApiPath.showCreateSupport,
      data: {
        'apartment_id': int.parse(apartmentId),
        'id': int.parse(id),
      },
      // data: jsonEncode({
      //   'apartment_id': int.parse(apartmentId),
      //   'id': int.parse(id),
      // }),
    );
    return FullRequestModel.fromJson(response.data['data']);
  }

  Future<bool> createRequest({
    required String apartmentId,
    required String settingSupportId,
    required String settingSupportStateId,
    required String fullName,
    required String phone,
    required String note,
    required List<File> photos,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    List<MultipartFile> photoFiles = await Future.wait(
      photos.map(
        (file) => MultipartFile.fromFile(file.path),
      ),
    );
    final formData = FormData.fromMap({
      'apartment_id': int.parse(apartmentId),
      'setting_support_id': int.parse(settingSupportId),
      'setting_support_state_id': int.parse(settingSupportStateId),
      'full_name': fullName,
      'phone': phone,
      'note': note,
      'files[]': photoFiles, // 👈 Key dạng mảng (tùy theo server)
    });
    response = await dio.post(ApiPath.supportCreate, data: formData);
    return response.data['type'] == 'success';
  }
}
