import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/models/apartment_model.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:intl/intl.dart';

import 'personal_screen.dart';

class RegisteredVehicleScreen extends StatelessWidget {
  const RegisteredVehicleScreen({super.key, required this.listVehicle});
  final List<VehicleModel> listVehicle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Phương tiện đăng ký'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: listVehicle.length,
        itemBuilder: (context, index) {
          return VehicleItem(
            vehicleModel: listVehicle[index],
          );
        },
      ),
    );
  }
}

// const Divider(),
// SizedBox(
//   height: 28.h,
// ),
// const VehicleItem(),
// Divider(
//   color: const Color(0xffF0F0F0),
//   thickness: 6,
//   endIndent: 16.w,
//   indent: 16.w,
//   height: 24.h,
// ),
// const VehicleItem(),
class VehicleItem extends StatelessWidget {
  const VehicleItem({super.key, required this.vehicleModel});
  final VehicleModel vehicleModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: const Color(0xffF0F0F0),
          thickness: 6,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        Row(
          children: [
            SizedBox(
              width: 16.w,
            ),
            Text(
              vehicleModel.vehicleName,
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
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 20.h,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 12.h,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffF1F4F5),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/images/location.png',
                height: 20.5.h,
              ),
              SizedBox(width: 8.w),
              Text(
                'Căn ${vehicleModel.apartmentName}',
                style: defaultText14M,
              ),
            ],
          ),
        ),
        infoItem(
          title: 'Chủ sở hữu',
          info: vehicleModel.fullName,
        ),
        Divider(
          color: const Color(0xffF0F0F0),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        infoItem(
          title: 'Biển số xe',
          info: vehicleModel.licensePlates,
        ),
        Divider(
          color: const Color(0xffF0F0F0),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        infoItem(title: 'Liên hệ', info: vehicleModel.phone),
        Divider(
          color: const Color(0xffF0F0F0),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        infoItem(title: 'Đăng kí từ', info: vehicleModel.createAt),
        Divider(
          color: const Color(0xffF0F0F0),
          thickness: 1,
          endIndent: 16.w,
          indent: 16.w,
          height: 24.h,
        ),
        infoItem(
            title: 'Phí gửi',
            info: '${formatCurrency(vehicleModel.fee)}đ/Tháng'),
      ],
    );
  }
}

String formatCurrency(dynamic value) {
  final formatter = NumberFormat('#,###', 'vi_VN');

  try {
    // Nếu là String, chuyển sang double
    if (value is String) {
      value = value.replaceAll('.', '').replaceAll(',', '');
      value = double.parse(value);
    }

    // Nếu là int hoặc double
    if (value is int || value is double) {
      return formatter.format(value);
    }

    // Nếu không thuộc kiểu hợp lệ
    return '0';
  } catch (e) {
    return '0';
  }
}
