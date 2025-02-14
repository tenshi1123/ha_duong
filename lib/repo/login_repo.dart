import 'package:dio/dio.dart';

import '../models/info_model.dart';
import '../utils/constants/api_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepo {
  Dio dio = Dio();
  Future<bool> login(String phone, String password) async {
    Response response;
    var formData = FormData.fromMap({
      'phone': phone,
      'password': password,
    });
    try {
      response = await dio.post(
        ApiPath.login,
        data: formData,
      );
    } on DioException {
      return false;
    }
    if (response.data['status'] == false) {
      return false;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', response.data['data']["refresh_token"]);
    return response.data['data']["refresh_token"] != null;
  }

  Future<bool> loginParent(String phone, String password) async {
    Response response;
    var formData = FormData.fromMap({
      'phone': phone,
      'password': password,
    });
    try {
      response = await dio.post(
        ApiPath.loginParent,
        data: formData,
      );
    } on DioException {
      return false;
    }
    if (response.data['status'] == false) {
      return false;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'token_parent', response.data['data']["refresh_token"]);
    return response.data['data']["refresh_token"] != null;
  }

  Future<List<ChildrenInfoModel>> getListChillren() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token_parent');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.get(
      ApiPath.getlistChildren,
    );
    List<ChildrenInfoModel> result = ((response.data)['data'] as List)
        .map((e) => ChildrenInfoModel.fromJson(e))
        .toList();
    return result;
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

  Future<String> contactLearned(String phone, String fullName) async {
    Response response;
    var formData = FormData.fromMap({
      'phone': phone,
      'full_name': fullName,
    });
    try {
      response = await dio.post(
        ApiPath.learned,
        data: formData,
      );
    } on DioException {
      return '';
    }
    return response.data["message"];
  }

  Future<String> contactAdd(String phone, String fullName, String className,
      String subject, String typePerson) async {
    Response response;
    var formData = FormData.fromMap({
      "full_name": fullName,
      "phone": phone,
      "class": className,
      "subject": subject,
      "type_person": typePerson,
    });
    try {
      response = await dio.post(
        ApiPath.contact,
        data: formData,
      );
    } on DioException {
      return '';
    }
    return response.data["message"];
  }

  Future<String> getToken() async {
    final response = await Dio()
        .get('https://61df53d20f3bdb0017934a35.mockapi.io/se06/swaper');
    String mocktoken = response.data[0]['token'].toString();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', mocktoken);
    return mocktoken;
  }

  Future pushOnesignalId(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    var formData = FormData.fromMap({
      'onesignal_id': id,
    });

    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
      try {
        await dio.post(ApiPath.pushOnsignalId, data: formData);
      } on DioException {
        return false;
      }
    }
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

  Future<List<String>> getListBanner() async {
    Response response;
    response = await dio.get(ApiPath.getBanner);
    List<String> result = ((response.data)['data'] as List)
        .map((e) => e['img_desktop'].toString())
        .toList();
    return result;
  }
}
