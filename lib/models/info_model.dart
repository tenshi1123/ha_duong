import 'package:ha_duong/models/apartment_model.dart';

class InfoModel {
  final ResidentModel resident;
  final List<ApartmentModel> listApartment;
  final List<ReceiptsModel> listReceipts;
  final List<CategoryModel> listCategory;
  final List<PostModel> listPost;

  InfoModel({
    required this.resident,
    required this.listApartment,
    required this.listReceipts,
    required this.listCategory,
    required this.listPost,
  });
  factory InfoModel.fromJson(Map<String, dynamic> json) {
    return InfoModel(
      resident: ResidentModel.fromJson(json['resident'] ?? {}),
      listApartment: (json['apartment'] as List<dynamic>? ?? [])
          .map((x) => ApartmentModel.fromJson(x))
          .toList(),
      listReceipts: (json['receipts'] as List<dynamic>? ?? [])
          .map((x) => ReceiptsModel.fromJson(x))
          .toList(),
      listCategory: (json['category'] as List<dynamic>? ?? [])
          .map((x) => CategoryModel.fromJson(x))
          .toList(),
      listPost: (json['post'] as List<dynamic>? ?? [])
          .map((x) => PostModel.fromJson(x))
          .toList(),
    );
  }
}

class ResidentModel {
  final String id;
  final String fullName;
  final String phone;
  final String email;
  final String dob;
  final String idCard;
  final String img;
  final String createdAt;
  final String updatedAt;
  ResidentModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.dob,
    required this.idCard,
    required this.img,
    required this.createdAt,
    required this.updatedAt,
  });
  factory ResidentModel.fromJson(Map<String, dynamic> json) {
    return ResidentModel(
      id: json['id'] ?? '',
      fullName: json['full_name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      dob: json['dob'] ?? '',
      idCard: json['cccd_cmt'] ?? '',
      img: json['img'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

class ListReceiptsModel {
  final List<ReceiptsModel> listReceiptsunpaid;
  final List<ReceiptsModel> listReceiptspaid;
  ListReceiptsModel({
    required this.listReceiptsunpaid,
    required this.listReceiptspaid,
  });
  factory ListReceiptsModel.fromJson(Map<String, dynamic> json) {
    return ListReceiptsModel(
      listReceiptsunpaid:
          (json['receipts_chua_thanh_toan'] as List<dynamic>? ?? [])
              .map((x) => ReceiptsModel.fromJson(x))
              .toList(),
      listReceiptspaid: (json['receipts_da_thanh_toan'] as List<dynamic>? ?? [])
          .map((x) => ReceiptsModel.fromJson(x))
          .toList(),
    );
  }
}

class ReceiptsModel {
  final String id;
  final String name;

  ReceiptsModel({
    required this.id,
    required this.name,
  });
  factory ReceiptsModel.fromJson(Map<String, dynamic> json) {
    return ReceiptsModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
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

class PostModel {
  final String id;
  final String img;
  final String name;

  PostModel({
    required this.id,
    required this.img,
    required this.name,
  });
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? '',
      img: json['img'] ?? '',
      name: json['name'] ?? '',
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
  });
  factory ReceiptsDetailModel.fromJson(Map<String, dynamic> json) {
    return ReceiptsDetailModel(
      userName: json['user_name'] ?? '',
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
    );
  }
}

class UtilitiesModel {
  final String id;
  final String buildingId;
  final String name;
  final String img;
  final String content;
  final String isActive;
  final String createdAt;
  final String updatedAt;
  UtilitiesModel({
    required this.id,
    required this.buildingId,
    required this.name,
    required this.img,
    required this.content,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  factory UtilitiesModel.fromJson(Map<String, dynamic> json) {
    return UtilitiesModel(
      id: json['id'] ?? '',
      img: json['img'] ?? '',
      name: json['name'] ?? '',
      buildingId: json['building_id'] ?? '',
      content: json['content'] ?? '',
      isActive: json['is_active'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

// Được này mất kia thôi, sao t không vào cái thế không được gì hết không mất gì hết, sống như phật, không ham dục vọng, không màng hư vinh. Chỉ tập chung vào những giá trị cốt lỗi của con người, nâng tầm kiến thức, sức khỏe, giao tiếp
