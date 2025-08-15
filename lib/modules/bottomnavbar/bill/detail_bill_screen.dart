import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/models/info_model.dart';
import 'package:ha_duong/modules/bottomnavbar/bill/payment_screen.dart';
import 'package:ha_duong/utils/constants/color.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:intl/intl.dart';

class DetailBillScreen extends StatelessWidget {
  const DetailBillScreen(
      {super.key, required this.type, required this.receiptsDetailModel});
  final AllReceiptDetailModel receiptsDetailModel;
  final int type;
  int get totalFinalFee {
    int fee = int.tryParse(receiptsDetailModel.receiptsDetailModel.fee) ?? 0;
    int feeDebt =
        int.tryParse(receiptsDetailModel.receiptsDetailModel.feeDebt) ?? 0;
    int feePaid =
        int.tryParse(receiptsDetailModel.receiptsDetailModel.feePaid) ?? 0;
    int phiThuThua =
        int.tryParse(receiptsDetailModel.receiptsDetailModel.phiThuThua) ?? 0;

    if (receiptsDetailModel.receiptsDetailModel.code != null &&
        receiptsDetailModel.receiptsDetailModel.code!.isNotEmpty) {
      int amountMoney =
          int.parse(receiptsDetailModel.receiptsDetailModel.amountMoney ?? '0');
      return fee + feeDebt - feePaid - phiThuThua - amountMoney;
    } else {
      return fee + feeDebt - feePaid - phiThuThua;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Chi tiết hoá đơn'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1), // chiều cao của divider
          child: Divider(
            height: 1,
            color: Colors.grey,
          ),
        ),
        scrolledUnderElevation: 0,
        centerTitle: true,
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
            child: Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  _ItemBill(
                    type: type,
                    receiptsDetailModel:
                        receiptsDetailModel.receiptsDetailModel,
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
                          color:
                              const Color(0xff8A8A8A).withValues(alpha: 0.12),
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
                              receiptsDetailModel.receiptsDetailModel.fullName,
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
                          color:
                              const Color(0xff8A8A8A).withValues(alpha: 0.12),
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
                              receiptsDetailModel
                                  .receiptsDetailModel.receiptsTime,
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
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Chi tiết hoá đơn',
                    style: defaultText18B,
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 28.h, left: 16.w, right: 16.w),
                  //   child: SizedBox(
                  //     height: 392.h,
                  //     width: 343.w,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               'Hoá đơn điện',
                  //               style: defaultText18B,
                  //             ),
                  //             SizedBox(
                  //               height: 360.h,
                  //               width: 240.w,
                  //               child: ListView.builder(
                  //                 shrinkWrap: true,
                  //                 physics: const NeverScrollableScrollPhysics(),
                  //                 itemCount: electricBill.length,
                  //                 itemBuilder: (context, index) {
                  //                   return Padding(
                  //                     padding:
                  //                         EdgeInsets.symmetric(vertical: 12.h),
                  //                     child: Text(
                  //                       electricBill[index],
                  //                       style: defaultText14M,
                  //                     ),
                  //                   );
                  //                 },
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         Column(
                  //           crossAxisAlignment: CrossAxisAlignment.end,
                  //           children: [
                  //             Text(
                  //               '298.700 đ',
                  //               style: defaultText18B,
                  //             ),
                  //             SizedBox(
                  //               height: 360.h,
                  //               width: 100.w,
                  //               child: ListView.builder(
                  //                 shrinkWrap: true,
                  //                 physics: const NeverScrollableScrollPhysics(),
                  //                 itemCount: electricMoney.length,
                  //                 itemBuilder: (context, index) {
                  //                   return Padding(
                  //                     padding:
                  //                         EdgeInsets.symmetric(vertical: 12.h),
                  //                     child: Text(
                  //                       electricMoney[index],
                  //                       style: defaultText14M,
                  //                       textAlign: TextAlign.end,
                  //                     ),
                  //                   );
                  //                 },
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.h,
                      bottom: 10.h,
                    ),
                    child: Text(
                      'Hoá đơn gửi xe',
                      style: defaultText16B,
                    ),
                  ),
                  SizedBox(
                    height: receiptsDetailModel.receiptsDetailModel.noteModel[0]
                            .vehicleModel.length *
                        170.h, // hoặc dùng MediaQuery nếu cần scroll toàn màn
                    child: ListView.builder(
                      physics:
                          const NeverScrollableScrollPhysics(), // nếu bạn đang bọc trong SingleChildScrollView
                      shrinkWrap: true,
                      itemCount: receiptsDetailModel
                          .receiptsDetailModel.noteModel[0].vehicleModel.length,
                      itemBuilder: (context, index) {
                        final vehicle = receiptsDetailModel
                            .receiptsDetailModel
                            .noteModel[0]
                            .vehicleModel[index]; // giả sử luôn có 1 vehicle

                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Dash(
                                    direction: Axis.horizontal,
                                    dashLength: 6,
                                    length: 160.w,
                                    dashGap: 4,
                                    dashColor: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 160.h,
                                    width: 150.w,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Chủ xe:', style: defaultText14M),
                                        Text('Số điện thoại:',
                                            style: defaultText14M),
                                        Text('Tên phương tiện:',
                                            style: defaultText14M),
                                        Text('Phí:', style: defaultText14M),
                                        Text('Biển số:', style: defaultText14M),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Dash(
                                    direction: Axis.horizontal,
                                    dashLength: 6,
                                    length: 180.w,
                                    dashGap: 4,
                                    dashColor: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 160.h,
                                    width: 170.w,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(vehicle.fullName,
                                            style: defaultText14M),
                                        Text(vehicle.phone,
                                            style: defaultText14M),
                                        Text(vehicle.vehicleName,
                                            style: defaultText14M),
                                        Text(
                                            '${formatCurrency(vehicle.fee)}  đ',
                                            style: defaultText14M),
                                        Text(vehicle.licensePlates,
                                            style: defaultText14M),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Dash(
                    direction: Axis.horizontal,
                    dashLength: 6,
                    length: 343.w,
                    dashGap: 4,
                    dashColor: Colors.grey,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.h,
                      bottom: 10.h,
                    ),
                    child: Text(
                      'Phí toà nhà',
                      style: defaultText16B,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 160.h,
                              width: 150.w,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Diện tích:',
                                    style: defaultText14M,
                                  ),
                                  Text(
                                    'Phí:',
                                    style: defaultText14M,
                                  ),
                                  Text(
                                    'Phí thu thêm:',
                                    style: defaultText14M,
                                  ),
                                  Text(
                                    'Phí bảo trì:',
                                    style: defaultText14M,
                                  ),
                                  Text(
                                    'Tiền điện:',
                                    style: defaultText14M,
                                  ),
                                  Text(
                                    'Tiền nước:',
                                    style: defaultText14M,
                                  ),
                                ],
                              ),
                            ),
                            Dash(
                              direction: Axis.horizontal,
                              dashLength: 6,
                              length: 160.w,
                              dashGap: 4,
                              dashColor: Colors.grey,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 160.h,
                              width: 170.w,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                      '${receiptsDetailModel.receiptsDetailModel.noteModel[0].phiToaNha.dienTich} m2',
                                      style: defaultText14M),
                                  Text(
                                      '${formatCurrency(receiptsDetailModel.receiptsDetailModel.noteModel[0].phiToaNha.phi.toStringAsFixed(0))}  đ',
                                      style: defaultText14M),
                                  Text(
                                      receiptsDetailModel.receiptsDetailModel
                                          .noteModel[0].phiToaNha.phiThuThem,
                                      style: defaultText14M),
                                  Text(
                                      receiptsDetailModel.receiptsDetailModel
                                          .noteModel[0].phiToaNha.phiBaoTri
                                          .toString(),
                                      style: defaultText14M),
                                  Text(
                                      receiptsDetailModel.receiptsDetailModel
                                          .noteModel[0].phiToaNha.tienDien
                                          .toString(),
                                      style: defaultText14M),
                                  Text(
                                      receiptsDetailModel.receiptsDetailModel
                                          .noteModel[0].phiToaNha.tienNuoc
                                          .toString(),
                                      style: defaultText14M),
                                ],
                              ),
                            ),
                            Dash(
                              direction: Axis.horizontal,
                              dashLength: 6,
                              length: 180.w,
                              dashGap: 4,
                              dashColor: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  type == 1
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Hạn thanh toán', style: defaultText14M),
                            Text(
                              receiptsDetailModel
                                  .receiptsDetailModel.hanThanhToan,
                              style: defaultText14B.copyWith(
                                color: type == 1
                                    ? const Color(0xffE80707)
                                    : keyBlack,
                              ),
                            )
                          ],
                        )
                      : const SizedBox(),
                  SizedBox(
                    height: 6.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tổng Phí', style: defaultText14M),
                      Text(
                        '${formatCurrency(receiptsDetailModel.receiptsDetailModel.fee)} đ',
                        style: defaultText14B.copyWith(
                          color: type == 1 ? const Color(0xffE80707) : keyBlack,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Phí Nợ', style: defaultText14M),
                      Text(
                        '${formatCurrency(receiptsDetailModel.receiptsDetailModel.feeDebt)} đ',
                        style: defaultText14B.copyWith(
                          color: type == 1 ? const Color(0xffE80707) : keyBlack,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Phí đã thanh toán', style: defaultText14M),
                      Text(
                        '${formatCurrency(receiptsDetailModel.receiptsDetailModel.feePaid)} đ',
                        style: defaultText14B.copyWith(
                          color: type == 1 ? const Color(0xffE80707) : keyBlack,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Phí thu thừa', style: defaultText14M),
                      Text(
                        '${formatCurrency(receiptsDetailModel.receiptsDetailModel.phiThuThua)} đ',
                        style: defaultText14B.copyWith(
                          color: type == 1 ? const Color(0xffE80707) : keyBlack,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  (receiptsDetailModel.receiptsDetailModel.code != null)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Mã giảm giá \n', style: defaultText14M),
                            Text(
                              '${formatCurrency(receiptsDetailModel.receiptsDetailModel.amountMoney ?? '0')} đ',
                              style: defaultText14B.copyWith(
                                color: type == 1
                                    ? const Color(0xffE80707)
                                    : keyBlack,
                              ),
                            )
                          ],
                        )
                      : const SizedBox(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Phí thanh toán thực tế', style: defaultText14M),
                      Text(
                        '${formatCurrency(totalFinalFee.toString())} đ',
                        style: defaultText14B.copyWith(
                          color: type == 1 ? const Color(0xffE80707) : keyBlack,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 120.h,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 98.h,
              width: 375.w,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    spreadRadius: 0,
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: type == 1
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => PaymentScreen(
                                  paymentInforModel:
                                      receiptsDetailModel.paymentInforModel,
                                  totalFinalFee: totalFinalFee,
                                  receiptTime: receiptsDetailModel
                                      .receiptsDetailModel.receiptsTime,
                                )),
                          ),
                        );
                      }
                    : () {},
                child: Container(
                  width: 343.w,
                  height: 50.h,
                  margin: EdgeInsets.only(
                      left: 16.w, bottom: 30.h, top: 16.w, right: 16.w),
                  constraints: BoxConstraints(maxHeight: 120.h),
                  decoration: BoxDecoration(
                    gradient: type == 1
                        ? const LinearGradient(
                            colors: [
                              Color(0xFF25AAE1),
                              Color(0xFF004071),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.0, 1.0],
                          )
                        : LinearGradient(
                            colors: [
                              const Color(0xFF8A8A8A).withValues(alpha: 0.12),
                              const Color(0xFF8A8A8A).withValues(alpha: 0.12),
                            ],
                          ),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Center(
                      child: Text(
                    type == 1 ? 'Thanh toán ngay' : "Đã thanh toán",
                    style: defaultText14B.copyWith(
                        color:
                            type == 1 ? Colors.white : const Color(0xff004071)),
                  )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemBill extends StatelessWidget {
  const _ItemBill({required this.type, required this.receiptsDetailModel});
  final ReceiptsDetailModel receiptsDetailModel;
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
            width: 200.w,
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
                    SizedBox(
                      height: 4.h,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Tổng phí: ',
                        style: defaultText14M.copyWith(
                          color: const Color(0xff8A8A8A).withValues(alpha: 0.8),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                '${formatCurrency(receiptsDetailModel.fee)}  đ',
                            style: defaultText14B.copyWith(
                              color: const Color(0xff004071),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Tháng: ',
                        style: defaultText14M.copyWith(
                          color: const Color(0xff004071),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: receiptsDetailModel.receiptsTime,
                            style: defaultText14B.copyWith(
                              color: const Color(0xff004071),
                            ),
                          ),
                        ],
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
List<String> vehicleBill = [
  'Chủ xe:',
  'Số điện thoại:',
  'Tên phương tiện:',
  'Phí:',
  'Biến số:',
];
List<String> phiToaNha = [
  'Diện tích:',
  'Phí:',
  'Phí thu thêm:',
  'Phí bảo trì:',
  'Tiền điện:',
  'Tiền nước:',
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

String formatCurrency(String input) {
  final number = int.tryParse(input);
  if (number == null) return input; // fallback nếu input không hợp lệ
  final formatter = NumberFormat('#,###', 'vi_VN');
  return formatter.format(number);
}
