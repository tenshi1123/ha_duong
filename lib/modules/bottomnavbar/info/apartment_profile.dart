import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ha_duong/utils/widget/change_canho_info_dialog.dart';

import '../../../utils/constants/styles.dart';
import '../../../utils/widget/custom_dialog.dart';
import 'family_member.dart';
import 'personal_screen.dart';

class ApartmentProfile extends StatelessWidget {
  const ApartmentProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Hồ sơ căn hộ'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(),
            SizedBox(
              height: 28.h,
            ),
            const _ApartmentItem(),
            Divider(
              color: const Color(0xffE6E6E6),
              thickness: 6,
              height: 24.h,
            ),
            SizedBox(
              height: 20.h,
            ),
            const _ApartmentInfo(),
          ],
        ),
      ),
    );
  }
}

class _ApartmentItem extends StatelessWidget {
  const _ApartmentItem();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 16.w,
            ),
            Text(
              'Thông tin cư trú',
              style: defaultText16B,
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Chủ hộ',
                    style: defaultText14Re.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 16.w,
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        infoItem(title: 'Họ và tên', info: 'PHẠM TUẤN KHANG'),
        Divider(
          color: const Color(0xffE6E6E6),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        infoItem(title: 'Số định danh', info: '29BE-019.19'),
        Divider(
          color: const Color(0xffE6E6E6),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        infoItem(title: 'Ngày sinh', info: '0971116262'),
        Divider(
          color: const Color(0xffE6E6E6),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        infoItem(title: 'Số điện thoại', info: '0971116262'),
        Divider(
          color: const Color(0xffE6E6E6),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        infoItem(title: 'Email', info: 'Abcxyz@gmail.com'),
        const _FamilyMemberTile(
          memberCount: 1,
        ),
        GestureDetector(
          onTap: () {
            showDialog<String>(
                context: context,
                builder: (BuildContext context) => const ChangeChuHoInfo());
          },
          child: const _EditInfo('Chỉnh sửa thông tin Chủ hộ'),
        ),
      ],
    );
  }
}

class _ApartmentInfo extends StatelessWidget {
  const _ApartmentInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 16.w,
            ),
            Text(
              'Thông tin căn hộ',
              style: defaultText16B,
            ),
            const Spacer(),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        infoItem(title: 'Số nhà ', info: '506A'),
        Divider(
          color: const Color(0xffE6E6E6),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        infoItem(title: 'Tầng', info: '4'),
        Divider(
          color: const Color(0xffE6E6E6),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        infoItem(title: 'Diện tích mặt sàn', info: '60m2'),
        Divider(
          color: const Color(0xffE6E6E6),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        infoItem(title: 'Tình trạng', info: 'Hộ gia đình'),
        Divider(
          color: const Color(0xffE6E6E6),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        GestureDetector(
            onTap: () {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => const ChangeCanHoInfo());
            },
            child: const _EditInfo('Chỉnh sửa thông tin căn hộ')),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}

class _FamilyMemberTile extends StatelessWidget {
  final int memberCount;

  const _FamilyMemberTile({required this.memberCount});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => const FamilyMemberScreen()),
          ),
        );
      },
      child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 20.h,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 10.h,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffE6E6E6), width: 1),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            // boxShadow: const [
            //   BoxShadow(
            //     color: Colors.black12,
            //     blurRadius: 4,
            //     offset: Offset(0, 2),
            //   ),
            // ],
          ),
          child: Row(
            children: [
              Text(
                'Thành viên trong hộ gia đình ($memberCount)',
                style: defaultText16Re,
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 18),
            ],
          )),
    );
  }
}

class _EditInfo extends StatelessWidget {
  const _EditInfo(this.title);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff25AAE1), width: 1),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          // boxShadow: const [
          //   BoxShadow(
          //     color: Colors.black12,
          //     blurRadius: 4,
          //     offset: Offset(0, 2),
          //   ),
          // ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/edit_info.svg',
              width: 16.w,
              height: 16.h,
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              title,
              style: defaultText14B.copyWith(color: const Color(0xff25AAE1)),
            ),
          ],
        ));
  }
}
