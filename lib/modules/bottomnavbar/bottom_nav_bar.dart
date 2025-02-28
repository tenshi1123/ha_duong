import "package:ha_duong/modules/bottomnavbar/home/home.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart";
import 'package:flutter_svg/flutter_svg.dart';

import "bill/bill_screen.dart";
import "info/personal_screen.dart";
import "service/extension_screen.dart";
import "support/support_screen.dart";

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final PersistentTabController _controller = PersistentTabController();
  @override
  void initState() {
    super.initState();
    //setupOneSignal();
  }

  List<PersistentTabConfig> _tabs() => [
        PersistentTabConfig(
          screen: const HomeScreen(),
          item: ItemConfig(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
            ),
            title: "Trang chủ",
            inactiveIcon: SvgPicture.asset(
              'assets/icons/inactive_home.svg',
            ),
            inactiveBackgroundColor: Colors.white.withValues(alpha: 0.2),
          ),
        ),
        PersistentTabConfig(
          screen: const TabBarApp(),
          item: ItemConfig(
            icon: SvgPicture.asset(
              'assets/icons/lophoc.svg',
            ),
            title: "Hoá đơn",
            activeForegroundColor: const Color(0xff273D8C),
            inactiveIcon: SvgPicture.asset(
              'assets/icons/inactive_lophoc.svg',
            ),
            inactiveForegroundColor:
                const Color(0xff273D8C).withValues(alpha: 0.4),
            inactiveBackgroundColor: Colors.white.withValues(alpha: 0.2),
          ),
        ),
        PersistentTabConfig(
          screen: const SupportScreen(),
          item: ItemConfig(
            icon: SvgPicture.asset(
              'assets/icons/support.svg',
            ),
            title: "Hỗ trợ",
            inactiveIcon: SvgPicture.asset(
              'assets/icons/support.svg',
            ),
            inactiveBackgroundColor: Colors.white.withValues(alpha: 0.2),
          ),
        ),
        PersistentTabConfig(
          screen: const ExtensionScreen(),
          item: ItemConfig(
            icon: SvgPicture.asset(
              'assets/icons/video.svg',
            ),
            title: "Tiện ích",
            activeForegroundColor: const Color(0xff273D8C),
            inactiveForegroundColor:
                const Color(0xff273D8C).withValues(alpha: 0.4),
            inactiveIcon: SvgPicture.asset(
              'assets/icons/inactive_video.svg',
            ),
            inactiveBackgroundColor: Colors.white.withValues(alpha: 0.2),
          ),
        ),
        PersistentTabConfig(
          screen: const PersonalScreen(),
          item: ItemConfig(
            icon: SvgPicture.asset(
              'assets/icons/personal.svg',
            ),
            title: "Tài khoản",
            activeForegroundColor: const Color(0xff273D8C),
            inactiveForegroundColor:
                const Color(0xff273D8C).withValues(alpha: 0.4),
            inactiveIcon: SvgPicture.asset(
              'assets/icons/inactive_personal.svg',
            ),
            inactiveBackgroundColor: Colors.white.withValues(alpha: 0.2),
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: _controller,
      tabs: _tabs(),
      navBarBuilder: (navBarConfig) => SizedBox(
        width: 375.w,
        height: 80.h,
        child: Style13BottomNavBar(
          //itemPadding: EdgeInsets.all(5.h),
          navBarConfig: navBarConfig,
          navBarDecoration: const NavBarDecoration(
            //padding: const EdgeInsets.all(5),
            color: Colors.white,
            // borderRadius: BorderRadius.circular(25.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 4,
                offset: Offset(3, 4), // Shadow position
              ),
            ],
          ),
          //itemAnimationProperties: const ItemAnimation(),
        ),
      ),
      backgroundColor: Colors.white,
      navBarHeight: 55.h,
    );
  }
}
