import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ha_duong/models/apartment_model.dart';
import 'package:ha_duong/models/info_model.dart';
import 'package:ha_duong/models/suport_model.dart';
import 'package:ha_duong/modules/bottomnavbar/support/technical_request_screen.dart';
import 'package:ha_duong/repo/home_repo.dart';
import 'package:ha_duong/repo/support_repo.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/utils/widget/pick_image.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import 'custom_widget.dart';

class CustomerInfoForm extends StatelessWidget {
  final DangKyModel dangKyModel;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController apartmentController;
  final TextEditingController noteController;
  CustomerInfoForm({
    super.key,
    required this.dangKyModel,
  })  : nameController = TextEditingController(text: dangKyModel.fullName),
        phoneController = TextEditingController(text: dangKyModel.phone),
        apartmentController =
            TextEditingController(text: dangKyModel.apartmentName),
        noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/person_icon.svg'),
                    const SizedBox(width: 8),
                    const Text(
                      'Thông tin khách hàng',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    const CloseButton(
                      color: Colors.black,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                _buildLabelledField("Họ và tên", nameController),
                SizedBox(height: 16.h),
                _buildLabelledField("Số điện thoại", phoneController,
                    keyboardType: TextInputType.phone),
                SizedBox(height: 16.h),
                _buildLabelledField("Căn hộ", apartmentController),
                SizedBox(height: 16.h),
                _buildLabelledField(
                  "Ghi chú",
                  noteController,
                  isRequied: false,
                ),
                SizedBox(height: 24.h),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // Gửi thông tin
                      HomeRepo().sendDangKy(
                          dangKyModel.id,
                          dangKyModel.apartmentId,
                          nameController.text,
                          phoneController.text,
                          noteController.text);
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text(
                            'Gửi thông tin thành công',
                            style: defaultText16B,
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(
                                  context,
                                );
                                Navigator.pop(
                                  context,
                                );
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: 303.w,
                    height: 50.h,
                    margin: EdgeInsets.only(left: 16.w, right: 16.w),
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
                      ),
                    ),
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

class ChangeChuHoInfo extends StatefulWidget {
  const ChangeChuHoInfo({super.key, required this.model});
  final ResidentModel model;
  @override
  State<ChangeChuHoInfo> createState() => _ChangeChuHoInfoState();
}

class _ChangeChuHoInfoState extends State<ChangeChuHoInfo> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cccdController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  List<File> photos = <File>[];
  @override
  void initState() {
    // TODO: implement initState
    _nameController.text = widget.model.fullName;
    _cccdController.text = widget.model.idCard;
    _phoneController.text = widget.model.phone;
    _emailController.text = widget.model.email;
    _dateController.text = widget.model.dob;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 8.w),
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95, // Gần toàn màn hình
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
          ),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20.h),
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
                          'assets/images/personal.png',
                          width: 34.w,
                          height: 34.w,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          'Thay đổi thông tin chủ hộ',
                          style: defaultText16B,
                        ),
                        const CloseButton(
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  CustomTextFormField(
                    labelText: 'Họ và tên',
                    hintText: 'Nhập họ và tên',
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập họ và tên';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    labelText: 'Số định danh',
                    hintText: 'Nhập Số định danh',
                    controller: _cccdController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập Số định danh';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Ngày sinh ',
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
                    style: defaultText14M,
                    controller: _dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      //labelText: 'Ngày sinh',
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      hintText: 'Ngày sinh',
                      hintStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (value) {
                      // _newCategory = value;
                    },
                    onTap: () => selectDate(context, _dateController),
                    validator: (value) =>
                        value!.isEmpty ? 'Vui lòng chọn ngày sinh' : null,
                  ),
                  CustomTextFormField(
                    labelText: 'Số điện thoại',
                    hintText: 'Nhập Số điện thoại',
                    controller: _phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng số điện thoại';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    labelText: 'Email',
                    hintText: 'Nhập Email',
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập email';
                      }
                      return null;
                    },
                  ),
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
                                          buildUploadOption(
                                            icon: Icons.image_outlined,
                                            text: "Tải ảnh lên",
                                            onTap: () {
                                              // Xử lý tải ảnh lên
                                              pickImageFromGallery(
                                                context,
                                                2,
                                                name: _nameController.text,
                                                cccd: _cccdController.text,
                                                date: _dateController.text,
                                                phone: _phoneController.text,
                                                email: _emailController.text,
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
                                                name: _nameController.text,
                                                cccd: _cccdController.text,
                                                date: _dateController.text,
                                                phone: _phoneController.text,
                                                email: _emailController.text,
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
                          left: 16.w, bottom: 20.h, top: 10.h, right: 16.w),
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
                  Text(
                    'Lưu ý: gửi kèm ảnh chụp hồ sơ (vd: Biên bản bàn giao nhà, CCCD ...)',
                    style: defaultText14M.copyWith(
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            ),
          ),
        ),
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

class AddMember extends StatefulWidget {
  const AddMember({
    super.key,
    required this.type,
    required this.apartmentId,
    required this.residentId,
  });
  final String apartmentId;
  final String residentId;
  final int type; // 0: Thêm thành viên, 1: Chỉnh sửa thông tin thành viên
  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cccdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  List<File> photos = <File>[];
  String? _rela;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/personal.png',
                      width: 34.w,
                      height: 34.w,
                      fit: BoxFit.fill,
                    ),
                    Text(
                      widget.type == 0
                          ? 'Thêm thành viên'
                          : 'Thay đổi thông tin',
                      style: defaultText16B,
                    ),
                    const CloseButton(
                      color: Colors.black,
                    ),
                  ],
                ),
                CustomTextFormField(
                  labelText: 'Họ và tên',
                  hintText: 'Nhập họ và tên',
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập họ và tên';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  labelText: 'Số định danh',
                  hintText: 'Nhập Số định danh',
                  controller: _cccdController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập Số điện thoại';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Ngày sinh ',
                    style:
                        defaultText14M.copyWith(color: const Color(0xff8A8A8A)),
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
                  style: defaultText14M,
                  controller: _dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    //labelText: 'Ngày sinh',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    hintText: 'Ngày sinh',
                    hintStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    // _newCategory = value;
                  },
                  onTap: () => selectDate(context, _dateController),
                  validator: (value) =>
                      value!.isEmpty ? 'Vui lòng chọn ngày sinh' : null,
                ),
                CustomTextFormField(
                  labelText: 'Số điện thoại',
                  hintText: 'Nhập Số điện thoại',
                  controller: _phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng số điện thoại';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  labelText: 'Email',
                  hintText: 'Nhập Email',
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Quan hệ với chủ hộ ',
                    style:
                        defaultText14M.copyWith(color: const Color(0xff8A8A8A)),
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
                RelationshipDropdown(
                  value: _rela,
                  onChanged: (value) {
                    setState(() {
                      _rela = value;
                    });
                    print('Giá trị key đã chọn: $_rela');
                  },
                ),
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
                                        buildUploadOption(
                                          icon: Icons.image_outlined,
                                          text: "Tải ảnh lên",
                                          onTap: () {
                                            // Xử lý tải ảnh lên
                                            pickImageFromGallery(
                                              context,
                                              widget.type,
                                              name: _nameController.text,
                                              cccd: _cccdController.text,
                                              date: _dateController.text,
                                              phone: _phoneController.text,
                                              email: _emailController.text,
                                              rela: _rela,
                                              apartmentId: widget.apartmentId,
                                              residentId: widget.residentId,
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
                                              widget.type,
                                              name: _nameController.text,
                                              cccd: _cccdController.text,
                                              date: _dateController.text,
                                              phone: _phoneController.text,
                                              email: _emailController.text,
                                              rela: _rela,
                                              apartmentId: widget.apartmentId,
                                              residentId: widget.residentId,
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
                        left: 16.w, bottom: 20.h, top: 12.w, right: 16.w),
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
                Text(
                  'Lưu ý: gửi kèm ảnh chụp hồ sơ (vd: Biên bản bàn giao nhà, CCCD ...)',
                  style: defaultText14M.copyWith(
                    color: Colors.red,
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

Widget _buildLabelledField(
  String label,
  TextEditingController controller, {
  TextInputType keyboardType = TextInputType.text,
  bool isRequied = true,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RichText(
        text: TextSpan(
          text: label,
          style: const TextStyle(
              fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500),
          children: [
            TextSpan(
              text: isRequied ? ' *' : '',
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
      const SizedBox(height: 6),
      TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: (value) {
          if (isRequied && (value == null || value.trim().isEmpty)) {
            return 'Vui lòng nhập ${label.toLowerCase()}';
          }

          return null;
        },
        maxLines: isRequied ? 1 : 4,
        decoration: InputDecoration(
          isDense: true,
          hintText: 'Nhập $label',
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    ],
  );
}

Future<void> selectDate(
    BuildContext context, TextEditingController dateController) async {
  DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime(2000),
    firstDate: DateTime(1910),
    lastDate: DateTime(2006),
  );
  if (picked != null) {
    dateController.text = picked.toString().split(" ")[0];
  }
}

void showPostDialog(
    BuildContext context, List<PostModel> posts, String apartmentId) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.symmetric(horizontal: 8.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: posts.map((post) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () async {
                        FullRequestModel model =
                            await SupportRepo().getShowRequest(
                          apartmentId,
                          post.id,
                        );
                        pushWithoutNavBar(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TechnicalRequestScreen(
                              model: model,
                              title: post.name,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 60.dm,
                            height: 60.dm,
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 15.h,
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF25AAE1),
                                  Color(0xFF004071),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.0, 1.0],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Image.network(
                              'https://bms.haduong.com.vn/images/${post.img}',
                              fit: BoxFit.fitHeight,
                              height: 20.h,
                              errorBuilder: (_, __, ___) => const Icon(
                                  Icons.broken_image,
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(post.name,
                              style: defaultText16M.copyWith(
                                  color: const Color(0xff004071))),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      );
    },
  );
}
