import 'package:dio/dio.dart';
import 'package:ha_duong/models/info_model.dart';
import 'package:ha_duong/utils/constants/api_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepo {
  Dio dio = Dio();
  Future<InfoModel> getInfoCudan() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.home,
    );
    return InfoModel.fromJson(response.data['data']);
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
}
