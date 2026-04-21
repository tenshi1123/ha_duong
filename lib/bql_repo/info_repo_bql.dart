import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ha_duong/bql_repo/login_repo_bql.dart';
import 'package:ha_duong/bql_model/info_model_bql.dart';
import 'package:ha_duong/utils/constants/api_path_bql.dart';

import 'package:shared_preferences/shared_preferences.dart';

class InfoRepo {
  Dio dio = Dio();
  Future<InfoModelBql?> getInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;

    try {
      response = await dio.post(
        ApiPathBql.profile,
      );
      return InfoModelBql.fromJson(response.data['data']['value']);
      //break;
    } on DioException {
      String newToken = await LoginRepoBql().refreshToken();
      if (newToken == '') {
        return null;
      }
      await prefs.setString('token', newToken);
      dio.options.headers['Authorization'] = 'Bearer $newToken';
      response = await dio.get(
        ApiPathBql.profile,
      );
      return InfoModelBql.fromJson(response.data['data']['value']);
    } catch (e) {
      await prefs.remove('token');
    }
    return null;
  }

  Future<String> changePassword(
      String oldPass, String password, String newPass) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response;
      response = await dio.post(ApiPathBql.changePassword, data: {
        'pass_old': oldPass,
        'passnew': password,
        're_passnew': newPass,
      });
      if (response.data['type'] == 'error') {
        return "Nhập lại mật khẩu mới và mật khẩu mới không khớp";
      } else if (response.data['type'] == 'success') {
        return "Đổi mật khẩu thành công";
      } else if (response.data['type'] == 'warning') {
        return "Mật khẩu cũ không đúng";
      }
      return "Đã có lỗi xảy ra, vui lòng thử lại sau";
    } catch (e) {
      return "Kiểm tra lại mật khẩu đã nhập";
    }
  }

  Future<String> changeInfo(
    String phone,
    String email,
    String name,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      Response response;
      response = await dio.post(ApiPathBql.editProfile, data: {
        'phone': phone,
        'email': email,
        'name': name,
      });
      if (response.data['type'] == 'error') {
        return "Đổi thông tin thất bại";
      } else if (response.data['type'] == 'success') {
        return "Đổi thông tin thành công";
      } else if (response.data['type'] == 'warning') {
        return "Đổi thông tin thất bại";
      }
      return "Đã có lỗi xảy ra, vui lòng thử lại sau";
    } catch (e) {
      return "Đổi thông tin thất bại";
    }
  }

  // cập nhật avatar
  Future<bool> changeAvatar(File file) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path),
      });
      final response = await dio.post(ApiPathBql.changeAvatar, data: formData);
      return response.data['status'] == true;
    } on DioException {
      return false;
    } catch (e) {
      return false;
    }
  }
}
