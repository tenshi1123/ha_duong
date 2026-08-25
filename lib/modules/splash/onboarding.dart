// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/mediaqury.dart';
import '../login/login_screen.dart';
import '../../utils/constants/styles.dart';
import 'package:ha_duong/l10n/app_localizations.dart';

class Onbonding extends StatefulWidget {
  const Onbonding({super.key});

  @override
  _OnbondingState createState() => _OnbondingState();
}

class _OnbondingState extends State<Onbonding> {
  final int _numPages = 3;

  final int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  late bool isLoading;

  @override
  void initState() {
    isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      height: 8.h,
      width: isActive ? 20.w : 8.h,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xff004071) : const Color(0xffD9D9D9),
        borderRadius: BorderRadius.all(
          Radius.circular(100.r),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: [
            Container(
              height: 812.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                const Spacer(),
                Container(
                  // color: Colors.white.withValues(alpha: 0.9),
                  height: 438.h,
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.r),
                      topRight: Radius.circular(40.r),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.skip,
                            style: defaultText14,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _buildPageIndicator(),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => const LoginScreen()),
                                ),
                              );
                            },
                            child: Container(
                              height: 42.h,
                              width: 42.w,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.r))),
                              child: Center(
                                child: Icon(
                                  Icons.keyboard_arrow_right,
                                  size: 30.h,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
