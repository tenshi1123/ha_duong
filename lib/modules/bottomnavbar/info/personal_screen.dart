import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/main.dart';
import 'package:ha_duong/models/apartment_model.dart';
import 'package:ha_duong/models/info_model.dart';
import 'package:ha_duong/modules/splash/wellcom_screen.dart';
import 'package:ha_duong/repo/personal_repo.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:ha_duong/utils/widget/pick_image.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../login/login_screen.dart';
import 'apartment_profile.dart';
import 'registered_vehicle_screen.dart';

class PersonalScreen extends StatelessWidget {
  const PersonalScreen({super.key, required this.infoHomeModel});
  final InfoModel infoHomeModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/person_background.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 86.h,
              ),
              Text(
                'Thông tin tài khoản',
                style: defaultText18B.copyWith(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 34.h,
              ),
              Stack(
                children: [
                  ValueListenableBuilder<List<File>>(
                    valueListenable: mainAvatarNotifier,
                    builder: (context, value, _) {
                      if (value.isNotEmpty) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(55.r),
                          child: Image.file(
                            value.first,
                            width: 110.r,
                            height: 110.r,
                            fit: BoxFit.cover,
                          ),
                        );
                      } else {
                        return CircleAvatar(
                          radius: 55.r,
                          backgroundImage:
                              NetworkImage(infoHomeModel.resident.img),
                        );
                      }
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    right: 5.w,
                    child: GestureDetector(
                      onTap: () {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => Dialog(
                                  child: Container(
                                    height: 166.h,
                                    width: 343.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.r),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // Nút Tải ảnh lên
                                          buildUploadOption(
                                            icon: Icons.image_outlined,
                                            text: "Tải ảnh lên",
                                            onTap: () {
                                              // Xử lý tải ảnh lên
                                              pickImageFromGallery1(
                                                context,
                                              );
                                            },
                                          ),
                                          SizedBox(width: 56.w),
                                          // Nút Chụp ảnh
                                          buildUploadOption(
                                            icon: Icons.camera_alt_outlined,
                                            text: "Chụp ảnh",
                                            onTap: () {
                                              pickImageFromCamera1(
                                                context,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                      },
                      child: Image.asset(
                        'assets/images/camera.png',
                        width: 28.w,
                        height: 28.h,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              infoItem(
                title: 'Họ và tên',
                info: infoHomeModel.resident.fullName,
              ),
              Divider(
                color: const Color(0xffF0F0F0),
                thickness: 1,
                endIndent: 16.w,
                indent: 16.w,
                height: 24.h,
              ),
              infoItem(
                title: 'Số định danh',
                info: infoHomeModel.resident.idCard,
              ),
              Divider(
                color: const Color(0xffF0F0F0),
                thickness: 1,
                endIndent: 16.w,
                indent: 16.w,
                height: 24.h,
              ),
              infoItem(
                title: 'Ngày sinh',
                info: infoHomeModel.resident.dob,
              ),
              Divider(
                color: const Color(0xffF0F0F0),
                thickness: 1,
                endIndent: 16.w,
                indent: 16.w,
                height: 24.h,
              ),
              infoItem(
                title: 'Số điện thoại',
                info: infoHomeModel.resident.phone,
              ),
              Divider(
                color: const Color(0xffF0F0F0),
                thickness: 1,
                endIndent: 16.w,
                indent: 16.w,
                height: 24.h,
              ),
              infoItem(
                title: 'Email',
                info: infoHomeModel.resident.email,
              ),
              Divider(
                color: const Color(0xffF0F0F0),
                thickness: 6,
                height: 30.h,
              ),
              InkWell(
                onTap: () async {
                  showLoadingDialog(context);
                  try {
                    final result = await PersonalRepo()
                        .getApartmentProfile()
                        .timeout(const Duration(
                            seconds: 10)); // auto timeout sau 10s

                    if (context.mounted) {
                      hideLoadingDialog(context); // tắt loading
                      pushWithoutNavBar(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ApartmentProfile(
                            residentModel: result['resident'],
                            apartmentModel: result['apartment'],
                          ),
                        ),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      hideLoadingDialog(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Có lỗi xảy ra, thử lại sau')),
                      );
                    }
                  }
                },
                //   final result = await PersonalRepo().getApartmentProfile();
                //   pushWithoutNavBar(
                //     context,
                //     MaterialPageRoute(
                //       builder: ((context) => ApartmentProfile(
                //             residentModel: result['resident'],
                //             apartmentModel: result['apartment'],
                //           )),
                //     ),
                //   );
                // },
                child: Column(
                  children: [
                    SizedBox(
                      height: 6.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 16.w,
                        ),
                        Text(
                          'Hồ sơ căn hộ',
                          style: defaultText16M.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: const Color(0xff383838),
                          size: 16.w,
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                      ],
                    ),
                    Divider(
                      color: const Color(0xffF0F0F0),
                      thickness: 1,
                      endIndent: 16.w,
                      indent: 16.w,
                      height: 24.h,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  // call api
                  List<VehicleModel> listVehicle =
                      await PersonalRepo().getListPhuongTien();
                  pushWithoutNavBar(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => RegisteredVehicleScreen(
                            listVehicle: listVehicle,
                          )),
                    ),
                  );
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 6.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 16.w,
                        ),
                        Text(
                          'Phương tiện đăng ký',
                          style: defaultText16M.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: const Color(0xff383838),
                          size: 16.w,
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                      ],
                    ),
                    Divider(
                      color: const Color(0xffF0F0F0),
                      thickness: 1,
                      endIndent: 16.w,
                      indent: 16.w,
                      height: 24.h,
                    ),
                  ],
                ),
              ),
              if (DateTime.now().isBefore(DateTime(2025, 8, 15)))
                InkWell(
                  onTap: () async {
                    // show dialog confirm delete account
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Xác nhận'),
                          content: const Text(
                            'Bạn có chắc chắn muốn xóa tài khoản của mình?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Đóng dialog
                              },
                              child: const Text('Hủy'),
                            ),
                            TextButton(
                              onPressed: () async {
                                // Xử lý xóa tài khoản ở đây
                                Navigator.of(context).pop(); // Đóng dialog
                              },
                              child: const Text('Xóa'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 6.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 16.w,
                          ),
                          Text(
                            'Xóa tài khoản',
                            style: defaultText16M.copyWith(
                              color: Colors.red,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      Divider(
                        color: const Color(0xffF0F0F0),
                        thickness: 1,
                        endIndent: 16.w,
                        indent: 16.w,
                        height: 24.h,
                      ),
                    ],
                  ),
                ),
              SizedBox(
                height: 40.h,
              ),
              GestureDetector(
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => Dialog(
                    insetPadding: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Container(
                      height: 170.h,
                      width: 343.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'Đăng xuất',
                            style: defaultText16M.copyWith(
                              color: const Color(0xffED1C24),
                            ),
                          ),
                          Text(
                            'Bạn chắc chắn muốn đăng xuất?',
                            style: defaultText16M.copyWith(
                              color: const Color(0xff8A8A8A),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  height: 50.h,
                                  width: 149.w,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xff273D8C),
                                    ),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Hủy",
                                      style: defaultText14B.copyWith(
                                        color: const Color(0xff273D8C),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              MaterialButton(
                                onPressed: () async {
                                  // Đăng xuất
                                  // delete token
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.remove('token');
                                  prefs.remove('refresh_token');
                                  prefs.clear;
                                  pushWithoutNavBar(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) =>
                                          const WellcomeScreen()),
                                    ),
                                  );
                                },
                                color: const Color(0xffED1C24),
                                height: 50.h,
                                minWidth: 149.w,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r)),
                                child: Text(
                                  "Đăng xuất",
                                  style: defaultText14B.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                child: Container(
                  width: 343.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: const Color(0xff8A8A8A).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Text(
                      'Đăng xuất',
                      style: defaultText16M.copyWith(
                        color: const Color(0xff004071),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildUploadOption({
  required IconData icon,
  required String text,
  required VoidCallback onTap,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: CircleAvatar(
          radius: 26.r,
          backgroundColor: Colors.transparent,
          child: Container(
            height: 52.h,
            width: 52.r,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.lightBlue,
              // gradient: LinearGradient(
              //   colors: [
              //     Color(0xff25AAE1),
              //     Color(0xff004071),
              //   ],
              // ),
            ),
            child: Icon(icon, size: 26.r, color: Colors.white),
          ),
        ),
      ),
      const SizedBox(height: 8),
      Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
    ],
  );
}

Widget infoItem({
  required String title,
  required String info,
}) {
  return Row(
    children: [
      SizedBox(
        width: 20.w,
      ),
      Text(
        title,
        style: defaultText14Re.copyWith(
          color: const Color(0xff8A8A8A),
        ),
      ),
      const Spacer(),
      Text(
        info == '' ? "Chưa cập nhật" : info,
        style: defaultText14Re.copyWith(
          color: Colors.black,
        ),
      ),
      SizedBox(
        width: 20.w,
      ),
    ],
  );
}

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // không cho tắt khi bấm ngoài
    barrierColor: Colors.black.withOpacity(0.3), // lớp mờ
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.deepPurple, // đổi màu nếu muốn
        ),
      );
    },
  );
}

void hideLoadingDialog(BuildContext context) {
  if (Navigator.of(context, rootNavigator: true).canPop()) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
