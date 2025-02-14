class InfoModel {
  final String avatar;
  final String fullName;
  final String id;
  final String email;
  final String phone;
  final String gender;
  final String birthday;
  InfoModel({
    required this.avatar,
    required this.fullName,
    required this.id,
    required this.email,
    required this.phone,
    required this.gender,
    required this.birthday,
  });
  factory InfoModel.fromJson(Map<String, dynamic> json) {
    return InfoModel(
      avatar: json['avatar'] ?? '',
      fullName: json['full_name'] ?? '',
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      gender: json['gender'] ?? 'Không xác định',
      birthday: json['birthday'] ?? '',
    );
  }
}

class ChildrenInfoModel {
  final String img;
  final String nameChild;
  final String token;
  final String refreshToken;
  ChildrenInfoModel({
    required this.img,
    required this.nameChild,
    required this.token,
    required this.refreshToken,
  });
  factory ChildrenInfoModel.fromJson(Map<String, dynamic> json) {
    return ChildrenInfoModel(
      img: json['img'] ?? '',
      nameChild: json['name_child'] ?? '',
      token: json['token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
    );
  }
}
