import 'package:dio/dio.dart';
import 'package:ha_duong/bql_model/apartment_model.dart';
import 'package:ha_duong/bql_model/info_model_bql.dart';
import 'package:ha_duong/utils/constants/api_path_bql.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ApartmentRepo {
  Dio dio = Dio();
  Future<T?> getDetailApartment<T>(
    int id,
    int selectedIndex,
  ) async {
    final Map<int, String> typeMap = {
      0: 'home',
      1: 'cudan',
      2: 'phuongtien',
      3: 'phidichvu',
      4: 'sms',
      5: 'bienlai',
    };
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    // in ra log lỗi
    // dio.interceptors.add(LogInterceptor(
    //   responseBody: true,
    //   requestBody: true,
    //   logPrint: (obj) => debugPrint('📦 $obj'),
    // ));
    final String? type = typeMap[selectedIndex];
    if (type == null) return null;
    try {
      final response = await dio.post(
        ApiPathBql.detailApartment,
        // data: jsonEncode(
        //   {
        //     'id': id,
        //     'type': type,
        //   },
        // ),
        data: {
          'id': id,
          'type': type,
        },
      );
      if (response.statusCode == 200) {
        if (T == ApartmentDetailModel) {
          return ApartmentDetailModel.fromJson(response.data['data']['value'])
              as T;
        }
        if (T == List<CudanModel>) {
          return (response.data['data']['value'] as List)
              .map((e) => CudanModel.fromJson(e))
              .toList() as T;
        }
        if (T == List<PhuongTienModel>) {
          return (response.data['data']['value'] as List)
              .map((e) => PhuongTienModel.fromJson(e))
              .toList() as T;
        }
        if (T == List<PhiDichVuModel>) {
          return (response.data['data']['value'] as List)
              .map((e) => PhiDichVuModel.fromJson(e))
              .toList() as T;
        }
        if (T == List<SmsModel>) {
          return (response.data['data']['value'] as List)
              .map((e) => SmsModel.fromJson(e))
              .toList() as T;
        }
        if (T == List<BienLaiModel>) {
          return (response.data['data']['value'] as List)
              .map((e) => BienLaiModel.fromJson(e))
              .toList() as T;
        }

        throw Exception('Không có parser cho kiểu $T');
      } else {
        throw Exception('Lỗi server: ${response.statusCode}');
      }
    } catch (e) {
      return null;
    }
  }

  Future<AllReceiptDetailModel> getDetailReceipts(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPathBql.detailBienlai,
      data: {
        'receipts_id': int.parse(id),
      },
    );
    return AllReceiptDetailModel.fromJson(response.data['data']);
  }
}
