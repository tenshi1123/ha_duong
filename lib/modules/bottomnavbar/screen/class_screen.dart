import 'package:ha_duong/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../../diemdanh/detail_screen.dart';

class ClassScreen extends StatelessWidget {
  const ClassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff273D8C),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        //   onPressed: () {},
        // ),
        title: Center(
          child: Text(
            'Lớp học',
            style: defaultText18B.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
              width: 343.w,
              height: 218.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.r)),
                color: Colors.white,
                image: const DecorationImage(
                  image: AssetImage('assets/images/class_banner.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              height: 32.h,
              width: 226.w,
              margin: EdgeInsets.only(top: 16.h, left: 16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: const Color(0xff28B4E9),
              ),
              child: Center(
                child: Text(
                  'Học trực tiếp tại trung tâm',
                  style: defaultText16M.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h, left: 16.w),
              child: Text(
                'Grammar & Writing',
                style: defaultText20B.copyWith(
                  color: const Color(0xff273D8C),
                ),
              ),
            ),
            Row(
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 16.w),
                      height: 8.h,
                      width: 296.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.r),
                        color: const Color(0xffEDEDED),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 16.w),
                      height: 8.h,
                      width: (296 * 26 / 100).w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.r),
                        color: const Color(0xff28B4E9),
                      ),
                    ),
                  ],
                ),
                Text(
                  '26%',
                  style: defaultText16B.copyWith(
                    color: const Color(0xff28B4E9),
                  ),
                ),
              ],
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      pushWithoutNavBar(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => DetailScreen(
                                title1: time[index],
                                title2: title[index],
                                title3: content[index],
                              )),
                        ),
                      );
                    },
                    child: Container(
                        width: 343.w,
                        margin: EdgeInsets.only(top: 16.h),
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h, horizontal: 16.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xff273D8C).withAlpha(80),
                              spreadRadius: 0,
                              blurRadius: 8,
                              offset: const Offset(
                                  0, 4), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              time[index],
                              style: defaultText14M.copyWith(
                                  color: const Color(0xff273D8C)),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              title[index],
                              style: defaultText16B.copyWith(
                                  color: const Color(0xff273D8C)),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              'Nội dung buổi học: ${content[index]}',
                              style: defaultText14M.copyWith(
                                  color: const Color(0xff273D8C)),
                            ),
                          ],
                        )),
                  );
                }),
            SizedBox(
              height: 80.h,
            ),
          ],
        ),
      ),
    );
  }
}

List<String> title = [
  'Bài 1: Cấu trúc câu',
  'Bài 2: Tính từ và trạng từ',
  'Bài 3: Câu bị động',
  'Bài 4: Câu điều kiện',
  'Bài 5: Ôn tập',
];
List<String> time = [
  'P.101 - Mỹ Đình (26/06/2024)',
  'P.102 - Mỹ Đình (28/06/2024)',
  'P.101 - Mỹ Đình (1/07/2024)',
  'P.103 - Mỹ Đình (5/07/2024)',
  'P.102 - Mỹ Đình (12/07/2024)'
];
List<String> content = [
  'Nắm vững các cấu trúc câu trong tiếng Anh (sentence structure) sẽ giúp bạn cải thiện kỹ năng Writing và Speaking ngày càng linh hoạt, tự tin.',
  'Phân biệt Tính từ và Trạng từ chi tiết trong tiếng Anh',
  'Câu bị động (passive voice): công thức, cách dùng',
  '"Conditional Sentences" (Câu điều kiện) dùng để diễn đạt, giải thích một sự việc có thể xảy ra khi điều kiện nói đến xảy ra',
  'Ôn tập'
];
