import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ha_duong/models/suport_model.dart';
import 'package:ha_duong/repo/support_repo.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:ha_duong/utils/widget/custom_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ha_duong/l10n/app_localizations.dart';

class TechnicalRequestScreen extends StatefulWidget {
  const TechnicalRequestScreen(
      {super.key, required this.model, required this.title});
  final FullRequestModel model;
  final String title;
  @override
  State<TechnicalRequestScreen> createState() => _TechnicalRequestScreenState();
}

class _TechnicalRequestScreenState extends State<TechnicalRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _apartmentController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  SettingSupportState? selectedStatus;

  late List<SettingSupportState> statuses;
  final ImagePicker _picker = ImagePicker();
  final List<File> _imageFiles = [];

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFiles.add(File(pickedFile.path));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize selectedStatus with the first item
    _contactController.text = widget.model.request.fullName;
    _phoneController.text = widget.model.request.phone;
    _apartmentController.text = widget.model.request.apartmentName;
    statuses = widget.model.settingSupportStates;
    if (statuses.isNotEmpty) {
      selectedStatus = statuses.first;
    } else {
      selectedStatus = null; // hoặc xử lý mặc định
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        title: Text('Yêu cầu ${widget.title}'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 16.h),
                          child: Column(
                            children: [
                              buildSection(
                                icon: 'assets/icons/tinh_trang.svg',
                                title:
                                    AppLocalizations.of(context)!.statusShort,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: AppLocalizations.of(context)!
                                                .txtTinhTrang5,
                                            style: defaultText14M.copyWith(
                                                color: const Color(0xff8A8A8A)),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: '*',
                                                style: defaultText14B.copyWith(
                                                  color:
                                                      const Color(0xffE80707),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    DropdownButtonFormField<
                                        SettingSupportState>(
                                      decoration: const InputDecoration(
                                        //labelText: AppLocalizations.of(context)!.statusShort,
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(
                                                0xff8A8A8A), // Màu viền khi focus
                                            width: 1.5,
                                          ),
                                        ),
                                      ),
                                      //value: selectedStatus,
                                      hint: Text(AppLocalizations.of(context)!
                                          .yourStatus),
                                      items: statuses
                                          .map((status) => DropdownMenuItem(
                                                value: status,
                                                child: Text(status.name),
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedStatus = value;
                                        });
                                      },
                                      validator: (value) => value == null
                                          ? AppLocalizations.of(context)!
                                              .pleaseSelectStatus
                                          : null,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              buildSection(
                                icon: 'assets/icons/info_icon.svg',
                                title:
                                    AppLocalizations.of(context)!.customerInfo,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .txtNguoiLienHe1,
                                        style: defaultText14M.copyWith(
                                            color: const Color(0xff8A8A8A)),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '*',
                                            style: defaultText14B.copyWith(
                                              color: const Color(0xffE80707),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    TextFormField(
                                      controller: _contactController,
                                      decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(
                                                0xff8A8A8A), // Màu viền khi focus
                                            width: 1.5,
                                          ),
                                        ),

                                        //labelText: AppLocalizations.of(context)!.txtNguoiLienHe2,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(
                                                0xff8A8A8A), // Màu viền khi focus
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      validator: (value) =>
                                          value == null || value.isEmpty
                                              ? AppLocalizations.of(context)!
                                                  .requiredField
                                              : null,
                                    ),
                                    SizedBox(height: 20.h),
                                    RichText(
                                      text: TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .txtSoDienThoai2,
                                        style: defaultText14M.copyWith(
                                            color: const Color(0xff8A8A8A)),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '*',
                                            style: defaultText14B.copyWith(
                                              color: const Color(0xffE80707),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    TextFormField(
                                      controller: _phoneController,
                                      decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(
                                                0xff8A8A8A), // Màu viền khi focus
                                            width: 1.5,
                                          ),
                                        ),
                                        border: OutlineInputBorder(),
                                      ),
                                      keyboardType: TextInputType.phone,
                                      validator: (value) =>
                                          value == null || value.isEmpty
                                              ? AppLocalizations.of(context)!
                                                  .requiredField
                                              : null,
                                    ),
                                    const SizedBox(height: 20),
                                    RichText(
                                      text: TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .txtCanHo1,
                                        style: defaultText14M.copyWith(
                                            color: const Color(0xff8A8A8A)),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '*',
                                            style: defaultText14B.copyWith(
                                              color: const Color(0xffE80707),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    TextFormField(
                                      controller: _apartmentController,
                                      decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(
                                                0xff8A8A8A), // Màu viền khi focus
                                            width: 1.5,
                                          ),
                                        ),
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) =>
                                          value == null || value.isEmpty
                                              ? AppLocalizations.of(context)!
                                                  .requiredField
                                              : null,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              buildSection(
                                icon: 'assets/icons/note.svg',
                                title: AppLocalizations.of(context)!.note,
                                child: TextFormField(
                                  controller: _noteController,
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(
                                            0xff8A8A8A), // Màu viền khi focus
                                        width: 1.5,
                                      ),
                                    ),
                                    hintText:
                                        AppLocalizations.of(context)!.enterNote,
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? AppLocalizations.of(context)!
                                              .requiredField
                                          : null,
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  buildUploadOption(
                                    icon: Icons.image_outlined,
                                    text: AppLocalizations.of(context)!
                                        .uploadImage,
                                    onTap: () =>
                                        _pickImage(ImageSource.gallery),
                                  ),
                                  const SizedBox(width: 56),
                                  buildUploadOption(
                                    icon: Icons.camera_alt_outlined,
                                    text:
                                        AppLocalizations.of(context)!.takePhoto,
                                    onTap: () => _pickImage(ImageSource.camera),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              if (_imageFiles.isNotEmpty)
                                SizedBox(
                                  height: 200,
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: _imageFiles.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3, // số cột
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                    ),
                                    itemBuilder: (context, index) {
                                      return Image.file(
                                        _imageFiles[index],
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Nút Gửi Yêu Cầu
                    Container(
                      width: double.infinity,
                      height: 98.h,
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                        bottom: 32.h,
                        top: 16.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, -2),
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            // Xử lý gửi yêu cầu
                            bool success = await SupportRepo().createRequest(
                              apartmentId: widget.model.request.apartmentId,
                              settingSupportId:
                                  widget.model.request.settingSupportId,
                              settingSupportStateId:
                                  selectedStatus!.id.toString(),
                              fullName: _contactController.text,
                              phone: _phoneController.text,
                              note: _noteController.text,
                              photos: _imageFiles,
                            );
                            if (success) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                      AppLocalizations.of(context)!.success),
                                  content: Text(AppLocalizations.of(context)!
                                      .requestSent),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context); // đóng dialog
                                        Navigator.pop(
                                            context); // đóng màn gửi yêu cầu
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                      AppLocalizations.of(context)!.failure),
                                  content: Text(AppLocalizations.of(context)!
                                      .sendRequestFailed),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(AppLocalizations.of(context)!
                                          .tryAgain),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xff25AAE1),
                                  Color(0xff004071),
                                ]),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child:
                                Text(AppLocalizations.of(context)!.sendRequest,
                                    style: defaultText14B.copyWith(
                                      color: Colors.white,
                                    )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSection(
      {required String icon, required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  height: 34.dg,
                  width: 34.dg,
                  padding: const EdgeInsets.all(7),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffE9EFF4),
                  ),
                  child: SvgPicture.asset(icon)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 6.h, bottom: 10.h),
            child: const Divider(),
          ),
          child,
        ],
      ),
    );
  }
}
