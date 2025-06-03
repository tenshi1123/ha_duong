class ApiPath {
  //baseurl
  static const String baseUrl = 'https://bms.haduong.com.vn/api';
  //api về đăng nhập
  static const String login = '$baseUrl/cudan/login';
  static const String refreshToken = '$baseUrl/cudan/refresh_token';

  // api home
  static const String home = '$baseUrl/cudan';
  static const String changeApartment = '$baseUrl/cudan/change_apartment';
  static const String changeCategory = '$baseUrl/cudan/change_category';
  static const String postDetail = '$baseUrl/cudan/post/detail';

  // api hóa đơn
  static const String receipts = '$baseUrl/cudan/receipts';
  static const String receiptDetail = '$baseUrl/cudan/receipts/detail';

  // api Hỗ trợ
  static const String homeSupport = '$baseUrl/cudan/technical_requests';
  static const String listSupport = '$homeSupport/list';
  static const String supportDetail = '$homeSupport/detail';
  static const String showSupportPopup = '$homeSupport/show_popup';
  static const String showCreateSupport =
      '$baseUrl/cudan/technical_requests/show_create';
  static const String supportCreate = '$homeSupport/create_requests';

  // api tiện ích
  static const String utilities = '$baseUrl/cudan/utilities';
  static const String utilitiesDetail = '$baseUrl/cudan/utilities/detail';
  static const String showDangKy = '$baseUrl/cudan/utilities/show_dang_ky';
  static const String sendDangKy = '$baseUrl/cudan/utilities/dang_ky';
  // api tài khoản
  static const String profile = '$baseUrl/cudan/profile';

  // api căn hộ
  static const String apartment = '$baseUrl/cudan/apartment';
  static const String editChuho = '$baseUrl/cudan/apartment/edit_chu_ho';
  static const String apartmentResident = '$apartment/view_apartment_resident';
  static const String editThanhVien = '$apartment/edit_apartment_thanh_vien';
  static const String addThanhVien = '$apartment/add_apartment_thanh_vien';

  static const String listPhuongTien =
      '$baseUrl/cudan/apartment/list_phuong_tien';
  //Gửi thông tin onesignal id
  static const String pushOnsignalId = '$baseUrl/notify/onesignal_id';
  //Xóa thông tin onesignal id
  static const String deleteOnsignalId = '$baseUrl/notify/remove/onesignal_id';
}
