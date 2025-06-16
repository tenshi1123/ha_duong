class TechnicalSupportModel {
  final String id;
  final String fullName;
  final String phone;
  final String note;
  final String img;
  final String createAt;
  final String settingSupportName;
  final String settingSupportStateName;
  final String? latestStatusName;
  final String? latestStatusType;
  TechnicalSupportModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.note,
    required this.img,
    required this.createAt,
    required this.settingSupportName,
    required this.settingSupportStateName,
    this.latestStatusName,
    this.latestStatusType,
  });
  factory TechnicalSupportModel.fromJson(Map<String, dynamic> json) {
    return TechnicalSupportModel(
      id: json['id'] ?? '',
      fullName: json['full_name'] ?? '',
      phone: json['phone'] ?? '',
      note: json['note'] ?? '',
      img: json['img'] ?? "[]",
      createAt: json['created_at'] ?? '',
      settingSupportName: json['setting_support_name'] ?? '',
      settingSupportStateName: json['setting_support_state_name'] ?? '',
      latestStatusName: json['latest_status_name'],
      latestStatusType: json['latest_status_type'],
    );
  }
}

class ListTechnicalSupportModel {
  final List<TechnicalSupportModel> listDangXuly;
  final List<TechnicalSupportModel> listHoanTat;

  ListTechnicalSupportModel({
    required this.listDangXuly,
    required this.listHoanTat,
  });
  factory ListTechnicalSupportModel.fromJson(Map<String, dynamic> json) {
    var dangXulyList = json['dang_xu_ly'] as List? ?? [];
    var hoanTatList = json['hoan_tat'] as List? ?? [];

    return ListTechnicalSupportModel(
      listDangXuly: dangXulyList
          .map((item) => TechnicalSupportModel.fromJson(item))
          .toList(),
      listHoanTat: hoanTatList
          .map((item) => TechnicalSupportModel.fromJson(item))
          .toList(),
    );
  }
}

class RequestStatusModel {
  final String name;
  final String createAt;
  final String type;
  RequestStatusModel({
    required this.name,
    required this.createAt,
    required this.type,
  });
  factory RequestStatusModel.fromJson(Map<String, dynamic> json) {
    return RequestStatusModel(
      name: json['name'] ?? '',
      createAt: json['created_at'] ?? '',
      type: json['type'] ?? '',
    );
  }
}

class SettingSupportState {
  final String id;
  final String settingSupportId;
  final String name;
  final String stt;
  final String isActive;
  final String createAt;
  final String updateAt;
  SettingSupportState({
    required this.id,
    required this.settingSupportId,
    required this.name,
    required this.stt,
    required this.isActive,
    required this.createAt,
    required this.updateAt,
  });
  factory SettingSupportState.fromJson(Map<String, dynamic> json) {
    return SettingSupportState(
      id: json['id'] ?? '',
      settingSupportId: json['setting_support_id'] ?? '',
      name: json['name'] ?? '',
      stt: json['stt'] ?? '',
      isActive: json['is_active'] ?? '',
      createAt: json['created_at'] ?? '',
      updateAt: json['updated_at'] ?? '',
    );
  }
}

class RequestModel {
  final String apartmentId;
  final String apartmentName;
  final String buildingAlias;
  final String fullName;
  final String phone;
  final String settingSupportId;

  RequestModel({
    required this.apartmentId,
    required this.apartmentName,
    required this.buildingAlias,
    required this.fullName,
    required this.phone,
    required this.settingSupportId,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      apartmentId: json['apartment_id'] ?? '',
      apartmentName: json['apartment_name'] ?? '',
      buildingAlias: json['building_alias'] ?? '',
      fullName: json['full_name'] ?? '',
      phone: json['phone'] ?? '',
      settingSupportId: json['setting_support_id'].toString(),
    );
  }
}

class FullRequestModel {
  final List<SettingSupportState> settingSupportStates;
  final RequestModel request;

  FullRequestModel({
    required this.settingSupportStates,
    required this.request,
  });

  factory FullRequestModel.fromJson(Map<String, dynamic> json) {
    return FullRequestModel(
      settingSupportStates:
          (json['settingSupportState'] as List<dynamic>? ?? [])
              .map((e) => SettingSupportState.fromJson(e))
              .toList(),
      request: RequestModel.fromJson(json['value']),
    );
  }
}
