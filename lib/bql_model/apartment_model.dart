class ApartmentDetailModel {
  final String id;
  final String name;
  final String numberFloor;
  final String acreage;
  final String apartmentStatus;
  final String purposeUseName;

  ApartmentDetailModel({
    required this.id,
    required this.name,
    required this.numberFloor,
    required this.acreage,
    required this.apartmentStatus,
    required this.purposeUseName,
  });
  factory ApartmentDetailModel.fromJson(Map<String, dynamic> json) {
    return ApartmentDetailModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      numberFloor: json['number_floors'] ?? '',
      acreage: json['acreage'] ?? '',
      apartmentStatus: json['apartment_status'] ?? '',
      purposeUseName: json['purpose_use_name'] ?? '',
    );
  }
}

class CudanModel {
  final String fullName;
  final String phone;
  final String email;
  final String dob;
  final String cccd;
  final String relaName;

  CudanModel({
    required this.fullName,
    required this.phone,
    required this.email,
    required this.dob,
    required this.cccd,
    required this.relaName,
  });
  factory CudanModel.fromJson(Map<String, dynamic> json) {
    return CudanModel(
      fullName: json['full_name'] ?? 'Chưa có dữ liệu',
      phone: json['phone'] ?? 'Chưa có dữ liệu',
      email: json['email'] ?? 'Chưa có dữ liệu',
      dob: json['dob'] ?? 'Chưa có dữ liệu',
      cccd: json['cccd_cmt'] ?? 'Chưa có dữ liệu',
      relaName: json['relationship_name'] ?? 'Chưa có dữ liệu',
    );
  }
}

class PhuongTienModel {
  final String vehicleName;
  final String fullName;
  final String phone;
  final String licensePlates;
  final String createAt;
  final String price;

  PhuongTienModel({
    required this.vehicleName,
    required this.fullName,
    required this.phone,
    required this.licensePlates,
    required this.createAt,
    required this.price,
  });
  factory PhuongTienModel.fromJson(Map<String, dynamic> json) {
    return PhuongTienModel(
      vehicleName: json['vehicle_name'] ?? '',
      fullName: json['full_name'] ?? '',
      phone: json['phone'] ?? '',
      licensePlates: json['license_plates'] ?? '',
      createAt: json['create_at'] ?? '',
      price: json['price']?.toString() ?? '0',
    );
  }
}

class PhiDichVuModel {
  final String receiptName;
  final String fee;
  final String feePaid;
  final String sms;
  final String email;
  final String status;
  bool isExpanded = false;
  PhiDichVuModel({
    required this.receiptName,
    required this.fee,
    required this.feePaid,
    required this.sms,
    required this.email,
    required this.status,
  });
  factory PhiDichVuModel.fromJson(Map<String, dynamic> json) {
    return PhiDichVuModel(
      receiptName: json['receipt_name'] ?? '',
      fee: json['fee'] ?? '',
      feePaid: json['fee_paid'] ?? '',
      sms: json['total_sms_receipts'] ?? '',
      email: json['total_email_resident'] ?? '',
      status: json['receipts_text_status'] ?? '',
    );
  }
}

class SmsModel {
  final String userName;
  final String id;
  final String content;
  final String apartmentId;
  final String phone;
  final String userId;
  final String type;
  final String status;
  final DateTime createdAt;
  bool isExpanded = false;
  SmsModel({
    required this.userName,
    required this.id,
    required this.content,
    required this.apartmentId,
    required this.phone,
    required this.userId,
    required this.type,
    required this.status,
    required this.createdAt,
  });

  factory SmsModel.fromJson(Map<String, dynamic> json) {
    String parsedType;
    switch (json['type']) {
      case '0':
        parsedType = 'zaloZNS';
        break;
      case '1':
        parsedType = 'brandSms';
        break;
      default:
        parsedType = 'unknown';
    }

    String parsedStatus;
    switch (json['status']) {
      case '0':
        parsedStatus = 'Gửi thành công';
        break;
      default:
        parsedStatus = 'Gửi thất bại';
    }

    return SmsModel(
      userName: json['user_name'],
      id: json['id'],
      content: json['content'],
      apartmentId: json['apartment_id'],
      phone: json['phone'],
      userId: json['user_id'],
      type: parsedType,
      status: parsedStatus,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class BienLaiModel {
  final String receiptName;
  final String id;
  final String appartmentName;
  final String acreage;
  final String purposeUseName;
  final String totalFee;
  final String totalSmsReceipts;
  final String paymentTypeText;
  final String receiptsTextStatus;
  final String phoneChuHo;
  bool isExpanded = false;
  BienLaiModel({
    required this.receiptName,
    required this.id,
    required this.appartmentName,
    required this.acreage,
    required this.purposeUseName,
    required this.totalFee,
    required this.totalSmsReceipts,
    required this.paymentTypeText,
    required this.receiptsTextStatus,
    required this.phoneChuHo,
  });
  factory BienLaiModel.fromJson(Map<String, dynamic> json) {
    return BienLaiModel(
        receiptName: json['receipt_name'] ?? '',
        id: json['id'] ?? '',
        appartmentName: json['apartment_name'] ?? '',
        acreage: json['acreage'] ?? '',
        purposeUseName: json['purpose_use_name'] ?? '',
        totalFee: json['total_fee'] ?? '',
        totalSmsReceipts: json['total_sms_receipts'] ?? '',
        paymentTypeText: json['payment_type_text'] ?? '',
        receiptsTextStatus: json['receipts_text_status'] ?? '',
        phoneChuHo: json['chu_ho_phone'] ?? '');
  }
}
