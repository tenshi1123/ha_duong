import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/models/apartment_model.dart';
import 'package:ha_duong/models/info_model.dart';
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
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/person_background.png"),
            fit: BoxFit.fill,
          ),
        ),
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
                CircleAvatar(
                  radius: 60.r,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 55,
                    backgroundImage: NetworkImage(
                      infoHomeModel.resident.img,
                    ),
                  ),
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
                                              2,
                                            );
                                          },
                                        ),
                                        SizedBox(
                                            width: 56
                                                .w), // Khoảng cách giữa hai nút
                                        // Nút Chụp ảnh
                                        buildUploadOption(
                                          icon: Icons.camera_alt_outlined,
                                          text: "Chụp ảnh",
                                          onTap: () {
                                            // Xử lý chụp ảnh
                                            pickImageFromCamera1(
                                              context,
                                              2,
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
                final result = await PersonalRepo().getApartmentProfile();
                pushWithoutNavBar(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => ApartmentProfile(
                          residentModel: result['resident'],
                          apartmentModel: result['apartment'],
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
            SizedBox(
              height: 40.h,
            ),
            GestureDetector(
              onTap: () async {
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
                    builder: ((context) => const LoginScreen()),
                  ),
                );
              },
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
            )
          ],
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
