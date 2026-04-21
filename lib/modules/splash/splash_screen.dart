import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/bql_model/home_model.dart';
import 'package:ha_duong/bql_model/info_model_bql.dart';
import 'package:ha_duong/bql_repo/info_repo_bql.dart';
import 'package:ha_duong/models/info_model.dart';
import 'package:ha_duong/modules/bottomnavbar/bottom_nav_bar.dart';
import 'package:ha_duong/modules/bottomnavbar/bql_bottom_nav_bar.dart';
import 'package:ha_duong/modules/splash/wellcom_screen.dart';
import 'package:ha_duong/repo/home_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import '../bottomnavbar/bottom_nav_bar.dart';

class Splshscreen extends StatefulWidget {
  const Splshscreen({super.key});

  @override
  State<Splshscreen> createState() => _SplshscreenState();
}

class _SplshscreenState extends State<Splshscreen> {
  bool checked = false;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 0), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      checked = (token != null && token != '');
      if (checked) {
        InfoModel? infoHomeModel = await HomeRepo().getInfoCudan();
        if (!mounted) return;
        if (infoHomeModel != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavBar(
                infoHomeModel: infoHomeModel,
              ),
            ),
          );
        } else {
          InfoModelBql? infoHomeModel = await InfoRepo().getInfo();
          HomeModel? homeModel = await HomeRepo().getHomeModel();

          if (!mounted) return;

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
          } else {
            if (!mounted) return;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const WellcomeScreen(),
              ),
            );
          }
        }
      } else {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const WellcomeScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Image.asset(
        "assets/images/splash.png",
        height: 844.h,
        width: 390.w,
        fit: BoxFit.fill,
      ),
    );
  }
}
