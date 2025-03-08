import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/modules/login/sucess_screen.dart';
import 'package:ha_duong/utils/constants/styles.dart';

import '../../utils/constants/color.dart';

class TakeInfoScreen extends StatefulWidget {
  const TakeInfoScreen({super.key});

  @override
  State<TakeInfoScreen> createState() => _TakeInfoScreenState();
}

class _TakeInfoScreenState extends State<TakeInfoScreen> {
  TextEditingController? nameController = TextEditingController();
  TextEditingController? phoneController = TextEditingController();
  TextEditingController? noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thông tin của bạn',
              style: defaultText20B.copyWith(
                color: const Color(0xff0F2645),
                fontSize: 24.sp,
              ),
            ),
            Text(
              'Đăng ký để trải nghiệm ứng dụng!',
              style: defaultText16M.copyWith(
                color: const Color(0xff8A8A8A),
              ),
            ),
            SizedBox(
              height: 44.h,
            ),
            Container(
              width: 343.w,
              height: 56.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                color: const Color(0xffF4F1F3),
              ),
              child: Center(
                child: TextField(
                  //keyboardType: const TextInputType.numberWithOptions(),
                  controller: nameController,
                  style: defaultText16,
                  scrollPadding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).viewInsets.bottom),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: subBlack,
                    ),
                    hintText: 'Tên học sinh',
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    hintStyle: TextStyle(
                      fontSize: 16.sp,
                      color: subBlack,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Container(
              width: 343.w,
              height: 56.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                color: const Color(0xffF4F1F3),
              ),
              child: Center(
                child: TextField(
                  keyboardType: const TextInputType.numberWithOptions(),
                  controller: phoneController,
                  style: defaultText16,
                  scrollPadding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).viewInsets.bottom),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.call_outlined,
                      color: subBlack,
                    ),
                    hintText: 'Số điện thoại',
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    hintStyle: TextStyle(
                      fontSize: 16.sp,
                      color: subBlack,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Container(
              width: 343.w,
              height: 100.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                color: const Color(0xffF4F1F3),
              ),
              child: TextField(
                //keyboardType: const TextInputType.numberWithOptions(),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: noteController,
                style: defaultText16,
                scrollPadding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).viewInsets.bottom),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.chat_bubble_outline,
                    color: subBlack,
                  ),
                  hintText: 'Nội dung ghi chú',
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  hintStyle: TextStyle(
                    fontSize: 16.sp,
                    color: subBlack,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SucessScreen(),
                  ),
                );
              },
              child: Container(
                height: 48.h,
                width: 340.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9.r),
                  color: const Color(0xff004071),
                ),
                child: Center(
                  child: Text(
                    'Gửi thông tin',
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
      ),
    );
  }
}
