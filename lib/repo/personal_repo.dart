import 'package:dio/dio.dart';
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

  // ví dụ thôi
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
}
