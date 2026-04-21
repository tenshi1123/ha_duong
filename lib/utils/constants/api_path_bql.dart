class ApiPathBql {
  //baseurl
  static const String baseUrl = 'https://bms.haduong.com.vn/api';
  //api về đăng nhập, các thông tin của người dùng
  static const String login = '$baseUrl/banquanly/login';
  static const String refreshToken = '$baseUrl/banquanly/refresh_token';
  static const String forgotPassword = '$baseUrl/banquanly/forgot_password';

  // home
  static const String home = '$baseUrl/banquanly';
  static const String changeBuilding = '$home/change_building';
  static const String changeCategory = '$home/change_category';
  static const String postDetail = '$home/post_detail';

  // Căn hộ
  static const String apartment = '$home/apartment';
  static const String changeApartment = '$home/apartment/change_building';
  static const String loadApartment = '$home/apartment/load';
  static const String detailApartment = '$home/apartment/detail';
  static const String detailBienlai = '$home/apartment/bien_lai';
  // Tài khoản
  static const String profile = '$baseUrl/banquanly/profile';
  static const String editProfile = '$baseUrl/banquanly/profile/edit';
  static const String changePassword =
      '$baseUrl/banquanly/profile/change_password';
  static const String changeAvatar = '$profile/change_avatar';

  // Điện nước
  static const String dienNuoc = '$baseUrl/banquanly/dien_nuoc';
  static const String changeBuildingDienNuoc =
      '$baseUrl/banquanly/dien_nuoc/change_building';
  static const String loadDienNuoc = '$baseUrl/banquanly/dien_nuoc/load';

  // Hỗ trợ phản ánh
  static const String listTechnicalRequests = '$home/technical_requests';
  static const String detailTechnicalRequests =
      '$home/technical_requests/detail';
  static const String changeStatus = '$home/technical_requests/change_status';
  // Danh sách đăng ký tiện ích
  static const String listTienIch = '$home/building_utilities_register';
  //Thay đổi thông tin
  static const String residentPending = '$home/resident_pending';
  static const String detailResidentPending = '$home/resident_pending/view';
  static const String duyetYc = '$home/resident_pending/approve_reject';

  //Chat
  //Danh sach chat
  static const String listChat = '$home/chat';
  static const String loadListChat = '$home/chat/list_chat';
  static const String listMessages = '$home/chat/chat_messages';
  static const String loadMoreMessages =
      '$home/chat/load_content_chat_messages';
  static const String sendTextMessage = '$home/chat/send_chat_messages';
  static const String sendImgMessage = '$home/chat/send_chat_img';
  // danh sách lịch học
  static const String listSchedule = '$baseUrl/schedule/list';

  // thông tin tài khoản
  static const String user = '$baseUrl/user/info';

  // xóa tài khoản
  static const String deleteUser = '$baseUrl/user/delete';

  // check password
  static const String checkPassword = '$baseUrl/user/password/check';

  //check thông báo mới hay không
  static const String checkNoti = '$baseUrl/notification/check';

  //danh sách thông báo
  static const String getListNoti = '$baseUrl/banquanly/notification/building';
  static const String addNoti = '$baseUrl/banquanly/notification/add';

  //Chi tiết thông báo
  static const String getDetailNoti = '$baseUrl/notification/detail';

  //Gửi thông tin onesignal id
  static const String pushOnsignalId = '$home/onesignal';
  //Xóa thông tin onesignal id
  static const String deleteOnsignalId = '$baseUrl/notify/remove/onesignal_id';
}
