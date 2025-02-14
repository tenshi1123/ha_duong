import 'package:ha_duong/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bottomnavbar/screen/class_screen.dart';
import 'detail_screen.dart';

class ListLessonScreen extends StatefulWidget {
  const ListLessonScreen({super.key, required this.title});
  final String title;
  @override
  State<ListLessonScreen> createState() => _ListLessonScreenState();
}

class _ListLessonScreenState extends State<ListLessonScreen> {
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
      backgroundColor: const Color(0xffFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xff3C3C3C)),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        title: Text(
          widget.title,
          style: defaultText18B.copyWith(
            color: const Color(0xff3C3C3C),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const DetailScreen(
                                title1: 'P.101 - Mỹ Đình (26/06/2024)',
                                title2: 'Bài 1: Cấu trúc câu',
                                title3:
                                    'Nắm vững các cấu trúc câu trong tiếng Anh (sentence structure) sẽ giúp bạn cải thiện kỹ năng Writing và Speaking ngày càng linh hoạt, tự tin.',
                              )),
                        ),
                      );
                    },
                    child: Container(
                        width: 343.w,
                        margin: EdgeInsets.only(top: 20.h),
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h, horizontal: 16.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withAlpha(50),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
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
                              height: 12.h,
                            ),
                            Text(
                              title[index],
                              style: defaultText16B.copyWith(
                                  color: const Color(0xff273D8C)),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            Text(
                              'Nội dung buổi học : ${content[index]}',
                              style: defaultText14M.copyWith(
                                  color: const Color(0xff273D8C)),
                            ),
                          ],
                        )),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
