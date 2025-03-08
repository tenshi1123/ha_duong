import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:ha_duong/utils/widget/custom_widget.dart';
import 'package:image_picker/image_picker.dart';

class ChangeCanHoInfo extends StatefulWidget {
  const ChangeCanHoInfo({super.key});

  @override
  State<ChangeCanHoInfo> createState() => _ChangeCanHoInfoState();
}

class _ChangeCanHoInfoState extends State<ChangeCanHoInfo> {
  final _formKey = GlobalKey<FormState>();
  List<File> photos = <File>[];

  Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickMultiImage();
    photos = List<File>.from(
      (returnedImage).map(
        (e) => File(e.path),
      ),
    );
    //File(returnedImage!.path);
    if (photos.isNotEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                width: 343.w,
                height: 334.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.r))),
                child: Column(
                  children: [
                    Image.asset('assets/images/tick.png'),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        'Yêu cầu của bạn đã được gửi tới ban quản lý thành công',
                        style: defaultText16M.copyWith(
                          color: const Color(0xff2D323A),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 56.w, bottom: 56.h, top: 36.h, right: 56.w),
                      padding: EdgeInsetsDirectional.symmetric(
                        horizontal: 16.w,
                        vertical: 12.w,
                      ),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF25AAE1),
                            Color(0xFF004071),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0, 1.0],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Center(
                          child: Text(
                        'Ok',
                        style: defaultText14B.copyWith(color: Colors.white),
                      )),
                    ),
                  ],
                ),
              ),
            );
          });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      topRight: Radius.circular(16.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/apartment.png',
                        width: 34.w,
                        height: 34.w,
                        fit: BoxFit.fill,
                      ),
                      Text(
                        'Thay đổi thông tin căn hộ',
                        style: defaultText16B,
                      ),
                      const CloseButton(
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomTextFormField(
                    labelText: 'Số nhà',
                    hintText: 'Nhập số nhà',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập số nhà';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomTextFormField(
                    labelText: 'Tầng',
                    hintText: 'Nhập tầng',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập tầng';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomTextFormField(
                    labelText: 'Diện tích mặt sàn',
                    hintText: 'Nhập diện tích mặt sàn',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập diện tích mặt sàn';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomTextFormField(
                    labelText: 'Tình trạng',
                    hintText: 'Nhập tình trạng',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập tình trạng';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => Dialog(
                                child: Container(
                                  height: 166.h,
                                  width: 343.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.r),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // Nút Tải ảnh lên
                                        _buildUploadOption(
                                          icon: Icons.image_outlined,
                                          text: "Tải ảnh lên",
                                          onTap: () {
                                            // Xử lý tải ảnh lên
                                            _pickImageFromGallery();
                                          },
                                        ),
                                        SizedBox(
                                            width: 60
                                                .w), // Khoảng cách giữa hai nút
                                        // Nút Chụp ảnh
                                        _buildUploadOption(
                                          icon: Icons.camera_alt_outlined,
                                          text: "Chụp ảnh",
                                          onTap: () {
                                            // Xử lý chụp ảnh
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => CameraCamera(
                                                  onFile: (file) {
                                                    photos.add(file);
                                                    setState(() {});
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Dialog(
                                                            child: Container(
                                                              width: 343.w,
                                                              height: 334.h,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20.r))),
                                                              child: Column(
                                                                children: [
                                                                  Image.asset(
                                                                      'assets/images/tick.png'),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            16.w),
                                                                    child: Text(
                                                                      'Yêu cầu của bạn đã được gửi tới ban quản lý thành công',
                                                                      style: defaultText16M
                                                                          .copyWith(
                                                                        color: const Color(
                                                                            0xff2D323A),
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        left: 56
                                                                            .w,
                                                                        bottom: 56
                                                                            .h,
                                                                        top: 36
                                                                            .h,
                                                                        right: 56
                                                                            .w),
                                                                    padding:
                                                                        EdgeInsetsDirectional
                                                                            .symmetric(
                                                                      horizontal:
                                                                          16.w,
                                                                      vertical:
                                                                          12.w,
                                                                    ),
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      gradient:
                                                                          LinearGradient(
                                                                        colors: [
                                                                          Color(
                                                                              0xFF25AAE1),
                                                                          Color(
                                                                              0xFF004071),
                                                                        ],
                                                                        begin: Alignment
                                                                            .topCenter,
                                                                        end: Alignment
                                                                            .bottomCenter,
                                                                        stops: [
                                                                          0.0,
                                                                          1.0
                                                                        ],
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(15)),
                                                                    ),
                                                                    child: Center(
                                                                        child: Text(
                                                                      'Ok',
                                                                      style: defaultText14B.copyWith(
                                                                          color:
                                                                              Colors.white),
                                                                    )),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                    }
                  },
                  child: Container(
                    width: 303.w,
                    height: 50.h,
                    margin: EdgeInsets.only(
                        left: 16.w, bottom: 30.h, top: 16.w, right: 16.w),
                    constraints: BoxConstraints(maxHeight: 120.h),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF25AAE1),
                          Color(0xFF004071),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.0, 1.0],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Center(
                        child: Text(
                      'Gửi thông tin',
                      style: defaultText14B.copyWith(color: Colors.white),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildUploadOption({
  required IconData icon,
  required String text,
  required VoidCallback onTap,
}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: CircleAvatar(
          radius: 28.r,
          backgroundColor: Colors.blue,
          child: Icon(icon, size: 24, color: Colors.white),
        ),
      ),
      const SizedBox(height: 8),
      Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
    ],
  );
}
