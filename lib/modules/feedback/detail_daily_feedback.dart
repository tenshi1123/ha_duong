import 'package:ha_duong/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DailyFeedback extends StatefulWidget {
  const DailyFeedback({super.key});

  @override
  State<DailyFeedback> createState() => _DailyFeedbackState();
}

class _DailyFeedbackState extends State<DailyFeedback> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xff3C3C3C)),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        title: Text(
          'Nhận xét hằng ngày',
          style: defaultText18B.copyWith(
            color: const Color(0xff3C3C3C),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 60.h,
                width: 375.w,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: const BoxDecoration(
                  color: Color(0xff273D8C),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Buổi 1: làm quen với từ vựng giao tiếp căn bản',
                      style: defaultText16B.copyWith(color: Colors.white),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      'Ngày: 26/12/2024',
                      style: defaultText16M.copyWith(color: Colors.white),
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1. Tổng quan',
                    style: defaultText16B.copyWith(
                      color: const Color(0xff273D8C),
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text('・ Học viên bắt nhịp và làm quen rất tốt với tiết học',
                      style: defaultText14Re),
                  Divider(
                    color: const Color(0xff292929).withAlpha(80),
                    height: 40.h,
                  ),
                  Text(
                    '2. Góc nhắc nhở',
                    style: defaultText16B.copyWith(
                      color: const Color(0xff273D8C),
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text('・ Nội dung nhắc nhở', style: defaultText14Re),
                  Divider(
                    color: const Color(0xff292929).withAlpha(80),
                    height: 40.h,
                  ),
                  Text(
                    '3. Nhận xét buổi học',
                    style: defaultText16B.copyWith(
                      color: const Color(0xff273D8C),
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text('・ Con tương tác tốt, học hiệu quả say mê',
                      style: defaultText14Re),
                  Divider(
                    color: const Color(0xff292929).withAlpha(80),
                    height: 40.h,
                  ),
                  Text(
                    '4. Đánh giá bổ sung',
                    style: defaultText16B.copyWith(
                      color: const Color(0xff273D8C),
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text('・ Thái độ học tập', style: defaultText14Re),
                  Divider(
                    color: const Color(0xff292929).withAlpha(80),
                    height: 40.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
