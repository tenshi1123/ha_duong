import 'package:ha_duong/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'list_lesson.dart';

class RollCallScreen extends StatefulWidget {
  const RollCallScreen({super.key});

  @override
  State<RollCallScreen> createState() => _RollCallScreenState();
}

class _RollCallScreenState extends State<RollCallScreen> {
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
          '        Điểm danh',
          style: defaultText18B.copyWith(
            color: const Color(0xff3C3C3C),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 80.h,
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
                        text: 'Lớp NC - Chủ nhật (8h30 - 10h30)',
                        style: defaultText20B.copyWith(color: Colors.white),
                        children: <TextSpan>[
                          TextSpan(
                            text: '\nPhòng 101 - Mỹ Đình',
                            style: defaultText16M.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            //qua luoi de lam gridview nen thoi dung row nhe
            //thời lượng + đã học
            SizedBox(
              height: 16.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const ListLessonScreen(
                              title: 'Toàn bộ buổi học',
                            )),
                      ),
                    );
                  },
                  child: Container(
                    height: 60.h,
                    width: 164.w,
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.r),
                      ),
                      color: const Color(0xffF2F2F2),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16.w,
                        ),
                        Image(
                          image: const AssetImage('assets/images/time.png'),
                          height: 24.h,
                          width: 24.w,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '40 buổi',
                              style: defaultText16B,
                            ),
                            Text(
                              'Thời lượng',
                              style: defaultText14Re.copyWith(
                                color: const Color(0xff8A8A8A),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const ListLessonScreen(
                              title: 'Buổi học đã học',
                            )),
                      ),
                    );
                  },
                  child: Container(
                    height: 60.h,
                    width: 164.w,
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.r),
                      ),
                      color: const Color(0xffF2F2F2),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16.w,
                        ),
                        Image(
                          image: const AssetImage('assets/images/done.png'),
                          height: 24.h,
                          width: 24.w,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '28 buổi',
                              style: defaultText16B,
                            ),
                            Text(
                              'Đã học',
                              style: defaultText14Re.copyWith(
                                color: const Color(0xff8A8A8A),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            //Vắng mặt + Nghỉ có phépphép
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const ListLessonScreen(
                              title: 'Buổi học vắng mặt',
                            )),
                      ),
                    );
                  },
                  child: Container(
                    height: 60.h,
                    width: 164.w,
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.r),
                      ),
                      color: const Color(0xffF2F2F2),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16.w,
                        ),
                        Image(
                          image: const AssetImage('assets/images/miss.png'),
                          height: 24.h,
                          width: 24.w,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '2 buổi',
                              style: defaultText16B,
                            ),
                            Text(
                              'Vắng mặt',
                              style: defaultText14Re.copyWith(
                                color: const Color(0xff8A8A8A),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const ListLessonScreen(
                              title: 'Buổi học nghỉ có phép',
                            )),
                      ),
                    );
                  },
                  child: Container(
                    height: 60.h,
                    width: 164.w,
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.r),
                      ),
                      color: const Color(0xffF2F2F2),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16.w,
                        ),
                        Image(
                          image: const AssetImage('assets/images/co_phep.png'),
                          height: 24.h,
                          width: 24.w,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '2 buổi',
                              style: defaultText16B,
                            ),
                            Text(
                              'Nghỉ có phép',
                              style: defaultText14Re.copyWith(
                                color: const Color(0xff8A8A8A),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            //Chưa học + Học bùbù
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const ListLessonScreen(
                              title: 'Buổi học chưa học',
                            )),
                      ),
                    );
                  },
                  child: Container(
                    height: 60.h,
                    width: 164.w,
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.r),
                      ),
                      color: const Color(0xffF2F2F2),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16.w,
                        ),
                        Image(
                          image:
                              const AssetImage('assets/images/not_learn.png'),
                          height: 24.h,
                          width: 24.w,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '6 buổi',
                              style: defaultText16B,
                            ),
                            Text(
                              'chưa học',
                              style: defaultText14Re.copyWith(
                                color: const Color(0xff8A8A8A),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const ListLessonScreen(
                              title: 'Buổi học bù',
                            )),
                      ),
                    );
                  },
                  child: Container(
                    height: 60.h,
                    width: 164.w,
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.r),
                      ),
                      color: const Color(0xffF2F2F2),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16.w,
                        ),
                        Image(
                          image: const AssetImage('assets/images/hoc_bu.png'),
                          height: 24.h,
                          width: 24.w,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '2 buổi',
                              style: defaultText16B,
                            ),
                            Text(
                              'Học bù',
                              style: defaultText14Re.copyWith(
                                color: const Color(0xff8A8A8A),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
