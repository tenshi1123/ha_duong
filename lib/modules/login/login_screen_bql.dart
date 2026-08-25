import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/bql_model/home_model.dart';
import 'package:ha_duong/bql_repo/bql_home_repo.dart';
import 'package:ha_duong/bql_repo/info_repo_bql.dart';
import 'package:ha_duong/bql_model/info_model_bql.dart';
import 'package:ha_duong/modules/bottomnavbar/bql_bottom_nav_bar.dart';
import 'package:ha_duong/modules/login/take_info_screen.dart';
import 'package:ha_duong/bql_repo/login_repo_bql.dart';
import 'package:ha_duong/utils/constants/color.dart';

import '../../utils/constants/styles.dart';

import 'forgot_password_screen.dart';
import 'package:ha_duong/l10n/app_localizations.dart';
import 'package:local_auth/local_auth.dart';
import '../../utils/secure_storage_helper.dart';

class LoginScreenBql extends StatefulWidget {
  const LoginScreenBql({super.key});
  @override
  State<LoginScreenBql> createState() => _LoginScreenBqlState();
}

class _LoginScreenBqlState extends State<LoginScreenBql> {
  bool _isObscure = true;
  final _focusNode = FocusNode();
  final _focusNode1 = FocusNode();
  bool isTrue = false;

  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics = false;
  String? _savedEmail;
  String? _savedPassword;

  @override
  void initState() {
    super.initState();
    fetchData().then((_) {
      setState(() {});
    });
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    bool isDeviceSupported = await auth.isDeviceSupported();
    String? email = await SecureStorageHelper.getBqlEmail();
    String? password = await SecureStorageHelper.getBqlPassword();
    String? userType = await SecureStorageHelper.getUserType();

    if (canCheckBiometrics && isDeviceSupported && email != null && password != null && userType == 'bql') {
      setState(() {
        _canCheckBiometrics = true;
        _savedEmail = email;
        _savedPassword = password;
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
      if (authenticated && _savedEmail != null && _savedPassword != null) {
        setState(() {
          _isLoading = true;
        });
        bool loged = await LoginRepoBql().login(_savedEmail!, _savedPassword!);
        if (loged) {
          InfoModelBql? infoHomeModel = await InfoRepo().getInfo();
          HomeModel? homeModel = await HomeRepo().getHomeModel();
          if (infoHomeModel != null && homeModel != null && mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavBarBql(
                  infoModel: infoHomeModel,
                  homeModel: homeModel,
                ),
              ),
              (route) => false,
            );
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Đăng nhập thất bại. Vui lòng thử lại.')),
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
      debugPrint('Biometric error: $e');
    }
  }

  bool isemailValid(String? email) {
    if (email == null) return false;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regExp.hasMatch(email);
  }

  bool _isLoading = false;
  TextEditingController? passController = TextEditingController();
  TextEditingController? emailController = TextEditingController();
  Future<void> fetchData() async {
    isTrue = await LoginRepoBql().fetchBoolValue() ?? false;
  }

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
            //bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 60.h),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.hello,
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
                    color: const Color(0xffF4F1F3),
                  ),
                  child: Center(
                    child: TextField(
                      //keyboardType: const TextInputType.numberWithOptions(),
                      controller: emailController,
                      focusNode: _focusNode1,
                      style: defaultText16,
                      scrollPadding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).viewInsets.bottom),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person_2_outlined,
                          color: subBlack,
                        ),
                        hintText: AppLocalizations.of(context)!.email,
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
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
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.password,
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
                    color: const Color(0xffF4F1F3),
                  ),
                  child: Center(
                    child: TextField(
                      obscureText: _isObscure,
                      obscuringCharacter: "*",
                      style: defaultText16,
                      controller: passController,
                      focusNode: _focusNode,
                      scrollPadding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).viewInsets.bottom),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: subBlack,
                        ),
                        hintText: AppLocalizations.of(context)!.password,
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          color: subBlack,
                        ),
                        suffixIcon: IconButton(
                          padding: const EdgeInsets.all(0),
                          iconSize: 20.0,
                          icon: _isObscure
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
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const ForgotPassScreen(
                                // contact: '0367147321',
                                )),
                          ),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.forgotPasswordQuestion,
                        style: TextStyle(
                          color: const Color(0xff004071),
                          fontSize: 16.sp,
                          //decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 140.h,
                ),
                InkWell(
                  onTap: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    if (isemailValid(emailController?.text) == false) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              AppLocalizations.of(context)!.invalidEmailFormat,
                              style: defaultText16.copyWith(
                                color: const Color.fromARGB(255, 29, 29, 29),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            content: Text(
                              AppLocalizations.of(context)!.pleaseCheckEmail,
                              style: defaultText16.copyWith(
                                  color: const Color(0xff3C3C3C)),
                            ),
                            actionsPadding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            actions: <Widget>[
                              TextButton(
                                child: Text(
                                  AppLocalizations.of(context)!.ok,
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
                      setState(() {
                        _isLoading = false;
                      });
                    } else {
                      if (isTrue) {
                        emailController?.text = 'nhuthat22@gmail.com';
                        passController?.text = '123456';
                      }
                      bool loged = await LoginRepoBql().login(
                          emailController?.text ?? '',
                          passController?.text ?? '');
                      if (loged) {
                        InfoModelBql? infoHomeModel =
                            await InfoRepo().getInfo();
                        HomeModel? homeModel = await HomeRepo().getHomeModel();
                        if (infoHomeModel != null && homeModel != null) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavBarBql(
                                infoModel: infoHomeModel,
                                homeModel: homeModel,
                              ),
                            ),
                            (route) => false,
                          );
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                AppLocalizations.of(context)!.loginFailed,
                                style: defaultText16.copyWith(
                                  color: const Color.fromARGB(255, 29, 29, 29),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              content: Text(
                                AppLocalizations.of(context)!.pleaseCheckAccountAndPassword,
                                style: defaultText16.copyWith(
                                    color: const Color(0xff3C3C3C)),
                              ),
                              actionsPadding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    AppLocalizations.of(context)!.ok,
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
                      setState(() {
                        _isLoading = false;
                      });
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
                            child: Text(
                              AppLocalizations.of(context)!.login,
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
                // Biometric Button
                if (_canCheckBiometrics) ...[
                  SizedBox(height: 20.h),
                  IconButton(
                    iconSize: 50.r,
                    icon: const Icon(Icons.fingerprint, color: Color(0xff004071)),
                    onPressed: _authenticate,
                  ),
                  Text('Đăng nhập bằng sinh trắc học', style: defaultText14M.copyWith(color: const Color(0xff004071))),
                ],
                SizedBox(
                  height: 20.h,
                ),
                isTrue
                    ? Text(
                        AppLocalizations.of(context)!.wantToExperienceApp,
                        style: defaultText16.copyWith(
                            color: const Color(0xff8A8A8A),
                            fontWeight: FontWeight.w400),
                      )
                    : SizedBox(),
                isTrue
                    ? TextButton(
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
                        ))
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
