import 'dart:convert';

class TechnicalSupportModel {
  final String id;
  final String apartmentName;
  final String buildingName;
  final String buildingAlias;
  final String settingSupportName;
  final String settingSupportStateName;
  final String fullName;
  final String phone;
  final String note;
  final String img;
  final DateTime createdAt;
  final String lastestStatusName;
  final String lastestStatusType;
  TechnicalSupportModel({
    required this.id,
    required this.apartmentName,
    required this.buildingName,
    required this.buildingAlias,
    required this.settingSupportName,
    required this.settingSupportStateName,
    required this.fullName,
    required this.phone,
    required this.note,
    required this.img,
    required this.createdAt,
    required this.lastestStatusName,
    required this.lastestStatusType,
  });

  factory TechnicalSupportModel.fromJson(Map<String, dynamic> json) {
    return TechnicalSupportModel(
      id: json["id"] ?? '',
      apartmentName: json["apartment_name"] ?? '',
      buildingName: json["building_name"] ?? '',
      buildingAlias: json["building_alias"] ?? '',
      settingSupportName: json["setting_support_name"] ?? '',
      settingSupportStateName: json["setting_support_state_name"] ?? '',
      fullName: json["full_name"] ?? '',
      phone: json["phone"] ?? '',
      note: json["note"] ?? '',
      img: json["img"] ?? "[]",
      createdAt: DateTime.parse(json["created_at"] ?? '20120227'),
      lastestStatusName: json["latest_status_name"] ?? 'Chưa xử lý',
      lastestStatusType: json["latest_status_type"] ?? '',
    );
  }
}

class SettingSuppportStatus {
  final String id;
  final String name;
  final String stt;
  final String type;
  SettingSuppportStatus({
    required this.id,
    required this.name,
    required this.stt,
    required this.type,
  });
  factory SettingSuppportStatus.fromJson(Map<String, dynamic> json) {
    return SettingSuppportStatus(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      stt: json['stt'] ?? '',
      type: json['type'] ?? '',
    );
  }
}

class RequestStatusModel {
  final String name;
  final DateTime createAt;
  final String type;
  String? img;
  RequestStatusModel({
    required this.name,
    required this.createAt,
    required this.type,
    this.img,
  });
  factory RequestStatusModel.fromJson(Map<String, dynamic> json) {
    final rawImg = json['note_img'];
    List<String> images = [];
    if (rawImg != null && rawImg.toString().trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(rawImg.toString());
        if (decoded is List) {
          images = decoded.map((e) => e.toString()).toList();
        }
      } catch (e) {
        images = [];
      }
    }
    return RequestStatusModel(
      name: json['name'] ?? '',
      createAt: DateTime.parse(json['created_at'] ?? '2832000'),
      type: json['type'] ?? '',
      img: json['note_img'] ?? "[]",
    );
  }
}

class DetailRequestModel {
  final TechnicalSupportModel value;
  final List<SettingSuppportStatus> listStatus;
  final List<RequestStatusModel> listLastStatus;
  DetailRequestModel({
    required this.value,
    required this.listStatus,
    required this.listLastStatus,
  });
  factory DetailRequestModel.fromJson(Map<String, dynamic> json) {
    return DetailRequestModel(
      value: TechnicalSupportModel.fromJson(json['value']),
      listStatus: (json['settingSupportStatus'] as List<dynamic>? ?? [])
          .map((x) => SettingSuppportStatus.fromJson(x))
          .toList(),
      listLastStatus: (json['technicalRequestsStatus'] as List<dynamic>? ?? [])
          .map((x) => RequestStatusModel.fromJson(x))
          .toList(),
    );
  }
}
