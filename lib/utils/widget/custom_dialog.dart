import 'package:ha_duong/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeaveAbsencePopUp extends StatefulWidget {
  const LeaveAbsencePopUp({super.key, required this.type});
  final String type;

  @override
  _LeaveAbsencePopUpState createState() => _LeaveAbsencePopUpState();
}

class _LeaveAbsencePopUpState extends State<LeaveAbsencePopUp> {
  final _formKey = GlobalKey<FormState>();
  String? _category;
  String? _newCategory;
  final List<String> _categories = ['Personal', 'Work', 'Other'];
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
                Container(
                  decoration: BoxDecoration(
                    color: widget.type == '1'
                        ? const Color(0xffED1C24)
                        : const Color(0xff28B4E9),
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
                          widget.type == '1'
                              ? 'Nhập lý do xin nghỉ'
                              : 'Nhập lý do xin đi muộn',
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
                    left: 12.w,
                    top: 20.h,
                    right: 12.w,
                  ),
                  child: TextFormField(
                    style: defaultText14M,
                    controller: _dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      // enabledBorder:
                      //     const OutlineInputBorder(borderSide: BorderSide.none,),
                      // focusedBorder: const OutlineInputBorder(
                      //     borderSide: BorderSide(color: Colors.grey)),
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: widget.type == '1'
                          ? 'Nhập ngày bạn muốn xin nghỉ'
                          : 'Nhập ngày bạn muốn xin đi muộn',
                      hintStyle: defaultText14M.copyWith(color: Colors.grey),
                      suffixIcon: SvgPicture.asset(
                        'assets/icons/calendar.svg',
                        height: 20.h,
                        width: 20.w,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    onChanged: (value) {
                      _newCategory = value;
                    },
                    onTap: () {
                      _selectDate();
                    },
                    validator: (value) => value!.isEmpty
                        ? 'Vui lòng nhập ngày bạn muốn xin đi muộn'
                        : null,
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
                        hintText: 'Lý do của bạn',
                        hintStyle: defaultText14M.copyWith(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      onChanged: (value) {},
                      validator: (value) => value!.isEmpty
                          ? 'Vui lòng nhập lý do xin đi muộn'
                          : null,
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
                        backgroundColor: WidgetStatePropertyAll(
                          widget.type == '1'
                              ? const Color(0xffED1C24)
                              : const Color(0xff28B4E9),
                        ),
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
