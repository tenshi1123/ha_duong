// import 'package:ha_duong/models/info_model.dart';
// import 'package:ha_duong/utils/constants/styles.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'custom_widget.dart';

// Đây là dialog điền form thông tin dăng ký dịch vụ
// class ServiceDialog extends StatefulWidget {
//   const ServiceDialog({super.key, required this.dangKyModel});
//   final DangKyModel dangKyModel;
//   @override
//   State<ServiceDialog> createState() => _ServiceDialogState();
// }

// class _ServiceDialogState extends State<ServiceDialog> {
//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: SingleChildScrollView(
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.all(Radius.circular(16.r)),
//             // boxShadow: const [
//             //   BoxShadow(
//             //     color: Colors.black,
//             //     offset: Offset(6, 6),
//             //     spreadRadius: 2,
//             //     blurStyle: BlurStyle.solid,
//             //   ),
//             // ],
//           ),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(
//                   height: 20.h,
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(left: 16.w),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(16.r),
//                       topRight: Radius.circular(16.r),
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Image.asset(
//                         'assets/images/personal.png',
//                         width: 34.w,
//                         height: 34.w,
//                         fit: BoxFit.fill,
//                       ),
//                       Text(
//                         'Thông tin khách hàng',
//                         style: defaultText16B,
//                       ),
//                       const CloseButton(
//                         color: Colors.black,
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20.h,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16.w),
//                   child: CustomTextFormField(
//                     labelText: 'Họ và tên',
//                     hintText: 'Nhập họ và tên',
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Vui lòng nhập họ và tên';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20.h,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16.w),
//                   child: CustomTextFormField(
//                     labelText: 'Số điện thoại',
//                     hintText: 'Nhập Số điện thoại',
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Vui lòng nhập Số điện thoại';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20.h,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16.w),
//                   child: CustomTextFormField(
//                     labelText: 'Căn hộ',
//                     hintText: 'Nhập Căn hộ',
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Vui lòng nhập Căn hộ';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 GestureDetector(
//                   onTap: () {
//                     if (_formKey.currentState!.validate()) {
//                       showDialog<String>(
//                         context: context,
//                         builder: (BuildContext context) => AlertDialog(
//                           title: Text(
//                             'Gửi thông tin thành công',
//                             style: defaultText16B,
//                           ),
//                           actions: <Widget>[
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.pop(
//                                   context,
//                                 );
//                                 Navigator.pop(
//                                   context,
//                                 );
//                               },
//                               child: const Text('OK'),
//                             ),
//                           ],
//                         ),
//                       );
//                     }
//                   },
//                   child: Container(
//                     width: 303.w,
//                     height: 50.h,
//                     margin: EdgeInsets.only(
//                         left: 16.w, bottom: 30.h, top: 16.w, right: 16.w),
//                     constraints: BoxConstraints(maxHeight: 120.h),
//                     decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           Color(0xFF25AAE1),
//                           Color(0xFF004071),
//                         ],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         stops: [0.0, 1.0],
//                       ),
//                       borderRadius: BorderRadius.all(Radius.circular(15)),
//                     ),
//                     child: Center(
//                         child: Text(
//                       'Gửi thông tin',
//                       style: defaultText14B.copyWith(color: Colors.white),
//                     )),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
