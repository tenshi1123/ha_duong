import 'package:ha_duong/utils/constants/color.dart';
import 'package:ha_duong/utils/constants/mediaqury.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../login/login_screen.dart';

class WellcomeScreen extends StatelessWidget {
  const WellcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 160.h),
          Image.asset(
            "assets/images/wellcome.png",
            width: 343.w,
            height: 270.h,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 35.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Text(
              'Chào mừng bạn đến với trung tâm',
              style: TextStyle(
                color: keyBlack,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: height / 40),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              'LUYỆN THI 3S là trung tâm dạy và luyện thi được xây dựng với sứ mệnh giúp học sinh đạt được những mục tiêu và kêt quả cao trên con đường học tập.',
              textAlign: TextAlign.center,
              style: defaultText16Re.copyWith(
                color: subBlack,
              ),
            ),
          ),
          SizedBox(
            height: 140.h,
          ),
          GestureDetector(
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
                color: key1Color,
              ),
              child: Center(
                child: Text(
                  'Trải nghiệm ngay',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
