import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ha_duong/bql_repo/info_repo_bql.dart';
import 'package:ha_duong/utils/constants/color.dart';
import 'package:ha_duong/utils/constants/styles.dart';

class ChangePass2Screen extends StatefulWidget {
  const ChangePass2Screen({super.key, required this.oldPass});
  final String oldPass;
  @override
  State<ChangePass2Screen> createState() => _ChangePass2ScreenState();
}

class _ChangePass2ScreenState extends State<ChangePass2Screen> {
  bool _isObscure = true;
  bool _isObscure2 = true;
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();
  bool _submit1 = false;
  bool _submit2 = false;
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController reNewPassController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newPassController.addListener(() {
      setState(() {
        _submit1 = newPassController.text.isNotEmpty;
      });
    });
    reNewPassController.addListener(() {
      setState(() {
        _submit2 = reNewPassController.text.isNotEmpty;
      });
    });
  }

//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thay đổi mật khẩu',
              style: defaultText20B.copyWith(fontSize: 24.sp),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              'Hay chọn một mật khẩu an toàn chỉ mình bạn biết',
              style: defaultText16M.copyWith(
                color: const Color(0xff292929).withValues(alpha: 0.4),
              ),
            ),
            SizedBox(
              height: 28.h,
            ),
            Container(
              width: 350.w,
              height: 48.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40.r)),
                border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
                color: const Color(0xfff0f0f0),
              ),
              child: Center(
                child: TextField(
                  obscureText: _isObscure,
                  obscuringCharacter: "*",
                  controller: newPassController,
                  focusNode: _focusNode1,
                  textAlignVertical: TextAlignVertical.center,
                  style: defaultText14M,
                  // scrollPadding: EdgeInsets.symmetric(
                  //     vertical: MediaQuery.of(context).viewInsets.top),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 0),
                    prefixIcon: SvgPicture.asset(
                      'assets/icons/lock1.svg',
                      height: 17.h,
                      width: 14.w,
                      fit: BoxFit.scaleDown,
                      color: const Color(0xff292929).withValues(alpha: 0.4),
                    ),
                    labelStyle: defaultText14M,
                    hintText: 'Nhập mật khẩu mới',
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff292929).withValues(alpha: 0.4),
                    ),
                    suffixIcon: IconButton(
                      padding: const EdgeInsets.only(top: 0),
                      icon: _isObscure
                          ? SvgPicture.asset(
                              'assets/icons/eye_close.svg',
                              height: 17.h,
                              width: 14.w,
                              color: const Color(0xff292929)
                                  .withValues(alpha: 0.8),
                              fit: BoxFit.scaleDown,
                            )
                          : SvgPicture.asset(
                              'assets/icons/eye_open.svg',
                              height: 17.h,
                              width: 14.w,
                              color: const Color(0xff292929)
                                  .withValues(alpha: 0.8),
                              fit: BoxFit.scaleDown,
                            ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Container(
              width: 350.w,
              height: 48.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40.r)),
                border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
                color: const Color(0xfff0f0f0),
              ),
              child: Center(
                child: TextField(
                  obscureText: _isObscure2,
                  obscuringCharacter: "*",
                  controller: reNewPassController,
                  focusNode: _focusNode2,
                  textAlignVertical: TextAlignVertical.center,
                  style: defaultText14M,
                  // scrollPadding: EdgeInsets.symmetric(
                  //     vertical: MediaQuery.of(context).viewInsets.top),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 0),
                    prefixIcon: SvgPicture.asset(
                      'assets/icons/lock1.svg',
                      height: 17.h,
                      width: 14.w,
                      fit: BoxFit.scaleDown,
                      color: const Color(0xff292929).withValues(alpha: 0.4),
                    ),
                    labelStyle: defaultText14M,
                    hintText: 'Nhập lại mật khẩu',
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff292929).withValues(alpha: 0.4),
                    ),
                    suffixIcon: IconButton(
                      padding: const EdgeInsets.only(top: 0),
                      icon: _isObscure2
                          ? SvgPicture.asset(
                              'assets/icons/eye_close.svg',
                              height: 17.h,
                              width: 14.w,
                              color: const Color(0xff292929)
                                  .withValues(alpha: 0.8),
                              fit: BoxFit.scaleDown,
                            )
                          : SvgPicture.asset(
                              'assets/icons/eye_open.svg',
                              height: 17.h,
                              width: 14.w,
                              color: const Color(0xff292929)
                                  .withValues(alpha: 0.8),
                              fit: BoxFit.scaleDown,
                            ),
                      onPressed: () {
                        setState(() {
                          _isObscure2 = !_isObscure2;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    backgroundColor: pri500,
                    minimumSize: Size(343.w, 52.w)),
                onPressed: (_submit1 && _submit2)
                    ? () async {
                        // Xử lý đổi mật khẩu ở đây
                        // Ví dụ: Gọi API để đổi mật khẩu
                        // Sau khi đổi mật khẩu thành công, hiển thị thông báo
                        String message = await InfoRepo().changePassword(
                            widget.oldPass,
                            newPassController.text,
                            reNewPassController.text);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12.r), // bo góc
                                side: BorderSide(
                                  color: Colors.grey.shade300, // ✅ viền mỏng
                                  width: 1,
                                ),
                              ),
                              title: Text(
                                message,
                                style: defaultText14M,
                              ),
                              content: Image.asset(
                                'assets/images/tick.png',
                                height: 53.h,
                                width: 53.w,
                              ),
                              actionsPadding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'OK',
                                    style: defaultText16B,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    : null,
                child: Text(
                  'Đổi mật khẩu',
                  style: defaultText14B.copyWith(
                    color: (_submit1 && _submit2)
                        ? Colors.white
                        : const Color(0xff292929).withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            )
          ],
        ),
      ),
    );
  }
}
