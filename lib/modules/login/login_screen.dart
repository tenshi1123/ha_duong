import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/modules/login/otp_screen.dart';
import 'package:ha_duong/repo/login_repo.dart';
import 'package:ha_duong/utils/constants/color.dart';
import '../../utils/constants/styles.dart';
import 'take_info_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _focusNode1 = FocusNode();
  bool isPhoneNoValid(String? phoneNo) {
    if (phoneNo == null) return false;
    final regExp = RegExp(r'(^(?:[+0]9)?[0-9]{8,12}$)');
    return regExp.hasMatch(phoneNo);
  }

  bool _isLoading = false;
  TextEditingController? passController = TextEditingController();
  TextEditingController? phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 60.h),
                Row(
                  children: [
                    Text(
                      'Xin chào!',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: const Color(0xff004071),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Chào mừng đã trở lại, hãy đăng nhập',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: subBlack,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  children: [
                    Text(
                      'Tài khoản',
                      style: TextStyle(
                        color: key1Color,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer()
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  width: 350.w,
                  height: 58.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.r)),
                    //color: const Color(0xffF4F1F3),
                  ),
                  child: Center(
                    child: TextField(
                      keyboardType: const TextInputType.numberWithOptions(),
                      controller: phoneController,
                      focusNode: _focusNode1,
                      style: defaultText16,
                      scrollPadding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).viewInsets.bottom),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person_2_outlined,
                          color: subBlack,
                        ),
                        filled: true, // Bật nền
                        fillColor: Color(0xffF2F2F2),
                        hintText: 'Số điện thoại',
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Color(0xff004071),
                              width: 2), // viền xanh khi bấm
                        ),
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          color: subBlack,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                //mật khẩu, và quên mật khẩu
                // Row(
                //   children: [
                //     Text(
                //       'Mật khẩu',
                //       style: TextStyle(
                //         color: key1Color,
                //         fontSize: 14.sp,
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //     const Spacer()
                //   ],
                // ),
                // SizedBox(
                //   height: 5.h,
                // ),
                // Container(
                //   width: 350.w,
                //   height: 58.h,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(8.r)),
                //     color: const Color(0xffF4F1F3),
                //   ),
                //   child: Center(
                //     child: TextField(
                //       obscureText: _isObscure,
                //       obscuringCharacter: "*",
                //       style: defaultText16,
                //       controller: passController,
                //       focusNode: _focusNode,
                //       scrollPadding: EdgeInsets.symmetric(
                //           vertical: MediaQuery.of(context).viewInsets.bottom),
                //       decoration: InputDecoration(
                //         prefixIcon: Icon(
                //           Icons.lock_outline,
                //           color: subBlack,
                //         ),
                //         hintText: 'Mật khẩu',
                //         border: const OutlineInputBorder(
                //             borderSide: BorderSide.none),
                //         hintStyle: TextStyle(
                //           fontSize: 16.sp,
                //           color: subBlack,
                //         ),
                //         suffixIcon: IconButton(
                //           padding: const EdgeInsets.all(0),
                //           iconSize: 20.0,
                //           icon: _isObscure
                //               ? const Icon(
                //                   Icons.visibility_off,
                //                   color: Colors.grey,
                //                 )
                //               : const Icon(
                //                   Icons.visibility,
                //                   color: Colors.black,
                //                 ),
                //           onPressed: () {
                //             setState(() {
                //               _isObscure = !_isObscure;
                //             });
                //           },
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 25.h,
                // ),
                // Row(
                //   children: [
                //     const Spacer(),
                //     GestureDetector(
                //       onTap: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: ((context) => const ForgotPassScreen()),
                //           ),
                //         );
                //       },
                //       child: Text(
                //         'Quên mật khẩu?',
                //         style: TextStyle(
                //           color: const Color(0xff004071),
                //           fontSize: 16.sp,
                //           //decoration: TextDecoration.underline,
                //           fontWeight: FontWeight.w500,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: 140.h,
                ),
                InkWell(
                  // onTap: () async {
                  //   setState(() {
                  //     _isLoading = true;
                  //   });
                  //   if (isPhoneNoValid(phoneController?.text) == false) {
                  //     setState(() {
                  //       _isLoading = false;
                  //     });
                  //     showDialog(
                  //       context: context,
                  //       builder: (BuildContext context) {
                  //         return AlertDialog(
                  //           title: Text(
                  //             'Số điện thoại không đúng định dạng',
                  //             style: defaultText16.copyWith(
                  //               color: const Color.fromARGB(255, 29, 29, 29),
                  //               fontWeight: FontWeight.w700,
                  //             ),
                  //           ),
                  //           content: Text(
                  //             'Vui lòng kiểm tra lại số điện thoại đã nhập',
                  //             style: defaultText16.copyWith(
                  //                 color: const Color(0xff3C3C3C)),
                  //           ),
                  //           actionsPadding:
                  //               const EdgeInsets.symmetric(horizontal: 10.0),
                  //           actions: <Widget>[
                  //             TextButton(
                  //               child: Text(
                  //                 'ok',
                  //                 style: defaultText16.copyWith(
                  //                     color: const Color(0xff3C3C3C)),
                  //               ),
                  //               onPressed: () {
                  //                 Navigator.of(context).pop();
                  //               },
                  //             ),
                  //           ],
                  //         );
                  //       },
                  //     );
                  //   } else {
                  // Đăng nhập tài khoản học sinh
                  // bool loged = await LoginRepo().login(
                  //   phoneController?.text ?? '',
                  // );
                  // if (loged == true) {
                  //   InfoModel? infoHomeModel =
                  //       await HomeRepo().getInfoCudan();
                  //   if (infoHomeModel != null) {
                  //     Navigator.pushReplacement(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => BottomNavBar(
                  //           infoHomeModel: infoHomeModel,
                  //         ),
                  //       ),
                  //     );
                  //   }
                  // } else {
                  //   showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) {
                  //       return CupertinoAlertDialog(
                  //         title: const Text('Vui lòng thử lại'),
                  //         content: const Text(
                  //             'Vui lòng kiểm tra lại SDT và mật khẩu của bạn'),
                  //         actions: <Widget>[
                  //           CupertinoDialogAction(
                  //             isDefaultAction: true,
                  //             child: Text(
                  //               'Đồng ý',
                  //               style: TextStyle(
                  //                   fontSize: 20, color: key1Color),
                  //             ),
                  //             onPressed: () {
                  //               Navigator.of(context, rootNavigator: true)
                  //                   .pop(
                  //                 (_) => false,
                  //               );
                  //             },
                  //           )
                  //         ],
                  //       );
                  //     },
                  //   );
                  // }
                  //  }
                  // },
                  onTap: () async {
                    setState(() {
                      _isLoading = true;
                    });

                    // Sau 5 giây, nếu vẫn đang loading thì tự tắt và báo lỗi
                    Future.delayed(const Duration(seconds: 5), () {
                      if (mounted && _isLoading) {
                        setState(() {
                          _isLoading = false;
                        });
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              'Lỗi kết nối',
                              style: defaultText14M,
                            ),
                            content: Text(
                              'Không thể gửi mã OTP. Vui lòng thử lại.',
                              style: defaultText14M,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    });

                    if (isPhoneNoValid(phoneController?.text) == false) {
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
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  setState(() {
                                    _isLoading = false;
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      //check phone
                      bool checkPhone = await LoginRepo()
                          .checkPhone(phoneController?.text ?? '');
                      // if checkphone == false => show dialog
                      if (!checkPhone &&
                          phoneController?.text != '0999999999') {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Lỗi', style: defaultText14M),
                            content: Text(
                                'Số điện thoại của bạn chưa đăng ký cư dân',
                                style: defaultText14M),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                        setState(() {
                          _isLoading = false;
                        });
                      } else {
                        FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber:
                              '+84${phoneController?.text.replaceFirst(RegExp(r'0'), '')}',
                          verificationCompleted: (PhoneAuthCredential) {},
                          verificationFailed: (error) {
                            log(error.toString());
                            if (mounted) {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Lỗi', style: defaultText14M),
                                content: Text('Xác thực thất bại',
                                    style: defaultText14M),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          },
                          codeSent: (verificationId, forceResendingToken) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => OtpScreen(
                                      contact: phoneController?.text ?? '',
                                      verificationId: verificationId,
                                    )),
                              ),
                            );
                            if (mounted) {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          },
                          codeAutoRetrievalTimeout: (verificationId) {
                            log("Auto Retrieval timeout");
                          },
                        );
                      }
                    }
                  },

                  child: _isLoading
                      ? Center(
                          child: SizedBox(
                            width: 48.w,
                            height: 48.h,
                            child: const CircularProgressIndicator(),
                          ),
                        )
                      : Container(
                          height: 48.h,
                          width: 340.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9.r),
                            color: const Color(0xff004071),
                          ),
                          child: Center(
                            child: Text('Đăng nhập',
                                textAlign: TextAlign.center,
                                style: defaultText16B.copyWith(
                                  color: Colors.white,
                                )),
                          ),
                        ),
                ),
                // Đăng nhập nếu là phụ huynh

                SizedBox(
                  height: 10.h,
                ),

                SizedBox(
                  height: 60.h,
                ),
                Text(
                  'Bạn muốn trải nghiệm ứng dụng?',
                  style: defaultText16.copyWith(
                      color: const Color(0xff8A8A8A),
                      fontWeight: FontWeight.w400),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const TakeInfoScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Để lại thông tin',
                      style: defaultText18B.copyWith(
                          color: const Color(0xff004071),
                          fontWeight: FontWeight.w500),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
