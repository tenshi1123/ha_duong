import 'dart:developer';

import 'package:ha_duong/utils/constants/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'otp_screen copy.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});
  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final _focusNode = FocusNode();

  TextEditingController phoneController = TextEditingController();

  bool isPhoneNoValid(String? phoneNo) {
    if (phoneNo == null) return false;
    final regExp = RegExp(r'(^(?:[+0]9)?[0-9]{8,12}$)');
    return regExp.hasMatch(phoneNo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
      body: GestureDetector(
        onTap: () {
          _focusNode.unfocus();
        },
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,

            //bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('Quên mật khẩu', style: defaultText20B),
                Image(
                  image: const AssetImage('assets/images/forgot_pass2.png'),
                  height: 343.h,
                  width: 343.w,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    'Hãy nhập SĐT đã đăng ký để đặt lại mật khẩu.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xff8A8A8A),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  width: 350.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40.r)),
                    border: Border.all(color: const Color(0xff8A8A8A)),
                    color: const Color(0xffF2F2F2),
                  ),
                  child: Center(
                    child: TextField(
                      keyboardType: const TextInputType.numberWithOptions(),
                      controller: phoneController,
                      focusNode: _focusNode,
                      scrollPadding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).viewInsets.bottom),
                      decoration: InputDecoration(
                        prefixIcon: SvgPicture.asset(
                          'assets/icons/user1.svg',
                          height: 17.h,
                          width: 14.w,
                          fit: BoxFit.scaleDown,
                          color: const Color(0xff8A8A8A),
                        ),
                        hintText: 'Số điện thoại',
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          color: const Color(0xffBDBDBD),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60.h,
                ),
                GestureDetector(
                  onTap: () async {
                    if (isPhoneNoValid(phoneController.text) == false) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Số điện thoại không đúng định dạng',
                              style: defaultText14M,
                            ),
                            content: Text(
                              'Vui lòng kiểm tra lại số điện thoại đã nhập',
                              style: defaultText14M,
                            ),
                            actionsPadding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            actions: <Widget>[
                              TextButton(
                                child: const Text(
                                  'ok',
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      //Lưu ý nhớ copy verificationId
                      FirebaseAuth.instance.verifyPhoneNumber(
                          // phoneNumber: '+84974225054',
                          phoneNumber:
                              '+84${phoneController.text.replaceFirst(RegExp(r'0'), '')}',
                          verificationCompleted: (PhoneAuthCredential) {},
                          verificationFailed: (error) {
                            log(error.toString());
                          },
                          codeSent: (verificationId, forceResendingToken) {
                            //Lưu ý nhớ copy verificationId
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => OtpScreen(
                                      contact: phoneController.text,
                                      verificationId: verificationId,
                                    )),
                              ),
                            );
                          },
                          codeAutoRetrievalTimeout: (verificationId) {
                            log("Auto Retiveral timeout");
                          });
                    }
                  },
                  child: Container(
                    height: 48.h,
                    width: 340.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(77.r),
                      color: const Color(0xff28B4E9),
                    ),
                    child: Center(
                      child: Text(
                        'Xác minh OTP',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
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
}
