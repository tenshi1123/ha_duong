import 'package:ha_duong/bql_model/technical_requests_model.dart';

class ApartmentItem {
  final String name;
  final String building;
  final String owner;
  final String phone;
  final int floor;
  final int people;
  final int vehicles;
  final String status;
  final String usage;
  bool isExpanded;

  ApartmentItem({
    required this.name,
    required this.building,
    required this.owner,
    required this.phone,
    required this.floor,
    required this.people,
    required this.vehicles,
    required this.status,
    required this.usage,
    this.isExpanded = false,
  });
}

class DichVu {
  final String tenCanHo;
  final String tenToaNha;
  final int dienDauKi;
  final int dienCuoiKi;
  final int nuocDauKi;
  final int nuocCuoiKi;
  bool isExpanded;

  DichVu({
    required this.tenCanHo,
    required this.tenToaNha,
    required this.dienDauKi,
    required this.dienCuoiKi,
    required this.nuocDauKi,
    required this.nuocCuoiKi,
    this.isExpanded = false,
  });
}

class HomeModel {
  final List<BuildingModel> listBuilding;
  final List<TechnicalSupportModel> listTechnicalRequests;
  final List<TechnicalSupportModel> listTechnicalRequestsChuaHT;
  final List<CategoryModel> listCategoryModel;
  final List<PostModel> listPostModel;
  HomeModel({
    required this.listBuilding,
    required this.listTechnicalRequests,
    required this.listTechnicalRequestsChuaHT,
    required this.listCategoryModel,
    required this.listPostModel,
  });
  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      listBuilding: (json['building'] as List<dynamic>? ?? [])
          .map((x) => BuildingModel.fromJson(x))
          .toList(),
      listTechnicalRequests: (json['technicalRequests'] as List<dynamic>? ?? [])
          .map((x) => TechnicalSupportModel.fromJson(x))
          .toList(),
      listTechnicalRequestsChuaHT:
          (json['technicalRequestsChuaHT'] as List<dynamic>? ?? [])
              .map((x) => TechnicalSupportModel.fromJson(x))
              .toList(),
      listCategoryModel: (json['category'] as List<dynamic>? ?? [])
          .map((x) => CategoryModel.fromJson(x))
          .toList(),
      listPostModel: (json['post'] as List<dynamic>? ?? [])
          .map((x) => PostModel.fromJson(x))
          .toList(),
    );
  }
}

class BuildingModel {
  final String id;
  final String name;
  final String alias;
  final String time;
  BuildingModel({
    required this.id,
    required this.name,
    required this.alias,
    required this.time,
  });
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuildingModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
  factory BuildingModel.fromJson(Map<String, dynamic> json) {
    return BuildingModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      alias: json['alias'] ?? '',
      time: json['time'] ?? '',
    );
  }
}

class CategoryModel {
  final String id;
  final String name;

  CategoryModel({
    required this.id,
    required this.name,
  });
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class StatusModel {
  final int value;
  final String name;

  StatusModel({
    required this.value,
    required this.name,
  });
  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      value: json['value'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class PostModel {
  final String id;
  final String img;
  final String name;
  final String content;
  final String updatedAt;
  final String createAt;
  String type;
  String? urlFile;
  PostModel({
    required this.id,
    required this.img,
    required this.name,
    required this.content,
    required this.updatedAt,
    required this.createAt,
    this.type = '0',
    this.urlFile,
  });
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? '',
      img: json['img'] ?? '',
      name: json['name'] ?? '',
      content: json['content'] ?? '',
      updatedAt: json['update_at'] ?? '',
      createAt: json['created_at'] ?? '',
      type: json['type'] ?? '0',
      urlFile: json['url_file'],
    );
  }
}

class DienNuocModel {
  final int total;
  final int page;
  final int pageSize;
  final List<ReceiptsModel> listReceipts;

  DienNuocModel({
    required this.total,
    required this.page,
    required this.pageSize,
    required this.listReceipts,
  });
  factory DienNuocModel.fromJson(Map<String, dynamic> json) {
    return DienNuocModel(
      total: json['total_offer'] ?? 0,
      page: json['page'] ?? 0,
      pageSize: json['page_size'] ?? 0,
      listReceipts: (json['value'] as List<dynamic>? ?? [])
          .map((x) => ReceiptsModel.fromJson(x))
          .toList(),
    );
  }
}

class ReceiptsModel {
  final String buildingName;
  final String buildingAlias;
  final String apartmentName;
  final String dienCsc;
  final String dienCsm;
  final String dienTieuThu;
  final String nuocCsc;
  final String nuocCsm;
  final String nuocTieuThu;
  bool isExpanded = false;
  ReceiptsModel({
    required this.buildingName,
    required this.buildingAlias,
    required this.apartmentName,
    required this.dienCsc,
    required this.dienCsm,
    required this.dienTieuThu,
    required this.nuocCsc,
    required this.nuocCsm,
    required this.nuocTieuThu,
  });

  factory ReceiptsModel.fromJson(Map<String, dynamic> json) {
    return ReceiptsModel(
      buildingName: json['building_name'] ?? '',
      buildingAlias: json['building_alias'] ?? '',
      apartmentName: json['apartment_name'] ?? '',
      dienCsc: json['dien_csc'] ?? '',
      dienCsm: json['dien_csm'] ?? '',
      dienTieuThu: json['dien_tieu_thu'] ?? '',
      nuocCsc: json['nuoc_csc'] ?? '',
      nuocCsm: json['nuoc_csm'] ?? '',
      nuocTieuThu: json['nuoc_tieu_thu'] ?? '',
    );
  }
}

class ApartmentModel {
  final String id;
  final String name;
  final String numberFloor;
  final String totalPhuongTien;
  final String totalPeople;
  final String buildingName;
  final String fullName;
  final String phone;
  final String purposes;
  final String apartmentStatus;
  bool isExpanded = false;
  ApartmentModel({
    required this.id,
    required this.name,
    required this.numberFloor,
    required this.totalPhuongTien,
    required this.totalPeople,
    required this.buildingName,
    required this.fullName,
    required this.phone,
    required this.purposes,
    required this.apartmentStatus,
  });
  factory ApartmentModel.fromJson(Map<String, dynamic> json) {
    return ApartmentModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      numberFloor: json['number_floors'] ?? '',
      totalPhuongTien: json['total_phuong_tien']?.toString() ?? '0',
      totalPeople: json['total_so_nguoi']?.toString() ?? '0',
      buildingName: json['building_name'] ?? '',
      fullName: json['full_name'] ?? '',
      phone: json['phone'] ?? '',
      purposes: json['purpose_use_name'] ?? '',
      apartmentStatus: json['apartment_status'] ?? '',
    );
  }
}

class ExtensionModel {
  final String buildingUtilitiesName;
  final String apartmentName;
  final String id;
  final String buildingUtilitiesId;
  final String fullName;
  final String phone;
  final String createAt;
  final String note;

  ExtensionModel({
    required this.buildingUtilitiesName,
    required this.apartmentName,
    required this.id,
    required this.buildingUtilitiesId,
    required this.fullName,
    required this.phone,
    required this.createAt,
    required this.note,
  });
  factory ExtensionModel.fromJson(Map<String, dynamic> json) {
    return ExtensionModel(
      buildingUtilitiesName: json['building_utilities_name'] ?? '',
      apartmentName: json['apartment_name'] ?? '',
      id: json['id'] ?? '',
      buildingUtilitiesId: json['building_utilities_id'] ?? '',
      fullName: json['full_name'] ?? '',
      phone: json['phone'] ?? '',
      createAt: json['created_at'] ?? '',
      note: json['note'] ?? '',
    );
  }
}
