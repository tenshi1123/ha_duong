import 'dart:convert';

class InfoModelBql {
  final String avatar;
  String name;
  String phone;
  String email;
  final String chucVu;
  final String code;

  InfoModelBql({
    required this.avatar,
    required this.name,
    required this.phone,
    required this.email,
    required this.chucVu,
    required this.code,
  });
  factory InfoModelBql.fromJson(Map<String, dynamic> json) {
    return InfoModelBql(
      avatar: json['avatar'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      chucVu: json['position_name'] ?? '',
      code: json['code'] ?? '',
    );
  }
}

class NotiValueModel {
  final String id;
  final String title;
  final String content;
  final String type;
  final DateTime createdAt;
  final String isActive;
  NotiValueModel({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    required this.createdAt,
    required this.isActive,
  });
  factory NotiValueModel.fromJson(Map<String, dynamic> json) {
    return NotiValueModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      type: json['type'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? ''),
      isActive: json['is_active'] ?? '0',
    );
  }
}

class NotiTypeModel {
  final int value;
  final String name;
  final String total;
  NotiTypeModel({
    required this.value,
    required this.name,
    required this.total,
  });
  factory NotiTypeModel.fromJson(Map<String, dynamic> json) {
    return NotiTypeModel(
        value: json['value'] ?? 0,
        name: json['name'] ?? '',
        total: json['total'] ?? '');
  }
}

class ResidentPendingModel {
  final String id;
  final String fullName;
  final String phone;
  final String email;
  final String status;
  final String type;
  final String typeName;
  final String text;
  ResidentPendingModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.status,
    required this.type,
    required this.typeName,
    required this.text,
  });
  factory ResidentPendingModel.fromJson(Map<String, dynamic> json) {
    return ResidentPendingModel(
      id: json['id'] ?? 0,
      fullName: json['full_name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      status: json['status'] ?? '',
      type: json['type'] ?? '',
      typeName: json['type_name'] ?? '',
      text: json['text'] ?? '',
    );
  }
}

class DetailPendingModel {
  final String id;
  final String residentId;
  final String? apartmentId;
  final String fullName;
  final String phone;
  final String email;
  final String dob;
  final String cccdCmt;
  final List<String> img;
  final String relationshipType;
  final String type;
  final String status;
  final OldResidentData? oldData;
  final String createdAt;
  final String updatedAt;
  final String? modifiedBy;

  // Các trường bạn tự thêm:
  final String typeName;
  final String text;

  DetailPendingModel({
    required this.id,
    required this.residentId,
    required this.apartmentId,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.dob,
    required this.cccdCmt,
    required this.img,
    required this.relationshipType,
    required this.type,
    required this.status,
    required this.oldData,
    required this.createdAt,
    required this.updatedAt,
    required this.modifiedBy,
    required this.typeName,
    required this.text,
  });

  factory DetailPendingModel.fromJson(Map<String, dynamic> json) {
    return DetailPendingModel(
      id: json['id'] ?? '',
      residentId: json['resident_id'] ?? '',
      apartmentId: json['apartment_id'],
      fullName: json['full_name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      dob: json['dob'] ?? '',
      cccdCmt: json['cccd_cmt'] ?? '',
      img: _parseImgList(json['img'] ?? '[]'),
      relationshipType: json['relationship_type'] ?? '',
      type: json['type'] ?? '',
      status: json['status'] ?? '',
      oldData: _parseOldData(json['old_data']),
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      modifiedBy: json['modified_by'],
      typeName: json['type_name'] ?? '',
      text: json['text'] ?? '',
    );
  }

  static List<String> _parseImgList(dynamic rawImg) {
    if (rawImg is String && rawImg.isNotEmpty) {
      try {
        List<dynamic> list = json.decode(rawImg);
        return List<String>.from(list);
      } catch (_) {
        return [];
      }
    }
    return [];
  }

  static OldResidentData? _parseOldData(dynamic raw) {
    if (raw is String && raw.isNotEmpty) {
      try {
        final data = json.decode(raw);
        return OldResidentData.fromJson(data);
      } catch (_) {
        return null;
      }
    }
    return null;
  }
}

class OldResidentData {
  final String fullName;
  final String phone;
  final String email;
  final String dob;
  final String cccdCmt;
  final String? img;

  OldResidentData({
    required this.fullName,
    required this.phone,
    required this.email,
    required this.dob,
    required this.cccdCmt,
    this.img,
  });

  factory OldResidentData.fromJson(Map<String, dynamic> json) {
    return OldResidentData(
      fullName: json['full_name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      dob: json['dob'] ?? '',
      cccdCmt: json['cccd_cmt'] ?? '',
      img: json['img'],
    );
  }
}

class AllReceiptDetailModel {
  final PaymentInforModel paymentInforModel;
  final ReceiptsDetailModel receiptsDetailModel;
  final List<ChiTietMucDienNuoc> receiptsDien;
  final List<ChiTietMucDienNuoc> receiptsNuoc;
  AllReceiptDetailModel({
    required this.paymentInforModel,
    required this.receiptsDetailModel,
    required this.receiptsDien,
    required this.receiptsNuoc,
  });
  factory AllReceiptDetailModel.fromJson(Map<String, dynamic> json) {
    return AllReceiptDetailModel(
      paymentInforModel: PaymentInforModel.fromJson(json['apartment'] ?? {}),
      receiptsDetailModel: ReceiptsDetailModel.fromJson(json['value'] ?? {}),
      receiptsDien: (json['receiptsDien'] as List<dynamic>? ?? [])
          .map((x) => ChiTietMucDienNuoc.fromJson(x))
          .toList(),
      receiptsNuoc: (json['receiptsNuoc'] as List<dynamic>? ?? [])
          .map((x) => ChiTietMucDienNuoc.fromJson(x))
          .toList(),
    );
  }
}

class PaymentInforModel {
  final String buildingName;
  final String alias;
  final String address;
  final String bankName;
  final String accName;
  final String accNumber;
  final String branch;
  final String bankCode;
  final String hotline;
  final String note;
  final String title;
  final String logo;
  final String apartmentName;

  PaymentInforModel({
    required this.buildingName,
    required this.alias,
    required this.address,
    required this.bankName,
    required this.accName,
    required this.accNumber,
    required this.branch,
    required this.bankCode,
    required this.hotline,
    required this.note,
    required this.title,
    required this.logo,
    required this.apartmentName,
  });
  factory PaymentInforModel.fromJson(Map<String, dynamic> json) {
    return PaymentInforModel(
      buildingName: json['building_name'] ?? '',
      alias: json['alias'] ?? '',
      address: json['address'] ?? '',
      bankName: json['bank_name'] ?? '',
      accName: json['acc_name'] ?? '',
      accNumber: json['acc_number'] ?? '',
      branch: json['branch'] ?? '',
      bankCode: json['bank_code'] ?? '',
      hotline: json['hotline'] ?? '',
      note: json['note'] ?? '',
      title: json['title'] ?? '',
      logo: json['logo'] ?? '',
      apartmentName: json['apartment_name'] ?? '',
    );
  }
}

class ReceiptsDetailModel {
  final String userName;
  final String receiptsTime;
  final String hanThanhToan;
  final String startDay;
  final String endDay;
  final String fullName;
  final String phone;
  final String id;
  final String fee;
  final String feePaid;
  final String feeDebt;
  final String phiThuThua;
  final List<NoteModel> noteModel;
  final String? code;
  final String? amountMoney;
  ReceiptsDetailModel({
    required this.userName,
    required this.receiptsTime,
    required this.hanThanhToan,
    required this.startDay,
    required this.endDay,
    required this.fullName,
    required this.phone,
    required this.id,
    required this.fee,
    required this.feePaid,
    required this.feeDebt,
    required this.phiThuThua,
    required this.noteModel,
    required this.code,
    required this.amountMoney,
  });
  factory ReceiptsDetailModel.fromJson(Map<String, dynamic> json) {
    return ReceiptsDetailModel(
      userName: json['user_name'] ?? json['purpose_use_name'] ?? '',
      receiptsTime: json['receipt_time'] ?? '',
      hanThanhToan: json['han_thanh_toan'] ?? '',
      startDay: json['start_day'] ?? '',
      endDay: json['end_day'] ?? '',
      fullName: json['full_name'] ?? '',
      phone: json['phone'] ?? '',
      id: json['id'] ?? '',
      fee: json['fee'] ?? '',
      feePaid: json['fee_paid'] ?? '',
      feeDebt: json['fee_debt'] ?? '',
      phiThuThua: json['phi_thu_thua'] ?? '',
      noteModel: (json['note'] as List<dynamic>? ?? [])
          .map((x) => NoteModel.fromJson(x))
          .toList(),
      code: json['code'],
      amountMoney: json['amount_money'] ?? '0',
    );
  }
}

class NoteModel {
  final String purposeUseId;
  final PhiToaNha phiToaNha;
  final List<VehicleModel> vehicleModel;
  NoteModel({
    required this.purposeUseId,
    required this.phiToaNha,
    required this.vehicleModel,
  });
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      purposeUseId: json['purpose_use_id'] ?? '',
      phiToaNha: PhiToaNha.fromJson(json['phi_toa_nha'] ?? {}),
      vehicleModel: (json['vehicle_note'] as List<dynamic>? ?? [])
          .map((x) => VehicleModel.fromJson(x))
          .toList(),
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

class PhiToaNha {
  final String dienTich;
  final double phi;
  final String phiThuThem;
  final double phiBaoTri;
  final String phiBaoTriThuThem;
  final double tienDien;
  final double tienNuoc;
  PhiToaNha({
    required this.dienTich,
    required this.phi,
    required this.phiThuThem,
    required this.phiBaoTri,
    required this.phiBaoTriThuThem,
    required this.tienDien,
    required this.tienNuoc,
  });
  factory PhiToaNha.fromJson(Map<String, dynamic> json) {
    return PhiToaNha(
      dienTich: json['dien_tich'] ?? '',
      phi: json['phi'].toDouble() ?? 0,
      phiThuThem: json['phi_thu_them'] ?? '',
      phiBaoTri: json['phi_bao_tri'].toDouble() ?? '',
      phiBaoTriThuThem: json['phi_bao_tri_thu_them'] ?? '',
      tienDien: json['tien_dien'].toDouble() ?? '',
      tienNuoc: json['tien_nuoc'].toDouble() ?? '',
    );
  }
}

class ChiTietMucDienNuoc {
  final String? name;
  final int? number;
  final double? price;
  final double? thanhTien;

  ChiTietMucDienNuoc({this.name, this.number, this.price, this.thanhTien});

  factory ChiTietMucDienNuoc.fromJson(Map<String, dynamic> json) {
    return ChiTietMucDienNuoc(
      name: json['name'] as String?,
      number: json['number'] != null
          ? int.tryParse(json['number'].toString())
          : null,
      price: json['price'] != null
          ? double.tryParse(json['price'].toString())
          : null,
      thanhTien: json['thanh_tien'] != null
          ? double.tryParse(json['thanh_tien'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'number': number,
      'price': price,
      'thanh_tien': thanhTien,
    };
  }
}
