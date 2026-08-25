import 'package:ha_duong/l10n/app_localizations.dart';
import 'dart:io';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/bql_repo/info_repo_bql.dart';
import 'package:ha_duong/main.dart';
import 'package:ha_duong/modules/bottomnavbar/bql_bottom_nav_bar.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:ha_duong/utils/widget/pick_image_bql.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({
    super.key,
  });

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isFilled = false;
  @override
  void initState() {
    phoneController.text = infoHomeModel.phone;
    emailController.text = infoHomeModel.email;
    nameController.text = infoHomeModel.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xff3C3C3C)),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        title: Text(
          AppLocalizations.of(context)!.bqlThongTinTaiKhoan,
          style: defaultText18B,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                ValueListenableBuilder<List<File>>(
                  valueListenable: mainAvatarNotifier,
                  builder: (context, value, _) {
                    if (value.isNotEmpty) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(55.r),
                        child: Image.file(
                          value.first,
                          width: 110.r,
                          height: 110.r,
                          fit: BoxFit.cover,
                        ),
                      );
                    } else {
                      return CircleAvatar(
                        radius: 60.r,
                        backgroundImage: NetworkImage(
                          infoHomeModel.avatar,
                        ),
                      );
                    }
                  },
                ),
                Positioned(
                  bottom: 0,
                  right: 5.w,
                  child: GestureDetector(
                    onTap: () {
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
                                        buildUploadOption(
                                          icon: Icons.image_outlined,
                                          text: "Tải ảnh lên",
                                          onTap: () {
                                            // Xử lý tải ảnh lên
                                            pickImageFromGallery(
                                              context,
                                              2,
                                            );
                                          },
                                        ),
                                        SizedBox(
                                            width: 56
                                                .w), // Khoảng cách giữa hai nút
                                        // Nút Chụp ảnh
                                        buildUploadOption(
                                          icon: Icons.camera_alt_outlined,
                                          text: "Chụp ảnh",
                                          onTap: () {
                                            // Xử lý chụp ảnh
                                            pickImageFromCamera(
                                              context,
                                              2,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                    },
                    child: Image.asset(
                      'assets/images/camera.png',
                      width: 28.w,
                      height: 28.h,
                    ),
                  ),
                ),
              ],
            ),
            MyTextFormField(
              labelText: AppLocalizations.of(context)!.bqlHoVaTen,
              controller: nameController,
              //keyboardType: TextInputType.phone,
              onChanged: (value) {
                setState(() {
                  isFilled = true;
                });
              },
              hasIcon: true,
            ),
            MyTextFormField(
              labelText: AppLocalizations.of(context)!.bqlChucVu,
              controller: TextEditingController(text: infoHomeModel.chucVu),
              hasIcon: false,
            ),
            MyTextFormField(
              labelText: AppLocalizations.of(context)!.bqlSoHieu,
              controller: TextEditingController(text: infoHomeModel.code),
              hasIcon: false,
            ),
            MyTextFormField(
              labelText: AppLocalizations.of(context)!.bqlEmail,
              controller: emailController,
              //keyboardType: TextInputType.phone,
              onChanged: (value) {
                setState(() {
                  isFilled = true;
                });
              },
              hasIcon: true,
            ),
            MyTextFormField(
              labelText: 'Số điện thoại',
              controller: phoneController,
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                setState(() {
                  isFilled = true;
                });
              },
              hasIcon: true,
            ),
            SizedBox(
              height: 47.h,
            ),
            GestureDetector(
              onTap: isFilled
                  ? () async {
                      String message = await InfoRepo().changeInfo(
                        phoneController.text,
                        emailController.text,
                        nameController.text,
                      );
                      infoHomeModel.name = nameController.text;
                      infoHomeModel.email = emailController.text;
                      infoHomeModel.phone = phoneController.text;
                      setState(() {});

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              message,
                              style: defaultText16B,
                            ),
                            actionsPadding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            actions: <Widget>[
                              TextButton(
                                child: Text(
                                  AppLocalizations.of(context)!.bqlOk,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  : null,
              child: Container(
                height: 52.h,
                width: 343.w,
                decoration: BoxDecoration(
                  color: isFilled
                      ? Colors.lightBlue
                      : const Color(0xff292929).withValues(
                          alpha: 0.06,
                        ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.r),
                  ),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.bqlCapNhat,
                    style: defaultText16B.copyWith(
                      color: isFilled
                          ? Colors.white
                          : const Color(0xff292929).withValues(
                              alpha: 0.48,
                            ),
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

class MyTextFormField extends StatefulWidget {
  final String labelText;
  final String initialValue;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final bool hasIcon;
  const MyTextFormField({
    super.key,
    required this.labelText,
    this.initialValue = '',
    this.controller,
    this.keyboardType,
    this.onChanged,
    required this.hasIcon,
  });

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      //height: 66.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
        border: Border.all(
          color: (_focusNode.hasFocus && widget.hasIcon)
              ? const Color(0xFF007AFF)
              : const Color(0xff292929).withAlpha(50),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.labelText,
                style: defaultText16Re,
              ),
              SizedBox(
                height: 30.h,
                width: 300.w,
                child: TextFormField(
                  onTap: () {
                    setState(() {});
                  },
                  readOnly: !widget.hasIcon,
                  controller: widget.controller,
                  keyboardType: widget.keyboardType,
                  style: defaultText16M,
                  focusNode: _focusNode,
                  onChanged: widget.onChanged,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: const TextStyle(color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(vertical: 1),
                    suffixIcon: widget.hasIcon
                        ? !_focusNode.hasFocus
                            ? Container(
                                padding: EdgeInsets.symmetric(vertical: 6.h),
                                child: SvgPicture.asset(
                                  'assets/icons/pencil.svg',
                                  height: 10.h,
                                  fit: BoxFit.fitHeight,
                                ))
                            : GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  setState(() {});
                                },
                                child: Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 6.h),
                                    child: SvgPicture.asset(
                                      'assets/icons/unfocus.svg',
                                      height: 10.h,
                                      fit: BoxFit.fitHeight,
                                    )),
                              )
                        : const SizedBox(),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 8.h,
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget buildUploadOption({
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
          radius: 26.r,
          backgroundColor: Colors.transparent,
          child: Container(
            height: 52.h,
            width: 52.r,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.lightBlue,
              // gradient: LinearGradient(
              //   colors: [
              //     Color(0xff25AAE1),
              //     Color(0xff004071),
              //   ],
              // ),
            ),
            child: Icon(icon, size: 26.r, color: Colors.white),
          ),
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
