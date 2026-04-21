import 'package:dio/dio.dart';
import 'package:ha_duong/bql_model/home_model.dart';
import 'package:ha_duong/bql_repo/login_repo_bql.dart';
import 'package:ha_duong/utils/constants/api_path_bql.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HomeRepo {
  Dio dio = Dio();
  Future<HomeModel?> getHomeModel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;

    try {
      response = await dio.post(
        ApiPathBql.home,
      );
      return HomeModel.fromJson(response.data['data']);
      //break;
    } on DioException {
      String newToken = await LoginRepoBql().refreshToken();
      if (newToken == '') {
        return null;
      }
      await prefs.setString('token', newToken);
      dio.options.headers['Authorization'] = 'Bearer $newToken';
      response = await dio.get(
        ApiPathBql.home,
      );
      return HomeModel.fromJson(response.data['data']);
    } catch (e) {
      await prefs.remove('token');
    }
    return null;
  }

  Future<DienNuocModel> getPageDienNuoc(
      {required int page,
      required int show,
      required int buildingId,
      required int receiptId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPathBql.loadDienNuoc,
      data: {
        'page': page,
        'show': show,
        'building_id': buildingId,
        'receipt_id': receiptId
      },
    );
    return DienNuocModel.fromJson(response.data['data']);
  }

  Future<List<BuildingModel>> getListBuilding(
      {required String buildingId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;

    try {
      response = await dio.post(
        ApiPathBql.changeBuildingDienNuoc,
        data: {
          'building_id': int.tryParse(buildingId),
        },
      );
      return (response.data['data']['receipt'] as List)
          .map((e) => BuildingModel.fromJson(e))
          .toList();
    } on DioException {
      response = await dio.post(
        ApiPathBql.changeBuildingDienNuoc,
      );
      return (response.data['data']['receipt'] as List)
          .map((e) => BuildingModel.fromJson(e))
          .toList();
    } catch (e) {
      await prefs.remove('token');
    }
    return [];
  }

  Future<List<StatusModel>> getListStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    try {
      response = await dio.post(
        ApiPathBql.apartment,
      );
      return (response.data['data']['status'] as List)
          .map((e) => StatusModel.fromJson(e))
          .toList();
    } catch (e) {
      await prefs.remove('token');
    }
    return [];
  }

  Future<List<PostModel>> getPurposeUse(String buildingId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    try {
      response = await dio.post(
        ApiPathBql.changeApartment,
        data: {
          'building_id': int.tryParse(buildingId),
        },
      );
      return (response.data['data']['purposeUse'] as List)
          .map((e) => PostModel.fromJson(e))
          .toList();
    } catch (e) {
      await prefs.remove('token');
    }
    return [];
  }

  Future<List<ApartmentModel>> getListApartment({
    required int page,
    required int show,
    required int buildingId,
    int? status,
    int? purposeUseId,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPathBql.loadApartment,
      data: {
        'page': page,
        'show': show,
        'building_id': buildingId,
        'status': status ?? '',
        'purpose_use_id': purposeUseId ?? '',
      },
    );
    return (response.data['data']['value'] as List)
        .map((e) => ApartmentModel.fromJson(e))
        .toList();
  }

  Future<List<PostModel>> changeCategory(
      {required String apartmentId, required String categoryId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPathBql.changeCategory,
      data: {
        'building_id': int.parse(apartmentId),
        'category_id': int.parse(categoryId),
      },
    );
    return (response.data['data']['post'] as List)
        .map((e) => PostModel.fromJson(e))
        .toList();
  }

  Future<HomeModel> changeBuilding(
      {required String buildingId,
      required List<BuildingModel> listBuilding}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPathBql.changeBuilding,
      data: {
        'building_id': int.parse(buildingId),
      },
    );
    final partialHome = HomeModel.fromJson(response.data['data']);
    final fullHome = HomeModel(
      listBuilding: listBuilding,
      listTechnicalRequests: partialHome.listTechnicalRequests,
      listTechnicalRequestsChuaHT: partialHome.listTechnicalRequestsChuaHT,
      listCategoryModel: partialHome.listCategoryModel,
      listPostModel: partialHome.listPostModel,
    );
    return fullHome;
  }

  Future<PostModel> getDetailPostModel(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPathBql.postDetail,
      data: {
        'id': int.parse(id),
      },
    );
    return PostModel.fromJson(response.data['data']['post']);
  }

  Future<List<ExtensionModel>> getListTechnicalRequests(
      {required String buildingId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    //try {
    response = await dio.post(
      ApiPathBql.listTienIch,
      data: {
        "page": 1,
        "show": 25,
        "building_id": buildingId,
      },
    );
    return (response.data['value'] as List)
        .map((e) => ExtensionModel.fromJson(e))
        .toList();
  }
}
