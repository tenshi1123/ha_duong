class ApartmentModel {
  final String id;
  final String buildingId;
  final String name;
  final String numberFloors;
  final String acreage;
  final String buildingAlias;
  final String totalResidents;
  final String statusText;
  ApartmentModel({
    required this.id,
    required this.buildingId,
    required this.name,
    required this.numberFloors,
    required this.acreage,
    required this.buildingAlias,
    required this.totalResidents,
    required this.statusText,
  });
  factory ApartmentModel.fromJson(Map<String, dynamic> json) {
    return ApartmentModel(
      id: json['id'] ?? '',
      buildingId: json['building_id'] ?? '',
      name: json['name'] ?? '',
      numberFloors: json['number_floors'] ?? '',
      acreage: json['acreage'] ?? '',
      buildingAlias: json['building_alias'] ?? '',
      totalResidents: json['total_residents'] ?? '',
      statusText: json['status_text'] ?? '',
    );
  }
}

class VehicleModel {
  final String fullName;
  final String phone;
  final String email;
  final String vehicleId;
  final String vehicleName;
  final String fee;
  final String licensePlates;
  final String createAt;
  final String buildingId;
  final String apartmentName;
  final String purposeUseId;
  VehicleModel({
    required this.fullName,
    required this.phone,
    required this.email,
    required this.vehicleId,
    required this.vehicleName,
    required this.fee,
    required this.licensePlates,
    required this.createAt,
    required this.buildingId,
    required this.apartmentName,
    required this.purposeUseId,
  });
  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      fullName: json['full_name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      vehicleId: json['vehicle_id'] ?? '',
      vehicleName: json['vehicle_name'] ?? '',
      fee: json['fee'] ?? json["price"] ?? '',
      licensePlates: json['license_plates'] ?? '',
      createAt: json['created_at'] ?? '',
      buildingId: json['building_id'] ?? '',
      apartmentName: json['apartment_name'] ?? '',
      purposeUseId: json['purpose_use_id'] ?? '',
    );
  }
}

class DangKyModel {
  final String apartmentId;
  final String apartmentName;
  final String buildingAlias;
  final String fullName;
  final String phone;
  final String id;

  DangKyModel({
    required this.apartmentId,
    required this.apartmentName,
    required this.buildingAlias,
    required this.fullName,
    required this.phone,
    required this.id,
  });
  factory DangKyModel.fromJson(Map<String, dynamic> json) {
    return DangKyModel(
      apartmentId: json['apartment_id'] ?? '',
      apartmentName: json['apartment_name'] ?? '',
      buildingAlias: json['building_alias'] ?? '',
      fullName: json['full_name'] ?? '',
      phone: json['phone'] ?? '',
      id: json['id'].toString(),
    );
  }
  //tojson
  Map<String, dynamic> toJson() {
    return {
      'apartment_id': apartmentId,
      'apartment_name': apartmentName,
      'building_alias': buildingAlias,
      'full_name': fullName,
      'phone': phone,
      'id': id,
    };
  }
}
