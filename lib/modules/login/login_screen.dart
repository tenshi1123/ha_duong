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
import 'package:ha_duong/l10n/app_localizations.dart';
import 'package:local_auth/local_auth.dart';
import '../../utils/secure_storage_helper.dart';
import 'package:ha_duong/models/info_model.dart';
import 'package:ha_duong/repo/home_repo.dart';
import 'package:ha_duong/modules/bottomnavbar/bottom_nav_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics = false;
  String? _savedPhone;

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    bool isDeviceSupported = await auth.isDeviceSupported();
    String? phone = await SecureStorageHelper.getResidentPhone();
    String? userType = await SecureStorageHelper.getUserType();

    if (canCheckBiometrics &&
        isDeviceSupported &&
        phone != null &&
        userType == 'resident') {
      setState(() {
        _canCheckBiometrics = true;
        _savedPhone = phone;
      });
    }
  }

  Future<void> _authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Đăng nhập bằng vân tay/khuôn mặt',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      if (authenticated && _savedPhone != null) {
        setState(() {
          _isLoading = true;
        });
        bool loged = await LoginRepo().login(_savedPhone!);
        if (loged == true) {
          InfoModel? infoHomeModel = await HomeRepo().getInfoCudan();
          if (infoHomeModel != null && mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavBar(
                  infoHomeModel: infoHomeModel,
                ),
              ),
              (route) => false,
            );
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Đăng nhập thất bại. Vui lòng thử lại.')),
            );
          }
        }
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      log('Biometric error: $e');
    }
  }

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
                    //back button
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xff004071),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.hello,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 24.sp,
                            color: const Color(0xff004071),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.welcomeBackLogin,
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
                  ],
                ),

                SizedBox(
                  height: 30.h,
                ),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.account,
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
                        hintText: AppLocalizations.of(context)!.phoneNumber,
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
                //       AppLocalizations.of(context)!.txtMatKhau,
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
                //         hintText: AppLocalizations.of(context)!.txtMatKhau,
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
                //         AppLocalizations.of(context)!.txtQuenMatKhau1,
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
                  //             AppLocalizations.of(context)!.txtSoDienThoaiKhongDungDinhDang,
                  //             style: defaultText16.copyWith(
                  //               color: const Color.fromARGB(255, 29, 29, 29),
                  //               fontWeight: FontWeight.w700,
                  //             ),
                  //           ),
                  //           content: Text(
                  //             AppLocalizations.of(context)!.txtVuiLongKiemTraLaiSoDienThoaiDaNhap,
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
                  //         title: Text(AppLocalizations.of(context)!.txtVuiLongThuLai),
                  //         content: const Text(
                  //             AppLocalizations.of(context)!.txtVuiLongKiemTraLaiSdtVaMatKhauCuaBan),
                  //         actions: <Widget>[
                  //           CupertinoDialogAction(
                  //             isDefaultAction: true,
                  //             child: Text(
                  //               AppLocalizations.of(context)!.txtDongY,
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
                              AppLocalizations.of(context)!.connectionError,
                              style: defaultText14M,
                            ),
                            content: Text(
                              AppLocalizations.of(context)!.cannotSendOtp,
                              style: defaultText14M,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(AppLocalizations.of(context)!.ok),
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
                              AppLocalizations.of(context)!.invalidPhoneNumber,
                              style: defaultText14M,
                            ),
                            content: Text(
                              AppLocalizations.of(context)!
                                  .pleaseCheckPhoneNumber,
                              style: defaultText14M,
                            ),
                            actionsPadding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            actions: <Widget>[
                              TextButton(
                                child: Text(AppLocalizations.of(context)!.ok),
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
                            title: Text(AppLocalizations.of(context)!.error,
                                style: defaultText14M),
                            content: Text(
                                AppLocalizations.of(context)!
                                    .phoneNotRegisteredResident,
                                style: defaultText14M),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(AppLocalizations.of(context)!.ok),
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
                                title: Text(AppLocalizations.of(context)!.error,
                                    style: defaultText14M),
                                content: Text(
                                    AppLocalizations.of(context)!.authFailed,
                                    style: defaultText14M),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child:
                                        Text(AppLocalizations.of(context)!.ok),
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
                            log(AppLocalizations.of(context)!
                                .txtAutoRetrievalTimeout);
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
                            child: Text(AppLocalizations.of(context)!.login,
                                textAlign: TextAlign.center,
                                style: defaultText16B.copyWith(
                                  color: Colors.white,
                                )),
                          ),
                        ),
                ),
                // Đăng nhập nếu là phụ huynh

                // Biometric Button
                if (_canCheckBiometrics) ...[
                  SizedBox(height: 20.h),
                  IconButton(
                    iconSize: 50.r,
                    icon:
                        const Icon(Icons.fingerprint, color: Color(0xff004071)),
                    onPressed: _authenticate,
                  ),
                  Text('Đăng nhập bằng sinh trắc học',
                      style: defaultText14M.copyWith(
                          color: const Color(0xff004071))),
                ],
                SizedBox(
                  height: 60.h,
                ),
                Text(
                  AppLocalizations.of(context)!.wantToExperienceApp,
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
                      AppLocalizations.of(context)!.leaveInformation,
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
