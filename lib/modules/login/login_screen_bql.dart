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
  void initState() {
    super.initState();
    fetchData().then((_) {
      setState(() {});
    });
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
                        hintText: 'Email',
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
                      'Mật khẩu',
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
                        hintText: 'Mật khẩu',
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
                        'Quên mật khẩu?',
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
                              'Email không đúng định dạng',
                              style: defaultText16.copyWith(
                                color: const Color.fromARGB(255, 29, 29, 29),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            content: Text(
                              'Vui lòng kiểm tra lại email đã nhập',
                              style: defaultText16.copyWith(
                                  color: const Color(0xff3C3C3C)),
                            ),
                            actionsPadding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            actions: <Widget>[
                              TextButton(
                                child: Text(
                                  'ok',
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavBarBql(
                                infoModel: infoHomeModel,
                                homeModel: homeModel,
                              ),
                            ),
                          );
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'Đăng nhập thất bại',
                                style: defaultText16.copyWith(
                                  color: const Color.fromARGB(255, 29, 29, 29),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              content: Text(
                                'Vui lòng kiểm tra lại tài khoản và mật khẩu',
                                style: defaultText16.copyWith(
                                    color: const Color(0xff3C3C3C)),
                              ),
                              actionsPadding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'OK',
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
                              'Đăng nhập',
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
                  height: 20.h,
                ),
                isTrue
                    ? Text(
                        'Bạn muốn trải nghiệm ứng dụng?',
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
                          'Để lại thông tin',
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
