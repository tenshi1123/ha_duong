import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ha_duong/cubit/language_cubit.dart';
import 'package:ha_duong/l10n/app_localizations.dart';
import 'package:ha_duong/main.dart';
import 'package:ha_duong/modules/bottomnavbar/bql_bottom_nav_bar.dart';
import 'package:ha_duong/modules/bql/info/change_pass.dart';
import 'package:ha_duong/modules/bql/info/info_screen.dart';
import 'package:ha_duong/modules/splash/wellcom_screen.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BqlPersonalScreen extends StatelessWidget {
  const BqlPersonalScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            width: 375.w,
            height: 200.h,
            child: Stack(children: [
              Positioned(
                top: 0,
                left: 0,
                child: Image(
                  width: 375.w,
                  height: 200.h,
                  image: const AssetImage(
                    'assets/images/personal_background.png',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                bottom: 56.h,
                left: 16.w,
                child: SizedBox(
                    width: 340.w,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios_new,
                                  color: Colors.white),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                            ),
                            // Text(
                            //   'Home',
                            //   style: defaultText18B.copyWith(
                            //     color: Colors.white,
                            //   ),
                            // )
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Row(
                          children: [
                            ValueListenableBuilder<List<File>>(
                              valueListenable: mainAvatarNotifier,
                              builder: (context, value, child) {
                                if (value.isNotEmpty) {
                                  return CircleAvatar(
                                    radius: 28.r,
                                    backgroundImage: FileImage(value.first),
                                  );
                                } else {
                                  return CircleAvatar(
                                    radius: 28.r,
                                    backgroundImage: NetworkImage(
                                      infoHomeModel.avatar,
                                    ),
                                  );
                                }
                              },
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  infoHomeModel.name,
                                  style: defaultText18B.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  infoHomeModel.phone,
                                  style: defaultText16M.copyWith(
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
              Positioned(
                  bottom: 0,
                  child: Container(
                    width: 375.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.r),
                        topRight: Radius.circular(40.r),
                      ),
                    ),
                  )),
            ]),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const InfoScreen();
                  },
                ),
                // (_) => false,
              );
            },
            leading: Image(
              image: const AssetImage('assets/images/icon_info.png'),
              height: 28.h,
              width: 28.w,
            ),
            title: Text(
              AppLocalizations.of(context)!.bqlThongTinTaiKhoan,
              style: defaultText16M,
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          Container(
            height: 1.h,
            width: 303.w,
            margin: EdgeInsets.only(left: 56.w, right: 16.w),
            color: const Color(0xff292929).withAlpha(16),
          ),
          ListTile(
            onTap: () {
              pushWithoutNavBar(
                context,
                MaterialPageRoute(
                  builder: ((context) => const ChangePassScreen()),
                ),
              );
            },
            leading: Image(
              image: const AssetImage('assets/images/icon_changepass.png'),
              height: 28.h,
              width: 28.w,
            ),
            title: Text(
              AppLocalizations.of(context)!.bqlDoiMatKhau,
              style: defaultText16M,
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          Container(
            height: 1.h,
            width: 303.w,
            margin: EdgeInsets.only(left: 56.w, right: 16.w),
            color: const Color(0xff292929).withAlpha(16),
          ),
          ListTile(
            onTap: () {
              showLanguageDialog(context);
            },
            leading: Icon(
              Icons.language,
              size: 28.sp,
              color: const Color(0xff273D8C),
            ),
            title: Text(
              AppLocalizations.of(context)!.txtNgonNgu,
              style: defaultText16M,
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          Container(
            height: 1.h,
            width: 303.w,
            margin: EdgeInsets.only(left: 56.w, right: 16.w),
            color: const Color(0xff292929).withAlpha(16),
          ),
          ListTile(
            onTap: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => Dialog(
                insetPadding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r)),
                child: Container(
                  height: 170.h,
                  width: 343.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context)!.bqlDangXuat,
                        style: defaultText16M.copyWith(
                          color: const Color(0xffED1C24),
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.confirmLogout,
                        style: defaultText16M.copyWith(
                          color: const Color(0xff8A8A8A),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              height: 50.h,
                              width: 149.w,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xff273D8C),
                                ),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.bqlHuy,
                                  style: defaultText14B.copyWith(
                                    color: const Color(0xff273D8C),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () async {
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.remove('token');
                              Navigator.of(context, rootNavigator: true)
                                  .pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return const WellcomeScreen();
                                  },
                                ),
                                (_) => false,
                              );
                            },
                            color: const Color(0xffED1C24),
                            height: 50.h,
                            minWidth: 149.w,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r)),
                            child: Text(
                              AppLocalizations.of(context)!.bqlDangXuat,
                              style: defaultText14B.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            leading: Image(
              image: const AssetImage('assets/images/icon_logout.png'),
              height: 28.h,
              width: 28.w,
            ),
            title: Text(
              AppLocalizations.of(context)!.bqlDangXuat,
              style: defaultText16M.copyWith(color: const Color(0xffED1C24)),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          Container(
            height: 1.h,
            width: 303.w,
            margin: EdgeInsets.only(left: 56.w, right: 16.w),
            color: const Color(0xff292929).withAlpha(16),
          ),
        ],
      ),
    );
  }
}

Widget infoItem({
  required String title,
  required String info,
}) {
  return Row(children: [
    SizedBox(
      width: 16.w,
    ),
    Text(
      title,
      style: defaultText14Re.copyWith(
        color: const Color(0xff8A8A8A),
      ),
    ),
    const Spacer(),
    Text(
      info,
      style: defaultText14Re.copyWith(
        color: Colors.black,
      ),
    ),
    SizedBox(
      width: 16.w,
    ),
  ]);
}

void showLanguageDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context)!.txtNgonNgu),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _LanguageItem(
              title: 'Tiếng Việt',
              locale: const Locale('vi'),
            ),
            _LanguageItem(
              title: 'English',
              locale: const Locale('en'),
            ),
          ],
        ),
      );
    },
  );
}

class _LanguageItem extends StatelessWidget {
  final String title;
  final Locale locale;

  const _LanguageItem({
    required this.title,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    final current = context.watch<LanguageCubit>().state;

    return ListTile(
      title: Text(title),
      trailing: current.languageCode == locale.languageCode
          ? const Icon(Icons.check, color: Colors.green)
          : null,
      onTap: () {
        context.read<LanguageCubit>().changeLanguage(locale);
        Navigator.pop(context);
      },
    );
  }
}
