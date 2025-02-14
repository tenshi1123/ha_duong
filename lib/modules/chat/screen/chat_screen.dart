import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:camera_camera/camera_camera.dart';
import '../../../utils/constants/color.dart';
import '../../../utils/constants/styles.dart';
import 'package:image_picker/image_picker.dart';

import '../model/chat_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.title, required this.avatar});
  final String title;
  final String avatar;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  List<File> photos = <File>[];
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  void openCamera() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CameraCamera(
          onFile: (file) {
            photos.add(file);

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: const Text('Tin nhắn đã được gửi'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      child: Text(
                        'ok',
                        style: defaultText20B,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              },
            );
            setState(() {});
          },
        ),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickMultiImage();
    photos = List<File>.from(
      (returnedImage).map(
        (e) => File(e.path),
      ),
    );
    //File(returnedImage!.path);
    if (photos.isNotEmpty) {}
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Row(
            children: [
              Image(
                image: AssetImage(widget.avatar),
                height: 40.h,
                width: 40.w,
                fit: BoxFit.fill,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                widget.title,
                style: defaultText18B,
              ),
            ],
          ),
          toolbarHeight: 60.h,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              //gradient: mainGradient,
              color: Colors.white,
            ),
          ),
        ),
        body: Stack(
          children: [
            ListView.builder(
              itemCount: listMessages.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 50.h),
              reverse: true,
              //physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(
                      left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment: ((listMessages[index].senderType == "1")
                        ? Alignment.topRight
                        : Alignment.topLeft),
                    child: Container(
                        constraints: BoxConstraints(maxWidth: 300.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (listMessages[index].senderType == "1")
                              ? pri500
                              : const Color(0xffF5F5F5),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          listMessages[index].content,
                          style: defaultText14Re.copyWith(
                            color: (listMessages[index].senderType == "1")
                                ? Colors.white
                                : Colors.black,
                          ),
                        )),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 16.w, bottom: 16.h, top: 16.w),
                margin: EdgeInsets.only(bottom: 16.h),
                height: 80.h,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          openCamera();
                        },
                        child:
                            SvgPicture.asset('assets/icons/camera_icon.svg')),
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        _pickImageFromGallery();
                      },
                      child: SvgPicture.asset('assets/icons/picture_icon.svg'),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints(maxHeight: 120.h),
                        decoration: BoxDecoration(
                          color: state2,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: TextField(
                          controller: messageController,
                          decoration: const InputDecoration(
                              hintText: "Nhập tin nhắn...",
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none),
                          style: defaultText14M,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                        onTap: () async {
                          messageController.clear();

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: const Text('Tin nhắn đã được gửi'),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    isDefaultAction: true,
                                    child: Text(
                                      'ok',
                                      style: TextStyle(
                                          fontSize: 20, color: key1Color),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop(
                                        (_) => false,
                                      );
                                    },
                                  )
                                ],
                              );
                            },
                          );
                        },
                        child:
                            SvgPicture.asset('assets/icons/plane_outline.svg')),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

List<MessageModel> listMessages = [
  MessageModel(
    content:
        'Đã đi qua giới hạn duyên trời tự vỡ nát Nếu như ngay ban đầu đã không trân trọng nhau',
    senderType: '0',
    createdAt: DateFormat("yyyy-MM-dd HH:mm:ss").parse("2025-01-09 13:40:23"),
  ),
  MessageModel(
    content:
        'Hạnh phúc cớ sao càng giữ càng mong manh Có những nỗi đau ùa đến chẳng thể lành',
    senderType: '1',
    createdAt: DateFormat("yyyy-MM-dd HH:mm:ss").parse("2025-01-09 12:40:23"),
  ),
  MessageModel(
    content:
        'Tình đẹp như phép màu ta gặp nhau Ngập trong bao đắm say mà không biết kết thúc này Một ngày em đổi thay quên hết mối tình đã từng vô giá Chỉ có anh là người được biết sau cùng',
    senderType: '0',
    createdAt: DateFormat("yyyy-MM-dd HH:mm:ss").parse("2025-01-09 9:40:23"),
  ),
  MessageModel(
    content: 'Nếu em giữ anh lại câu chuyện cũng thế thôi',
    senderType: '1',
    createdAt: DateFormat("yyyy-MM-dd HH:mm:ss").parse("2025-01-09 8:45:23"),
  ),
];
