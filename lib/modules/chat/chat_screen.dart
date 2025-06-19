import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ha_duong/models/chat_model.dart';
import 'package:ha_duong/repo/chat_noti_repo.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:camera_camera/camera_camera.dart';
import '../../utils/constants/color.dart';
import '../../utils/constants/styles.dart';
import 'package:image_picker/image_picker.dart';

//import '../model/chat_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.avatar,
    required this.apartmentId,
    required this.chatModel,
  });

  final String avatar;
  final ChatModel chatModel;
  final String apartmentId;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  List<File> photos = <File>[];
  late ChatModel _chatModel;
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  void initState() {
    super.initState();
    _chatModel = widget.chatModel;
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
                  title: const Text('Chụp ảnh thành công'),
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

  // Tải ảnh lên từ thư viện
  Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickMultiImage();
    photos.addAll(returnedImage.map((e) => File(e.path)));
    //File(returnedImage!.path);
    if (photos.isNotEmpty) {}
    setState(() {});
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
                'Chat với ban quản lý',
                style: defaultText18B,
              ),
            ],
          ),
          toolbarHeight: 60.h,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.call),
              tooltip: 'Show Snackbar',
              onPressed: () {
                _makePhoneCall(_chatModel.hotline);
              },
            ),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              //gradient: mainGradient,
              color: Colors.white,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              color: Colors.grey.shade300,
              height: 1,
            ),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 50.h),
              child: ListView.builder(
                itemCount: _chatModel.messages.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: 50.h),
                reverse: true,
                //physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: ((_chatModel.messages[index].senderType == "1")
                          ? Alignment.topRight
                          : Alignment.topLeft),
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 300.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: (_chatModel.messages[index].senderType == "1")
                              ? const Color(0xffEFF3FF)
                              : const Color(0xffF5F5F5),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: _chatModel.messages[index].messageType == "0"
                            ? Text(
                                _chatModel.messages[index].content,
                                style: defaultText14Re.copyWith(
                                  color:
                                      (_chatModel.messages[index].senderType ==
                                              "1")
                                          ? Colors.black
                                          : Colors.black,
                                ),
                              )
                            : _buildImageContent(
                                _chatModel.messages[index].content,
                              ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 16.w, bottom: 6.h, top: 4.w),
                margin: EdgeInsets.only(bottom: 16.h),
                height: 60.h,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        openCamera();
                      },
                      child: SvgPicture.asset('assets/icons/camera_icon.svg'),
                    ),
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
                        child: photos.isEmpty
                            ? TextField(
                                controller: messageController,
                                decoration: const InputDecoration(
                                  hintText: "Nhập tin nhắn...",
                                  hintStyle: TextStyle(color: Colors.black54),
                                  border: InputBorder.none,
                                ),
                                style: defaultText14M,
                                textAlign: TextAlign.center,
                              )
                            : GridView.builder(
                                itemCount: photos.length,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                ),
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(
                                          photos[index],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              photos.removeAt(index);
                                            });
                                          },
                                          child: const Icon(Icons.cancel,
                                              color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                        onTap: () async {
                          bool isSuccess;
                          if (photos.isNotEmpty) {
                            isSuccess = await ChatRepo().sendImgMessage(
                                chatId: _chatModel.chatId, photos: photos);
                            _chatModel = await ChatRepo()
                                .getHomeChat(widget.apartmentId);
                            setState(() {});
                            photos.clear();
                          } else {
                            isSuccess = await ChatRepo().sendMessage(
                                chatId: _chatModel.chatId,
                                content: messageController.text);
                            //add to first
                            _chatModel = await ChatRepo()
                                .getHomeChat(widget.apartmentId);
                            setState(() {});

                            messageController.clear();
                          }

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: Text(isSuccess
                                    ? 'Tin nhắn đã được gửi'
                                    : 'Tin nhắn chưa được gửi'),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    isDefaultAction: true,
                                    child: Text(
                                      'OK',
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

Widget _buildImageContent(String content) {
  List<String> imageUrls = List<String>.from(json.decode(content));
  if (imageUrls.length == 1) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        imageUrls[0],
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      ),
    );
  }

  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: imageUrls.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2, // hoặc 3 tùy bố cục bạn muốn
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
    ),
    itemBuilder: (context, index) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrls[index],
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
        ),
      );
    },
  );
}
