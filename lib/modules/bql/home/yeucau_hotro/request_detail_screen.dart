import 'package:ha_duong/l10n/app_localizations.dart';
import 'dart:convert';
import 'dart:io';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/bql_model/technical_requests_model.dart';
import 'package:ha_duong/bql_repo/technical_requests_repo.dart';
import 'package:ha_duong/modules/bql/info/info_screen.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestDetailScreen extends StatefulWidget {
  const RequestDetailScreen({super.key, required this.id});
  final String id;
  @override
  State<RequestDetailScreen> createState() => _RequestDetailScreenState();
}

class _RequestDetailScreenState extends State<RequestDetailScreen> {
  bool isLoading = true;

  SettingSuppportStatus? selectedStatus;
  late DetailRequestModel detailRequestModel;
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  List<File> photos = <File>[];
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    try {
      final response =
          await TechnicalRequestsRepo().getDetailRequest(widget.id);
      setState(() {
        detailRequestModel = response;

        isLoading = false;
      });
    } catch (e) {
      debugPrint('Lỗi khi gọi API: $e');
      setState(() {
        isLoading = false;
      });
    }
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
                  title:
                      Text(AppLocalizations.of(context)!.bqlChupAnhThanhCong),
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

  String? note;

  void _openNoteDialog() {
    final controller = TextEditingController(text: note);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(AppLocalizations.of(context)!.bqlThemNote),
        content: TextField(
          controller: controller,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: "Nhập ghi chú...",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Huỷ"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                note = controller.text.trim().isEmpty
                    ? null
                    : controller.text.trim();
              });
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)!.bqlLuu),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.bqlChiTietYeuCauHoTro),
        backgroundColor: const Color(0xFF1CA0DD),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  height: 20.h,
                  width: double.infinity,
                  color: Colors.lightBlue,
                  child: Container(
                    width: double.infinity,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffFAFAFA),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        topRight: Radius.circular(24.r),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    children: [
                      _buildRequestInfoCard(),
                      _buildImageContent(context, detailRequestModel.value.img),
                      const SizedBox(height: 20),
                      const Text('Trạng thái tiến độ:',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      _buildDropdown(),
                      SizedBox(height: 8.h),
                      ...photos.asMap().entries.map((entry) {
                        int index = entry.key;
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
                                  height: 200.h,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: GestureDetector(
                                  onTap: () {
                                    photos.removeAt(index);
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            side: BorderSide(color: Colors.blue.shade100),
                          ),
                        ),
                        child:
                            Text(AppLocalizations.of(context)!.bqlThemHinhAnh),
                        onPressed: () {
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
                                                _pickImageFromGallery();
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
                                                openCamera();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ));
                        },
                      ),
                      // Nếu chưa có note thì hiển thị button
                      (note == null)
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  side: BorderSide(color: Colors.blue.shade100),
                                ),
                              ),
                              onPressed: _openNoteDialog,
                              child: Text(
                                  AppLocalizations.of(context)!.bqlThemNote),
                            )
                          :
                          // Nếu đã có note thì hiển thị note
                          GestureDetector(
                              onTap: _openNoteDialog,
                              child: Container(
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border:
                                      Border.all(color: Colors.blue.shade100),
                                ),
                                child: Text(
                                  note!,
                                  style: const TextStyle(color: Colors.black87),
                                ),
                              ),
                            ),
                      SizedBox(height: 12.h),
                      _buildTimeline(),
                      Padding(
                        padding: EdgeInsets.only(left: 12.w),
                        child: _buildStepItem(
                          RequestStatusModel(
                            name: AppLocalizations.of(context)!.bqlTaoYeuCau,
                            createAt: detailRequestModel.value.createdAt,
                            type: '0',
                          ),
                          isLast: true,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildSaveButton(),
              ],
            ),
    );
  }

  Widget _buildRequestInfoCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Căn hộ: ${detailRequestModel.value.apartmentName} \nTòa nhà: ${detailRequestModel.value.buildingName}',
          style: defaultText16B,
        ),
        SizedBox(height: 6.h),
        Text(
          'Người yêu cầu: ${detailRequestModel.value.fullName}',
          style: defaultText16B,
        ),
        SizedBox(height: 6.h),
        GestureDetector(
          onTap: () {
            _makePhoneCall(detailRequestModel.value.phone);
          },
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.phone, color: Colors.blue),
                onPressed: () {
                  _makePhoneCall(detailRequestModel.value.phone);
                },
              ),
              Text(
                detailRequestModel.value.phone,
                style: defaultText16B.copyWith(
                  color: const Color(0xff004071),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: const Color(0xff282828).withValues(alpha: 0.08))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Yêu cầu ${detailRequestModel.value.settingSupportName} (${DateFormat('dd/MM/yyyy – kk:mm').format(detailRequestModel.value.createdAt)})',
                style: defaultText16B.copyWith(
                  color: const Color(
                    0xff004071,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                detailRequestModel.value.note,
                style: defaultText14M,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade100),
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
      ),
      child: DropdownButton<SettingSuppportStatus>(
        value: selectedStatus,
        hint: Text(AppLocalizations.of(context)!.bqlNhapTinhTrangXuLy),
        isExpanded: true,
        underline: const SizedBox(),
        items: detailRequestModel.listStatus.map((status) {
          return DropdownMenuItem(
            value: status,
            child: Text(status.name),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null && value != selectedStatus) {
            showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  title: Text(
                    'Xác nhận',
                    style: defaultText16.copyWith(
                      color: const Color.fromARGB(255, 29, 29, 29),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  content: Text(
                    'Bạn có chắc muốn thay đổi?',
                    style: defaultText16.copyWith(
                      color: const Color(0xff3C3C3C),
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        AppLocalizations.of(context)!.bqlHuy,
                        style: defaultText16.copyWith(
                            color: const Color(0xff8A8A8A)),
                      ),
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
                    ),
                    TextButton(
                      child: Text(
                        'Đồng ý',
                        style: defaultText16.copyWith(
                            color: const Color(0xFF1CA0DD)),
                      ),
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        setState(() => selectedStatus = value);
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildTimeline() {
    return Container(
      padding: EdgeInsets.only(left: 12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: detailRequestModel.listLastStatus.reversed.map((status) {
          return _buildStepItem(status);
        }).toList(),
      ),
    );
  }

  // Widget _buildTimelineItem(RequestStatusModel status) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Column(
  //         children: [
  //           Icon(
  //             Icons.radio_button_checked,
  //             color: status.type == '0'
  //                 ? const Color(0xff004071)
  //                 : status.type == '1'
  //                     ? const Color(0xff129F20)
  //                     : const Color(0xffE80707),
  //             size: 18,
  //           ),
  //           Container(width: 2, height: 40, color: Colors.grey.shade300),
  //         ],
  //       ),
  //       const SizedBox(width: 12),
  //       Expanded(
  //         child: Padding(
  //           padding: const EdgeInsets.only(bottom: 12),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 status.createAt,
  //                 style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
  //               ),
  //               const SizedBox(height: 4),
  //               Text(
  //                 status.name,
  //                 style: const TextStyle(
  //                   color: Colors.blue,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
  Widget _buildStepItem(RequestStatusModel step, {bool isLast = false}) {
    return SizedBox(
      height: (step.img != null && step.img!.isNotEmpty && step.img != '[]')
          ? 160.h
          : 45.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormat(AppLocalizations.of(context)!.bqlDdmmyyyy)
                    .format(step.createAt),
                style: defaultText12.copyWith(color: const Color(0xff8A8A8A)),
              ),
              const SizedBox(height: 4),
              Text(
                DateFormat(AppLocalizations.of(context)!.bqlHhmm)
                    .format(step.createAt),
                style: defaultText12.copyWith(color: const Color(0xff8A8A8A)),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 4.h, bottom: 2.h),
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: step.type == '0'
                      ? const Color(0xff004071)
                      : step.type == '1'
                          ? const Color(0xff129F20)
                          : const Color(0xffE80707),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.done, size: 12, color: Colors.white),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1,
                    color: step.type == '0'
                        ? const Color(0xff004071)
                        : step.type == '1'
                            ? const Color(0xff129F20)
                            : const Color(0xffE80707),
                  ),
                ),
            ],
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    step.name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: step.type == '0'
                          ? const Color(0xff004071)
                          : step.type == '1'
                              ? const Color(0xff129F20)
                              : const Color(0xffE80707),
                      fontWeight:
                          step.type == '0' ? FontWeight.w500 : FontWeight.bold,
                    ),
                  ),
                  (step.img != null && step.img!.isNotEmpty && step.img != '[]')
                      ? SizedBox(
                          height: 125.h,
                          child: _buildImageContent(context, step.img!))
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () async {
            if (selectedStatus != null) {
              bool isMissingInfo = photos.isEmpty && note == null;
              String warningMsg = isMissingInfo
                  ? 'Bạn chưa thêm hình ảnh và note.\nBạn có chắc chắn muốn thay đổi?'
                  : 'Bạn có chắc chắn muốn thay đổi?';

              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return AlertDialog(
                    title: Text(
                      'Xác nhận',
                      style: defaultText16.copyWith(
                        color: const Color.fromARGB(255, 29, 29, 29),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    content: Text(
                      warningMsg,
                      style: defaultText16.copyWith(
                        color: const Color(0xff3C3C3C),
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text(
                          AppLocalizations.of(context)!.bqlHuy,
                          style: defaultText16.copyWith(
                              color: const Color(0xff8A8A8A)),
                        ),
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                      ),
                      TextButton(
                        child: Text(
                          'Đồng ý',
                          style: defaultText16.copyWith(
                              color: const Color(0xFF1CA0DD)),
                        ),
                        onPressed: () async {
                          Navigator.of(dialogContext).pop();

                          await TechnicalRequestsRepo().changeStatus(
                            id: widget.id,
                            statusId: selectedStatus?.id ?? '',
                            photos: photos,
                            noteText: note,
                          );
                          final response = await TechnicalRequestsRepo()
                              .getDetailRequest(widget.id);
                          setState(() {
                            detailRequestModel = response;
                            selectedStatus = response.listStatus.firstWhere(
                              (status) => status.id == selectedStatus?.id,
                            );
                            isLoading = false;
                          });

                          if (!mounted) return;

                          showDialog(
                            context: context,
                            builder: (BuildContext successContext) {
                              return AlertDialog(
                                title: Text(
                                  AppLocalizations.of(context)!
                                      .bqlCapNhatThanhCong,
                                  style: defaultText16.copyWith(
                                    color:
                                        const Color.fromARGB(255, 29, 29, 29),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                actionsPadding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(
                                      'ok',
                                      style: defaultText16.copyWith(
                                          color: const Color(0xff3C3C3C)),
                                    ),
                                    onPressed: () {
                                      Navigator.of(successContext).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      AppLocalizations.of(context)!.bqlVuiLongChonTrangThaiXuLy,
                      style: defaultText16.copyWith(
                        color: const Color.fromARGB(255, 29, 29, 29),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    actionsPadding:
                        const EdgeInsets.symmetric(horizontal: 10.0),
                    actions: <Widget>[
                      TextButton(
                        child: Text(
                          'ok',
                          style: defaultText16.copyWith(
                              color: const Color(0xff3C3C3C)),
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
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: const Color(0xFF1CA0DD),
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Center(child: Text('Lưu thay đổi')),
        ),
      ),
    );
  }
}

Widget _buildImageContent(BuildContext context, String content) {
  List<String> imageUrls = List<String>.from(json.decode(content));
  if (imageUrls.isEmpty) {
    return const SizedBox();
  } else if (imageUrls.length == 1) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(10),
            child: InteractiveViewer(
              panEnabled: true,
              minScale: 0.5,
              maxScale: 4.0,
              child: Image.network(imageUrls[0], fit: BoxFit.contain),
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          imageUrls[0],
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
        ),
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
      return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(10),
              child: InteractiveViewer(
                panEnabled: true,
                minScale: 0.5,
                maxScale: 4.0,
                child: Image.network(imageUrls[index], fit: BoxFit.contain),
              ),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imageUrls[index],
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error),
          ),
        ),
      );
    },
  );
}
