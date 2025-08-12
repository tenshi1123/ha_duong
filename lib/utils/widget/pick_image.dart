import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/main.dart';
import 'package:ha_duong/repo/personal_repo.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:image_picker/image_picker.dart';

Future<void> pickImageFromCamera(
  BuildContext context,
  final int type, {
  required String name,
  required String cccd,
  required String date,
  required String phone,
  required String email,
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
                            'Ảnh xác minh thông tin',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ...photos.asMap().entries.map((entry) {
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
                      }),
                      OutlinedButton.icon(
                        onPressed: () async {
                          final newImage = await picker.pickImage(
                              source: ImageSource.camera);
                          if (newImage != null) {
                            setStateDialog(() {
                              photos.add(File(newImage.path));
                            });
                          }
                        },
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('Chụp thêm ảnh'),
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () async {
                          // Xử lý gửi yêu cầu
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          //gọi api
                          bool success = await PersonalRepo().editChuHo(
                            fullName: name,
                            cccdCmt: cccd,
                            phone: phone,
                            email: email,
                            dob: date,
                            photos: photos,
                            type: type,
                            relationshipType: rela,
                            apartmentId: apartmentId,
                            residentId: residentId,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                success
                                    ? 'Yêu cầu đã được gửi thành công!'
                                    : 'Gửi yêu cầu thất bại, vui lòng thử lại sau',
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

Future pickImageFromGallery(
  BuildContext context,
  final int type, {
  required String name,
  required String cccd,
  required String date,
  required String phone,
  required String email,
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
                          Text('Ảnh xác minh thông tin', style: defaultText14M),
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
                      OutlinedButton.icon(
                        onPressed: () async {
                          final moreImages =
                              await ImagePicker().pickMultiImage();
                          setStateDialog(() {
                            photos.addAll(moreImages.map((e) => File(e.path)));
                          });
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Tải thêm ảnh lên'),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.blue),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          // Xử lý gửi yêu cầu
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          //gọi api
                          bool success = await PersonalRepo().editChuHo(
                            fullName: name,
                            cccdCmt: cccd,
                            phone: phone,
                            email: email,
                            dob: date,
                            photos: photos,
                            type: type,
                            relationshipType: rela,
                            apartmentId: apartmentId,
                            residentId: residentId,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                success
                                    ? 'Yêu cầu đã được gửi thành công!'
                                    : 'Gửi yêu cầu thất bại, vui lòng thử lại sau',
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

Future<void> pickImageFromCamera1(
  BuildContext context,
) async {
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
                      const SizedBox(height: 16),
                      ...photos.asMap().entries.map((entry) {
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
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () async {
                          // Xử lý gửi yêu cầu
                          Navigator.pop(context);
                          Navigator.pop(context);
                          //gọi api
                          mainAvatarNotifier.value = photos;
                          PersonalRepo().changeAvatar(
                            photos.first,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Đổi ảnh đại diện thành công!',
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

Future pickImageFromGallery1(
  BuildContext context,
) async {
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
                        },
                      ),
                      InkWell(
                        onTap: () async {
                          // Xử lý gửi yêu cầu
                          Navigator.pop(context);
                          Navigator.pop(context);
                          mainAvatarNotifier.value = photos;
                          PersonalRepo().changeAvatar(
                            photos.first,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Đổi ảnh đại diện thành công!',
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
