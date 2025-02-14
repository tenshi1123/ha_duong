import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import '../../../utils/constants/styles.dart';
import '../../videoplayer/animation_player.dart';

class VideoCourse extends StatelessWidget {
  const VideoCourse({super.key});

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
            'Khoá học video',
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
              //width: 142.w,
              margin: EdgeInsets.only(top: 16.h, left: 16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: const Color(0xff28B4E9),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Khoá học video',
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
            Divider(
              color: const Color(0xffEDEDED),
              thickness: 8.h,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h, left: 16.w),
              child: Text(
                'Nội dung',
                style: defaultText16B,
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return LessonItem(
                    index: index,
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

class LessonItem extends StatefulWidget {
  const LessonItem({super.key, required this.index});
  final int index;

  @override
  State<LessonItem> createState() => _LessonItemState();
}

class _LessonItemState extends State<LessonItem> {
  bool isExpanded = false;
  List<String> title = [
    'Bài 1: Cấu trúc câu',
    'Bài 2: Tính từ và trạng từ',
    'Bài 3: Câu bị động',
    'Bài 4: Câu điều kiện',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 12.h,
        ),
        InkWell(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Row(
            children: [
              SizedBox(
                width: 16.w,
              ),
              Container(
                height: 34.h,
                width: 34.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xff2F9CD3),
                  ),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    '${widget.index + 1}',
                    style: defaultText14M.copyWith(
                      color: const Color(0xff2F9CD3),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title[widget.index],
                    style: defaultText16M.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '5 bài giảng / 6 bài tập',
                    style: defaultText12M.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff3C3C3C).withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.keyboard_arrow_right_outlined),
              SizedBox(
                width: 16.w,
              ),
            ],
          ),
        ),
        const Divider(),
        if (isExpanded)
          Column(
            children: title
                .map((e) => DetailItem(
                      title: e,
                      index: title.indexOf(e),
                    ))
                .toList(),
          ),
      ],
    );
  }
}

class DetailItem extends StatelessWidget {
  const DetailItem({super.key, required this.title, required this.index});
  final String title;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushWithoutNavBar(
          context,
          MaterialPageRoute(
            builder: ((context) => AnimationPlayer(
                  index: index,
                )),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 16.w,
          ),
          Column(
            children: [
              SvgPicture.asset(
                'assets/icons/green_tick.svg',
                height: 12.h,
                width: 12.w,
              ),
              Container(
                height: 32.h,
                width: 1.w,
                margin: EdgeInsets.symmetric(vertical: 8.h),
                decoration: const BoxDecoration(
                  color: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 16.w,
          ),
          Image.asset(
            'assets/images/video.png',
            height: 24.h,
            width: 24.w,
            fit: BoxFit.fill,
          ),
          SizedBox(
            width: 16.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: defaultText14M,
              ),
              SizedBox(
                width: 267.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Bài giảng',
                      style: defaultText12M.copyWith(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff3C3C3C).withValues(alpha: 0.6),
                      ),
                    ),
                    Text(
                      '10 Phút',
                      style: defaultText12M.copyWith(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff3C3C3C).withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
