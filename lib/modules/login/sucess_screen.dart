import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/modules/login/login_screen.dart';

import '../../utils/constants/styles.dart';
import 'package:ha_duong/l10n/app_localizations.dart';

class SucessScreen extends StatelessWidget {
  const SucessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 76.h,
            ),
            Image.asset(
              'assets/images/success.png',
            ),
            SizedBox(
              height: 24.h,
            ),
            Text(
              AppLocalizations.of(context)!.sendRegistrationInfoSuccess,
              style: defaultText16B.copyWith(
                color: const Color(0xff3C3C3C),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                AppLocalizations.of(context)!.registrationInfoSentSuccessfully,
                style: defaultText14Re.copyWith(
                  color: const Color(0xff8A8A8A),
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: Container(
                height: 48.h,
                width: 340.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9.r),
                  color: const Color(0xff004071),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.backToLogin,
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
          ],
        ),
      ),
    );
  }
}
