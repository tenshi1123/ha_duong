import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../router/app_pages.dart';
import '../../router/app_router.dart';
import '../../utils/constants/color.dart';
import '../../utils/constants/styles.dart';

class ForgotPass2 extends StatefulWidget {
  const ForgotPass2({super.key, required this.contact});
  final String contact;
  @override
  State<ForgotPass2> createState() => _ForgotPass2State();
}

class _ForgotPass2State extends State<ForgotPass2> {
  bool _isObscure2 = true;
  bool _isObscure3 = true;

  TextEditingController? passController2 = TextEditingController();
  TextEditingController? passController3 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          //bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40.h),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Thay đổi mật khẩu',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: keyBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: 350.w,
                height: 58.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  color: const Color(0xffF4F1F3),
                ),
                child: TextField(
                  //keyboardType: const TextInputType.numberWithOptions(),
                  controller: passController2,
                  obscureText: _isObscure2,
                  obscuringCharacter: "*",
                  style: defaultText16M,
                  scrollPadding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).viewInsets.bottom),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outlined,
                      color: subBlack,
                    ),
                    suffix: IconButton(
                      padding: const EdgeInsets.all(0),
                      iconSize: 20.0,
                      icon: _isObscure2
                          ? const Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                            )
                          : const Icon(
                              Icons.visibility,
                              color: Colors.black,
                            ),
                      onPressed: () {
                        setState(() {
                          _isObscure2 = !_isObscure2;
                        });
                      },
                    ),
                    hintText: 'Nhập mật khẩu mới',
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    hintStyle: TextStyle(
                      fontSize: 16.sp,
                      color: subBlack,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: 350.w,
                height: 58.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  color: const Color(0xffF4F1F3),
                ),
                child: TextField(
                  obscureText: _isObscure3,
                  obscuringCharacter: "*",
                  style: defaultText16M,
                  controller: passController3,
                  scrollPadding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).viewInsets.bottom),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: subBlack,
                    ),
                    hintText: 'Nhập lại mật khẩu',
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    hintStyle: TextStyle(
                      fontSize: 16.sp,
                      color: subBlack,
                    ),
                    suffix: IconButton(
                      padding: const EdgeInsets.all(0),
                      iconSize: 20.0,
                      icon: _isObscure3
                          ? const Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                            )
                          : const Icon(
                              Icons.visibility,
                              color: Colors.black,
                            ),
                      onPressed: () {
                        setState(() {
                          _isObscure3 = !_isObscure3;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              SizedBox(
                height: 140.h,
              ),
              GestureDetector(
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'Đổi mật khẩu thành công',
                          style: defaultText16M.copyWith(
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
                              style: defaultText16M.copyWith(
                                  color: const Color(0xff3C3C3C)),
                            ),
                            onPressed: () {
                              AppRouter.toPage(
                                context,
                                AppPages.LoginPage,
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  height: 48.h,
                  width: 340.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9.r),
                    color: key1Color,
                  ),
                  child: Center(
                    child: Text(
                      'Đổi mật khẩu',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
