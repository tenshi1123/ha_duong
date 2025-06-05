import 'package:dio/dio.dart';
import 'package:ha_duong/models/apartment_model.dart';
import 'package:ha_duong/models/info_model.dart';
import 'package:ha_duong/repo/login_repo.dart';
import 'package:ha_duong/utils/constants/api_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepo {
  Dio dio = Dio();
  Future<InfoModel?> getInfoCudan() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;

    try {
      response = await dio.post(
        ApiPath.home,
      );
      return InfoModel.fromJson(response.data['data']);
      //break;
    } on DioException {
      String newToken = await LoginRepo().refreshToken();
      if (newToken == '') {
        return null;
      }
      await prefs.setString('token', newToken);
      dio.options.headers['Authorization'] = 'Bearer $newToken';
      response = await dio.get(
        ApiPath.home,
      );
      return InfoModel.fromJson(response.data['data']);
    } catch (e) {
      await prefs.remove('token');
    }
    return null;
  }

  Future<ListReceiptsModel> getListReceipts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.receipts,
    );
    return ListReceiptsModel.fromJson(response.data['data']);
  }

  Future<ReceiptsDetailModel> getDetailReceipts(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.receiptDetail,
      data: {
        'receipts_id': int.parse(id),
      },
    );
    return ReceiptsDetailModel.fromJson(response.data['data']['value']);
  }

  Future<List<PostModel>> getUtilities(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.utilities,
      data: {
        'apartment_id': int.parse(id),
      },
    );
    return (response.data['data']['value'] as List)
        .map((e) => PostModel.fromJson(e))
        .toList();
  }

  Future<PostModel> getDetailPostModel(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.postDetail,
      data: {
        'id': int.parse(id),
      },
    );
    return PostModel.fromJson(response.data['data']['post']);
  }

  Future<UtilitiesModel> getUtilitiesDetail(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.utilitiesDetail,
      data: {
        'id': int.parse(id),
      },
    );
    return UtilitiesModel.fromJson(response.data['data']['value']);
  }

  //show dang ky
  Future<DangKyModel> showDangKy(String id, String apartmentId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.showDangKy,
      data: {
        'id': int.parse(id),
        'apartment_id': int.parse(apartmentId),
      },
    );
    return DangKyModel.fromJson(response.data['data']['value']);
  }

  //send dang ky
  Future sendDangKy(
      String id, String apartmentId, String name, String phone) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      await dio.post(
        ApiPath.sendDangKy,
        data: {
          'id': int.parse(id),
          'apartment_id': int.parse(apartmentId),
          'full_name': name,
          'phone': phone,
        },
      );
    } on DioException {
      return false;
    }
    return true;
  }
}
