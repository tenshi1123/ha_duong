import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../login/login_screen.dart';
import '../../utils/constants/color.dart';
import '../../utils/constants/styles.dart';

class RegisterSuccess extends StatelessWidget {
  const RegisterSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 124.h),
          Image.asset(
            "assets/images/register_success.png",
            width: 359.w,
            height: 342.h,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
            child: Text(
              'Chào mừng bạn đến với trung tâm',
              style: TextStyle(
                color: keyBlack,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
            height: 20.h,
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
                  'Tiếp tục   ',
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
