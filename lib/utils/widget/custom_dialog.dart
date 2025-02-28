import 'package:ha_duong/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaveAbsencePopUp extends StatefulWidget {
  const LeaveAbsencePopUp({super.key});

  @override
  _LeaveAbsencePopUpState createState() => _LeaveAbsencePopUpState();
}

class _LeaveAbsencePopUpState extends State<LeaveAbsencePopUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
            // boxShadow: const [
            //   BoxShadow(
            //     color: Colors.black,
            //     offset: Offset(6, 6),
            //     spreadRadius: 2,
            //     blurStyle: BlurStyle.solid,
            //   ),
            // ],
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
                        'assets/images/personal.png',
                        width: 34.w,
                        height: 34.w,
                        fit: BoxFit.fill,
                      ),
                      Text(
                        'Thông tin khách hàng',
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
                    labelText: 'Họ và tên',
                    hintText: 'Nhập họ và tên',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập họ và tên';
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
                    labelText: 'Số điện thoại',
                    hintText: 'Nhập Số điện thoại',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập Số điện thoại';
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
                    labelText: 'Căn hộ',
                    hintText: 'Nhập Căn hộ',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập Căn hộ';
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

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      _dateController.text = picked.toString().split(" ")[0];
    }
  }
}

class FeedbackPopUp extends StatefulWidget {
  const FeedbackPopUp({super.key});

  @override
  _FeedbackPopUpState createState() => _FeedbackPopUpState();
}

class _FeedbackPopUpState extends State<FeedbackPopUp> {
  final _formKey = GlobalKey<FormState>();
  String? _category;
  String? _newCategory;
  final List<String> _categories = ['Personal', 'Work', 'Other'];
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: Container(
        width: 343.w,
        //height: 342.h,
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
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xff273D8C),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Phản hồi của bạn về ha_duong',
                        style: defaultText16B.copyWith(color: Colors.white),
                      ),
                      const CloseButton(
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 20.h,
                  right: 16.w,
                ),
                child: ValueListenableBuilder<int>(
                  valueListenable: _counter,
                  builder: (BuildContext context, int value, Widget? child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _counter.value = 0;
                          },
                          child: feedbackItem(value == 0, 'Giáo viên'),
                        ),
                        GestureDetector(
                          onTap: () {
                            _counter.value = 1;
                          },
                          child: feedbackItem(value == 1, 'Trung tâm'),
                        ),
                        GestureDetector(
                          onTap: () {
                            _counter.value = 2;
                          },
                          child: feedbackItem(value == 2, 'Bài giảng'),
                        )
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 12.w,
                  top: 12.h,
                  right: 12.w,
                ),
                child: SizedBox(
                  width: 319.w,
                  height: 148.h, //
                  child: TextFormField(
                    maxLines: null,
                    expands: true,
                    style: defaultText14M,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Phản hồi của bạn',
                      hintStyle: defaultText14M.copyWith(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    onChanged: (value) {},
                    validator: (value) =>
                        value!.isEmpty ? 'Vui lòng nhập feedback' : null,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.all(16.w),
                child: SizedBox(
                  width: 319.w,
                  height: 40.h,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_category == 'Other' &&
                            _newCategory != null &&
                            _newCategory!.isNotEmpty) {
                          _categories.add(_newCategory!);
                          _category = _newCategory;
                        }
                        Navigator.of(context).pop();
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          const WidgetStatePropertyAll(Color(0xff273D8C)),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Gửi',
                        style: defaultText16B.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget feedbackItem(bool value, String title) {
  return Container(
    height: 34.h,
    width: 98.w,
    decoration: BoxDecoration(
      border: Border.all(
        color: value ? Colors.white : const Color(0xffF2F2F2),
        width: value ? 2.w : 1.w,
      ),
      boxShadow: [
        BoxShadow(
          color: const Color(0xff000000).withAlpha(20),
          blurRadius: 4,
          offset: const Offset(0, 4), // Shadow position
        ),
      ],
      borderRadius: BorderRadius.all(
        Radius.circular(12.r),
      ),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: value
            ? [
                const Color(0xff2F72FB),
                const Color(0xff273D8C),
              ]
            : [
                Colors.white,
                Colors.white,
              ],
      ),
    ),
    child: Center(
        child: Text(
      title,
      style: defaultText14B.copyWith(
          color: value ? Colors.white : const Color(0xff273D8C),
          fontWeight: FontWeight.w600),
    )),
  );
}

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String? initialValue;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.initialValue,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      validator: validator,
      style: defaultText14M,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
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
    );
  }
}

class ChangeHouseholdInfoForm extends StatefulWidget {
  const ChangeHouseholdInfoForm({super.key});

  @override
  _ChangeHouseholdInfoFormState createState() =>
      _ChangeHouseholdInfoFormState();
}

class _ChangeHouseholdInfoFormState extends State<ChangeHouseholdInfoForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
            // boxShadow: const [
            //   BoxShadow(
            //     color: Colors.black,
            //     offset: Offset(6, 6),
            //     spreadRadius: 2,
            //     blurStyle: BlurStyle.solid,
            //   ),
            // ],
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
                        'assets/images/personal.png',
                        width: 34.w,
                        height: 34.w,
                        fit: BoxFit.fill,
                      ),
                      Text(
                        'Thông tin khách hàng',
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
                    labelText: 'Họ và tên',
                    hintText: 'Nhập họ và tên',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập họ và tên';
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
                    labelText: 'Số điện thoại',
                    hintText: 'Nhập Số điện thoại',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập Số điện thoại';
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
                    labelText: 'Căn hộ',
                    hintText: 'Nhập Căn hộ',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập Căn hộ';
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

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      _dateController.text = picked.toString().split(" ")[0];
    }
  }
}
// class ChangeHouseholdInfoForm extends StatelessWidget {
//   final _formKey = GlobalKey<FormState>();

//   ChangeHouseholdInfoForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 343.w,
//       height: 635.h,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: const [
//               BoxShadow(
//                   color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildHeader(),
//               const SizedBox(height: 12),
//               _buildInputField("Họ và tên", "Nhập họ và tên"),
//               _buildInputField("Số định danh", "Nhập số định danh"),
//               _buildInputField("Ngày sinh", "DD/MM/YYYY"),
//               _buildInputField("Số điện thoại", "Nhập số điện thoại"),
//               _buildInputField("Email", "Nhập email"),
//               const SizedBox(height: 16),
//               _buildSubmitButton(),
//               const SizedBox(height: 8),
//               _buildNote(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return const Row(
//       children: [
//         Icon(Icons.account_circle, color: Colors.blue),
//         SizedBox(width: 8),
//         Text(
//           "Thay đổi thông tin chủ hộ",
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//       ],
//     );
//   }

//   Widget _buildInputField(String label, String hintText) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           RichText(
//             text: TextSpan(
//               text: "$label ",
//               style: const TextStyle(fontSize: 14, color: Colors.black),
//               children: const [
//                 TextSpan(
//                   text: "*",
//                   style: TextStyle(color: Colors.red),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 4),
//           TextFormField(
//             decoration: InputDecoration(
//               hintText: hintText,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               contentPadding:
//                   const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSubmitButton() {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: () {
//           // Xử lý khi nhấn nút
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.blue,
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//         child: const Text(
//           "Gửi ảnh xác nhận thông tin",
//           style: TextStyle(fontSize: 16, color: Colors.white),
//         ),
//       ),
//     );
//   }

//   Widget _buildNote() {
//     return const Text(
//       "Lưu ý*: gửi kèm ảnh chụp hồ sơ (vd: Biên bản bàn giao nhà, CCCD ...)",
//       style: TextStyle(fontSize: 14, color: Colors.red),
//     );
//   }
// }
