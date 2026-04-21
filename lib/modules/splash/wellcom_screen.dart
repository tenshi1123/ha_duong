import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/modules/login/login_screen_bql.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import '../../utils/constants/color.dart';
import '../login/login_screen.dart';

class WellcomeScreen extends StatelessWidget {
  const WellcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff00AEEF),
      body: Stack(
        children: [
          Image.asset(
            "assets/images/splash.png",
            height: 844.h,
            width: 390.w,
            fit: BoxFit.fill,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40.h,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const LoginScreen()),
                      ),
                    );
                  },
                  child: Container(
                    height: 48.h,
                    width: 340.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.r),
                      color: pri500,
                    ),
                    child: Center(
                      child: Text('Đăng nhập với vai trò cư dân',
                          textAlign: TextAlign.center,
                          style: defaultText14B.copyWith(color: Colors.white)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const LoginScreenBql(
                            //type: 'ph',
                            )),
                      ),
                    );
                  },
                  child: Container(
                    height: 48.h,
                    width: 340.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.r),
                      color: pri500,
                    ),
                    child: Center(
                      child: Text("Đăng nhập với vai trò quản lý",
                          textAlign: TextAlign.center,
                          style: defaultText14B.copyWith(color: Colors.white)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
