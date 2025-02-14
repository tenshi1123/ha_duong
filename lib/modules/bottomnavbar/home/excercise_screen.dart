import 'package:ha_duong/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExcerciseScreen extends StatefulWidget {
  const ExcerciseScreen({super.key});

  @override
  State<ExcerciseScreen> createState() => _ExcerciseScreenState();
}

class _ExcerciseScreenState extends State<ExcerciseScreen> {
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
          '        Bài tập về nhà',
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
                    RichText(
                      text: TextSpan(
                        text: 'Lớp NC ',
                        style: defaultText20B.copyWith(color: Colors.white),
                        children: <TextSpan>[
                          TextSpan(
                            text: '( Phòng 101 - Mỹ Đình)',
                            style: defaultText16M.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            Container(
              margin: EdgeInsets.only(top: 16.h),
              height: 358.h,
              width: 343.w,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      spreadRadius: 0,
                      blurRadius: 12,
                      offset: const Offset(0, 2),
                    ),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Buổi 2: Week 1 Listening practice',
                    style: defaultText16B.copyWith(
                      color: const Color(0xff273D8C),
                    ),
                  ),
                  SizedBox(
                    height: 168.h,
                    width: 311.w,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ngày giao:',
                              style: defaultText14M,
                            ),
                            Text(
                              'Ngày nộp:',
                              style: defaultText14M,
                            ),
                            Text(
                              'Trạng thái:',
                              style: defaultText14M,
                            ),
                            Text(
                              'Điểm:',
                              style: defaultText14M,
                            ),
                            Text(
                              'Tỷ lệ hoàn thành:',
                              style: defaultText14M,
                            ),
                            Text(
                              'Nhận xét:',
                              style: defaultText14M,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '03/01/2025',
                              style: defaultText14B,
                            ),
                            Text(
                              '--/--/----',
                              style: defaultText14B,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: const Color(0xffED1C24),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                'Chưa hoàn thành',
                                style: defaultText12B.copyWith(
                                    color: Colors.white),
                              ),
                            ),
                            Text(
                              '--',
                              style: defaultText14B,
                            ),
                            Text(
                              '--%',
                              style: defaultText14B,
                            ),
                            Text(
                              '',
                              style: defaultText14B,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100.h,
                    width: 310.w,
                    decoration: BoxDecoration(
                      color: const Color(0xffF6F6F6),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16.h),
              height: 358.h,
              width: 343.w,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      spreadRadius: 0,
                      blurRadius: 12,
                      offset: const Offset(0, 2),
                    ),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Buổi 1: Week 1 Listening practice',
                    style: defaultText16B.copyWith(
                      color: const Color(0xff273D8C),
                    ),
                  ),
                  SizedBox(
                    height: 168.h,
                    width: 311.w,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ngày giao:',
                              style: defaultText14M,
                            ),
                            Text(
                              'Ngày nộp:',
                              style: defaultText14M,
                            ),
                            Text(
                              'Trạng thái:',
                              style: defaultText14M,
                            ),
                            Text(
                              'Điểm:',
                              style: defaultText14M,
                            ),
                            Text(
                              'Tỷ lệ hoàn thành:',
                              style: defaultText14M,
                            ),
                            Text(
                              'Nhận xét:',
                              style: defaultText14M,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '26/12/2024',
                              style: defaultText14B,
                            ),
                            Text(
                              '30/12/2024',
                              style: defaultText14B,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: const Color(0xff28B4E9),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                'Đã hoàn thành',
                                style: defaultText12B.copyWith(
                                    color: Colors.white),
                              ),
                            ),
                            Text(
                              '8',
                              style: defaultText14B,
                            ),
                            Text(
                              '80%',
                              style: defaultText14B,
                            ),
                            Text(
                              '',
                              style: defaultText14B,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100.h,
                    width: 310.w,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: const Color(0xffF6F6F6),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      'Làm bài tốt, cố gắng phát huy và duy trì trong những buổi học tiếp theo',
                      style: defaultText14M.copyWith(
                        color: const Color(0xff273D8C),
                      ),
                    ),
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
