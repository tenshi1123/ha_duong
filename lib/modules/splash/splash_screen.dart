import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//import '../bottomnavbar/bottom_nav_bar.dart';
import '../bottomnavbar/bottom_nav_bar.dart';
import '../login/login_screen.dart';
import 'onboarding.dart';

class Splshscreen extends StatefulWidget {
  const Splshscreen({super.key});

  @override
  State<Splshscreen> createState() => _SplshscreenState();
}

class _SplshscreenState extends State<Splshscreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 1),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
          // quá mệt mỏi rồi, ngày hôm nay cô ấy chẳng quan tâm gì mấy chỉ một người để yêu thương lúc này ngày hôm ấy cố muốn đi để mua một đóa hoa trang trí nơi đẹp nhất trong nhà cô ấy hay buồn lúc mưa thích nghe câu ca ngày xưa, Những lúc khi trời đông nhớ vòng tay ấm nồng và ôm cô ấy thật lâu người ấy vì thương tôi chờ đợi tôi cũng lâu rồi
          //builder: (context) => const BottomNavBar(),
        ),
      ),
    );
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
