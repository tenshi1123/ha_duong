import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/utils/constants/styles.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffD5D5D5).withValues(alpha: 0.2),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              'Trung tâm hỗ trợ',
              style: defaultText18B,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30.h, left: 16.w),
              child: Row(
                children: [
                  Text(
                    'Danh sách hỗ trợ',
                    style: defaultText16B.copyWith(
                      color: const Color(0xff383838),
                    ),
                  ),
                  //arrow icon
                  Container(
                    margin: EdgeInsets.only(left: 10.w),
                    // width: 20.w,
                    // height: 20.h,
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: const Color(0xff383838),
                      size: 16.w,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Container(
              //height: 224.h,
              width: 343.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return SupportItem(
                    index: index,
                  );
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 16.w,
                ),
                Container(
                  width: 164.w,
                  height: 86.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: const Image(
                    image: AssetImage('assets/images/chat.png'),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 164.w,
                  height: 86.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: const Image(
                    image: AssetImage('assets/images/feedback.png'),
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SupportItem extends StatelessWidget {
  const SupportItem({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 311.w,
      height: index == 0 ? 76.h : 60.h,
      child: Column(
        children: [
          SizedBox(
            height: index == 0 ? 16.h : 0,
          ),
          Row(
            children: [
              SizedBox(
                width: 16.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Text('Yêu cầu kĩ thuật',
                          style: defaultText14M.copyWith(
                            color: const Color(0xff383838),
                          )),
                      Container(
                        margin: EdgeInsets.only(left: 10.w),
                        // width: 20.w,
                        // height: 20.h,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color:
                              const Color(0xff129F20).withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text('Đã hoàn thành',
                            style: defaultText14M.copyWith(
                              color: const Color(0xff129F20),
                            )),
                      ),
                    ],
                  ),
                  Text(
                    'Xử lý đường ống nước',
                    style: defaultText14Re.copyWith(
                      color: const Color(0xff383838),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: const Color(0xff383838),
                size: 16.w,
              ),
              SizedBox(
                width: 16.w,
              ),
            ],
          ),
          (index != 4)
              ? Divider(
                  color: const Color(0xffD5D5D5),
                  thickness: 1,
                  indent: 16.w,
                  endIndent: 16.w,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
