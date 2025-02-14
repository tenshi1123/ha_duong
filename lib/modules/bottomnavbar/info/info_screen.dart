import 'package:ha_duong/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
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
        title: Center(
          child: Text(
            'Thông tin tài khoản    ',
            style: defaultText18B,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage('assets/images/avatar2.png'),
              height: 120.h,
              width: 120.w,
              fit: BoxFit.fill,
            ),
            MyTextFormField(
              labelText: 'Họ và tên',
              controller: TextEditingController(text: 'Nguyễn Thế Hoàng'),
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                print('Họ và tên đã thay đổi: $value');
              },
            ),
            MyTextFormField(
              labelText: 'Số điện thoại',
              controller: TextEditingController(text: '097 111 626'),
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                print('Số điện thoại đã thay đổi: $value');
              },
            ),
            MyTextFormField(
              labelText: 'Email',
              controller: TextEditingController(text: 'Abcxyz@ha_duong.vn'),
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                print('Email đã thay đổi: $value');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyTextFormField extends StatefulWidget {
  final String labelText;
  final String initialValue;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;

  const MyTextFormField({
    super.key,
    required this.labelText,
    this.initialValue = '',
    this.controller,
    this.keyboardType,
    this.onChanged,
  });

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 70.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
        border: Border.all(
          color: const Color(0xff292929).withAlpha(16),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8.h,
              ),
              Text(
                widget.labelText,
                style: defaultText14M.copyWith(
                  color: const Color(0xff292929).withAlpha(80),
                ),
              ),
              SizedBox(
                height: 30.h,
                width: 300.w,
                child: TextFormField(
                  onTap: () {
                    setState(() {});
                  },
                  controller: widget.controller,
                  keyboardType: widget.keyboardType,
                  style: defaultText16M,
                  focusNode: _focusNode,
                  //initialValue: initialValue,
                  onChanged: widget.onChanged,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    //hintText: labelText,
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 1),
                    // suffixIcon: _focusNode.hasFocus
                    //     ? IconButton(
                    //         icon: const Icon(Icons.close),
                    //         onPressed: _focusNode.unfocus,
                    //       )
                    //     : const Icon(Icons.edit),
                  ),
                ),
              ),
            ],
          ),
          // IconButton(
          //   icon: const Icon(Icons.close),
          //   onPressed: () {
          //     // Xử lý khi người dùng nhấn nút xóa
          //     if (controller != null) {
          //       controller?.clear();
          //     }
          //     // Thực hiện các hành động khác nếu cần
          //   },
          // ),
        ],
      ),
    );
  }
}
