import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/bql_repo/info_repo_bql.dart';
import 'package:ha_duong/main.dart';
import 'package:ha_duong/utils/constants/styles.dart';

import 'package:image_picker/image_picker.dart';

Future<void> pickImageFromCamera(
  BuildContext context,
  final int type, {
  String? rela,
  String? apartmentId,
  String? residentId,
}) async {
  final ImagePicker picker = ImagePicker();
  List<File> photos = [];

  final pickedImage = await picker.pickImage(source: ImageSource.camera);
  if (pickedImage != null) {
    photos.add(File(pickedImage.path));

    showDialog(
      context: context, // ← giờ đã được truyền vào
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.verified_user_outlined,
                              color: Colors.blue),
                          SizedBox(width: 8),
                          Text(
                            'Ảnh đại diện',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      ...photos.asMap().entries.map((entry) {
                        File photo = entry.value;

                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  photo,
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // Positioned(
                              //   top: 8,
                              //   right: 8,
                              //   child: GestureDetector(
                              //     onTap: () {
                              //       setStateDialog(() {
                              //         photos.removeAt(index);
                              //       });
                              //     },
                              //     child: Container(
                              //       decoration: BoxDecoration(
                              //         color: Colors.black54,
                              //         borderRadius: BorderRadius.circular(8),
                              //       ),
                              //       padding: const EdgeInsets.all(4),
                              //       child: const Icon(
                              //         Icons.remove,
                              //         color: Colors.white,
                              //         size: 20,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        );
                      }),
                      // OutlinedButton.icon(
                      //   onPressed: () async {
                      //     final newImage = await picker.pickImage(
                      //         source: ImageSource.camera);
                      //     if (newImage != null) {
                      //       setStateDialog(() {
                      //         photos.add(File(newImage.path));
                      //       });
                      //     }
                      //   },
                      //   icon: const Icon(Icons.camera_alt),
                      //   label: const Text('Chụp thêm ảnh'),
                      // ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () async {
                          // Xử lý gửi yêu cầu
                          Navigator.pop(context);
                          Navigator.pop(context);
                          mainAvatarNotifier.value = photos;
                          InfoRepo().changeAvatar(
                            photos.first,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                // success
                                'Cập nhật ảnh đại diện thành công!',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 16.w, bottom: 26.h, top: 16.h, right: 16.w),
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
                            'Xác nhận đổi ảnh đại diện',
                            style: defaultText14B.copyWith(color: Colors.white),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

Future pickImageFromGallery(
  BuildContext context,
  final int type, {
  String? rela,
  String? apartmentId,
  String? residentId,
}) async {
  final returnedImage = await ImagePicker().pickMultiImage();

  if (returnedImage.isNotEmpty) {
    List<File> photos = List<File>.from(returnedImage.map((e) => File(e.path)));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.verified_user_outlined,
                              color: Colors.blue),
                          const SizedBox(width: 8),
                          Text('Ảnh đại diện', style: defaultText14M),
                          const Spacer(),
                          const CloseButton(
                            color: Colors.black,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: Divider(
                          color: Colors.grey.shade300,
                          thickness: 1,
                        ),
                      ),
                      ...photos.asMap().entries.map(
                        (entry) {
                          int index = entry.key;
                          File photo = entry.value;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    photo,
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: GestureDetector(
                                    onTap: () {
                                      setStateDialog(() {
                                        photos.removeAt(index);
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.all(4),
                                      child: const Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      InkWell(
                        onTap: () async {
                          // Xử lý gửi yêu cầu
                          Navigator.pop(context);
                          Navigator.pop(context);
                          // //gọi api
                          mainAvatarNotifier.value = photos;
                          InfoRepo().changeAvatar(
                            photos.first,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                //success
                                'Cập nhật ảnh đại diện thành công!',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 16.w, bottom: 26.h, top: 16.h, right: 16.w),
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
                            'Xác nhận gửi yêu cầu',
                            style: defaultText14B.copyWith(color: Colors.white),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
