import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/utils/constants/styles.dart';

class DetailBillScreen extends StatelessWidget {
  const DetailBillScreen({super.key, required this.type});
  final int type;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text('Chi tiết hoá đơn        '),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  height: 1,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 20.h,
                ),
                _ItemBill(
                  type: type,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 70.h,
                      width: 164.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.r),
                        ),
                        color: const Color(0xff8A8A8A).withValues(alpha: 0.12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Tên khách hàng:',
                            style: defaultText14.copyWith(
                              color: const Color(0xff383838),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Nguyễn Thế Hoàng',
                            style: defaultText14.copyWith(
                              color: const Color(0xff383838),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 70.h,
                      width: 164.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.r),
                        ),
                        color: const Color(0xff8A8A8A).withValues(alpha: 0.12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Kỳ hoá đơn:',
                            style: defaultText14.copyWith(
                              color: const Color(0xff383838),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '09/2024',
                            style: defaultText14.copyWith(
                              color: const Color(0xff383838),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 28.h, left: 16.w),
                  child: Text(
                    'Chi tiết hoá đơn',
                    style: defaultText18B,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 28.h, left: 16.w, right: 16.w),
                  child: SizedBox(
                    height: 392.h,
                    width: 343.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hoá đơn điện',
                              style: defaultText18B,
                            ),
                            SizedBox(
                              height: 360.h,
                              width: 240.w,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: electricBill.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 12.h),
                                    child: Text(
                                      electricBill[index],
                                      style: defaultText14M,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '298.700 đ',
                              style: defaultText18B,
                            ),
                            SizedBox(
                              height: 360.h,
                              width: 100.w,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: electricMoney.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 12.h),
                                    child: Text(
                                      electricMoney[index],
                                      style: defaultText14M,
                                      textAlign: TextAlign.end,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 28.h, left: 16.w, right: 16.w),
                  child: SizedBox(
                    height: 392.h,
                    width: 343.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hoá đơn điện',
                              style: defaultText18B,
                            ),
                            SizedBox(
                              height: 360.h,
                              width: 240.w,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: electricBill.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 12.h),
                                    child: Text(
                                      electricBill[index],
                                      style: defaultText14M,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '298.700 đ',
                          style: defaultText18B,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 100.h,
                )
              ],
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomLeft,
          //   child: Container(
          //     height: 98.h,
          //     width: 375.w,
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.black.withValues(alpha: 0.08),
          //           spreadRadius: 0,
          //           blurRadius: 16,
          //           offset: const Offset(0, -4),
          //         ),
          //       ],
          //     ),
          //     child: Container(
          //       width: 343.w,
          //       height: 50.h,
          //       margin: EdgeInsets.only(
          //           left: 16.w, bottom: 30.h, top: 16.w, right: 16.w),
          //       constraints: BoxConstraints(maxHeight: 120.h),
          //       decoration: const BoxDecoration(
          //         gradient: LinearGradient(
          //           colors: [
          //             Color(0xFF25AAE1),
          //             Color(0xFF004071),
          //           ],
          //           begin: Alignment.topCenter,
          //           end: Alignment.bottomCenter,
          //           stops: [0.0, 1.0],
          //         ),
          //         borderRadius: BorderRadius.all(Radius.circular(15)),
          //       ),
          //       child: Center(
          //           child: Text(
          //         'Thanh toán ngay',
          //         style: defaultText14B.copyWith(color: Colors.white),
          //       )),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class _ItemBill extends StatelessWidget {
  const _ItemBill({required this.type});
  final int type;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 136.h,
      width: 343.w,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            spreadRadius: 0,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            //height: 60.h,
            width: 188.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/detail_bill.png',
                  width: 32.w,
                  //height: 32.h,
                  fit: BoxFit.fitWidth,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hoá đơn hàng tháng',
                      style: defaultText14M.copyWith(
                        color: const Color(0xff8A8A8A).withValues(alpha: 0.8),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Tổng phí: ',
                        style: defaultText14M.copyWith(
                          color: const Color(0xff8A8A8A).withValues(alpha: 0.8),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '2.969.000 đ',
                            style: defaultText14B.copyWith(
                              color: const Color(0xff004071),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'tháng 09/2024',
                      style: defaultText14B.copyWith(
                        color: const Color(0xff004071),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Tình trạng: ',
              style: defaultText14.copyWith(
                color: const Color(0xff004071),
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(
                  text: type == 1 ? 'Chưa thanh toán' : 'Đã thanh toán',
                  style: defaultText14M.copyWith(
                    color: type == 0
                        ? const Color(0xff25AAE1)
                        : const Color(0xffED3D17),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

List<String> electricBill = [
  'Số sử dụng:',
  'Số kỳ đầu:',
  'Số kỳ cuối:',
  'Đơn vị tính:',
  'Chi tiết số sử dụng:',
  ' (Từ 1-50 KWh) x giá 1.950 đ:',
  ' (Từ 51-100 KWh) x giá 2.015 đ:',
  ' (Từ 101-200 KWh) x giá 2.340 đ:',
  ' (Từ 201-300 KWh) x giá 2.947 đ:',
  ' (Từ 301-400 KWh) x giá 3.294 đ:',
  ' (Từ 400 KWh trở lên) x giá 3.403 đ:',
  'Tổng tiền:',
];

List<String> waterBill = [
  'Số sử dụng:',
  'Số kỳ đầu:',
  'Số kỳ cuối:',
  'Đơn vị tính:',
  'Chi tiết số sử dụng:',
  ' (Từ 1-10 m3) x giá 9.775 đ:',
  ' (Từ 11-20 m3) x giá 11.385 đ:',
  ' (Từ 21-30 m3) x giá 18.400 đ:',
  ' (Từ 31 m3 trở lên) x giá 31.050 đ:',
  'Tổng tiền:',
];

List<String> parkingBill = [
  'Đơn vị tính:',
  'Chi tiết',
  'Tổng tiền:',
];
List<String> electricMoney = [
  '171',
  '26',
  '247',
  'KWh',
  '',
  '84.672 đ',
  '84.672 đ',
  '84.672 đ',
  '84.672 đ',
  '84.672 đ',
  '84.672 đ',
  '84.672 đ',
];
List<String> waterMoney = [
  '42',
  '56',
  '98',
  'Khối',
  '',
  '84.672 đ',
  '84.672 đ',
  '84.672 đ',
  '84.672 đ',
  '84.672 đ',
];
