import 'package:ha_duong/modules/bottomnavbar/info/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../../login/login_screen.dart';
import '../../../utils/constants/styles.dart';
import 'change_pass.dart';

class PersonalScreen extends StatelessWidget {
  const PersonalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 560.h,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/personal_background.png"),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Positioned(
          top: 92.h,
          left: 16.w,
          child: Row(
            children: [
              Image(
                image: const AssetImage('assets/images/avatar2.png'),
                height: 48.h,
                width: 48.w,
              ),
              SizedBox(
                width: 16.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nguyễn Thế Hoàng',
                    style: defaultText18B.copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    '097 111 6262',
                    style: defaultText16M.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
            top: 192.h,
            left: 0.w,
            child: Container(
              height: 600.h,
              width: 475.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const InfoScreen();
                          },
                        ),
                        // (_) => false,
                      );
                    },
                    leading: Image(
                      image: const AssetImage('assets/images/icon_info.png'),
                      height: 28.h,
                      width: 28.w,
                    ),
                    title: Text(
                      'Thông tin tài khoản',
                      style: defaultText16M,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  Container(
                    height: 1.h,
                    width: 303.w,
                    margin: EdgeInsets.only(left: 56.w, right: 16.w),
                    color: const Color(0xff292929).withAlpha(16),
                  ),
                  ListTile(
                    onTap: () {
                      pushWithoutNavBar(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const ChangePassScreen()),
                        ),
                      );
                    },
                    leading: Image(
                      image:
                          const AssetImage('assets/images/icon_changepass.png'),
                      height: 28.h,
                      width: 28.w,
                    ),
                    title: Text(
                      'Đổi mật khẩu',
                      style: defaultText16M,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  Container(
                    height: 1.h,
                    width: 303.w,
                    margin: EdgeInsets.only(left: 56.w, right: 16.w),
                    color: const Color(0xff292929).withAlpha(16),
                  ),
                  ListTile(
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => Dialog(
                        insetPadding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r)),
                        child: Container(
                          color: Colors.white,
                          height: 170.h,
                          width: 343.w,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                        borderRadius:
                                            BorderRadius.circular(12.r),
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
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return const LoginScreen();
                                          },
                                        ),
                                        (_) => false,
                                      );
                                    },
                                    color: const Color(0xffED1C24),
                                    height: 50.h,
                                    minWidth: 149.w,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r)),
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
                    leading: Image(
                      image: const AssetImage('assets/images/icon_logout.png'),
                      height: 28.h,
                      width: 28.w,
                    ),
                    title: Text(
                      'Đăng xuất',
                      style: defaultText16M.copyWith(
                          color: const Color(0xffED1C24)),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  Container(
                    height: 1.h,
                    width: 303.w,
                    margin: EdgeInsets.only(left: 56.w, right: 16.w),
                    color: const Color(0xff292929).withAlpha(16),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
