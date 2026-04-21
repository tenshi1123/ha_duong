import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/utils/constants/styles.dart';

import 'personal_screen.dart';

class RegisteredVehicleScreen extends StatelessWidget {
  const RegisteredVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Phương tiện đăng ký'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const Divider(),
          SizedBox(
            height: 28.h,
          ),
          const VehicleItem(),
          Divider(
            color: const Color(0xffE6E6E6),
            thickness: 6,
            endIndent: 16.w,
            indent: 16.w,
            height: 24.h,
          ),
          const VehicleItem(),
        ],
      ),
    );
  }
}

class VehicleItem extends StatelessWidget {
  const VehicleItem({super.key});

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
              'Xe máy',
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
                    'Chủ xe',
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
        infoItem(title: 'Chủ sở hữu', info: 'PHẠM TUẤN KHANG'),
        Divider(
          color: const Color(0xffE6E6E6),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        infoItem(title: 'Biển số xe', info: '29BE-019.19'),
        Divider(
          color: const Color(0xffE6E6E6),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        infoItem(title: 'Liên hệ', info: '0971116262'),
        Divider(
          color: const Color(0xffE6E6E6),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        infoItem(title: 'Đăng kí từ', info: '02/06/2023'),
        Divider(
          color: const Color(0xffE6E6E6),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        infoItem(title: 'Phí gửi', info: '50.000đ/Tháng'),
      ],
    );
  }
}
