import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/models/info_model.dart';
import 'package:ha_duong/repo/personal_repo.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
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
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 55,
                backgroundImage: NetworkImage(
                  infoHomeModel.resident.img,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            infoItem(
              title: 'Họ và tên',
              info: infoHomeModel.resident.fullName,
            ),
            Divider(
              color: const Color(0xffE6E6E6),
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
              color: const Color(0xffE6E6E6),
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
              color: const Color(0xffE6E6E6),
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
              color: const Color(0xffE6E6E6),
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
              color: const Color(0xffE6E6E6),
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
                    color: const Color(0xffE6E6E6),
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
                    color: const Color(0xffE6E6E6),
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
              onTap: () {
                // Đăng xuất
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

Widget infoItem({
  required String title,
  required String info,
}) {
  return Row(
    children: [
      SizedBox(
        width: 16.w,
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
        width: 16.w,
      ),
    ],
  );
}
