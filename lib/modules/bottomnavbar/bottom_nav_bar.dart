import "dart:io";

import "package:ha_duong/models/info_model.dart";
import "package:ha_duong/modules/bottomnavbar/home/home.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:ha_duong/repo/login_repo.dart";
import "package:ha_duong/utils/onesignal.dart";
import "package:onesignal_flutter/onesignal_flutter.dart";
import "package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart";
import 'package:flutter_svg/flutter_svg.dart';

import "bill/bill_screen.dart";
import "info/personal_screen.dart";
import "service/extension_screen.dart";
import "support/support_screen.dart";

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
    required this.infoHomeModel,
  });
  final InfoModel infoHomeModel;
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final PersistentTabController _controller = PersistentTabController();
  @override
  void initState() {
    super.initState();
    setupOneSignal();
  }

  Future<void> setupOneSignal() async {
    await initOneSignal();
    var onesignalId = await OneSignal.User.getOnesignalId();
    await LoginRepo().pushOnesignalId(
        apatmentId: widget.infoHomeModel.listApartment[0].id,
        onesignalId: onesignalId ?? '');
    if (Platform.isAndroid) {
      OneSignal.Notifications.addClickListener((event) {});
    } else {
      //do nothing :v tự báo chính mình
      OneSignal.Notifications.addClickListener((event) {});
    }
    promptPolicyPrivacy();
  }

  Future<void> promptPolicyPrivacy() async {
    if (Platform.isAndroid) {
      OneSignal.consentRequired(true);
      OneSignal.consentGiven(true);
    } else {
      //do nothing :v
    }
    // sendUserTag(userId);
  }

  List<PersistentTabConfig> _tabs() => [
        PersistentTabConfig(
          screen: HomeScreen(
            infoHomeModel: widget.infoHomeModel,
          ),
          item: ItemConfig(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              height: 28.h,
              width: 28.w,
              fit: BoxFit.fill,
            ),
            title: "Trang chủ",
            inactiveIcon: SvgPicture.asset(
              'assets/icons/inactive_home.svg',
            ),
            inactiveBackgroundColor: Colors.white.withValues(alpha: 0.2),
          ),
        ),
        PersistentTabConfig(
          screen: const BillScreen(),
          item: ItemConfig(
            icon: SvgPicture.asset(
              'assets/icons/lophoc.svg',
              height: 28.h,
              width: 28.w,
              fit: BoxFit.fill,
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
          screen: SupportScreen(
            id: widget.infoHomeModel.listApartment.first.id,
          ),
          item: ItemConfig(
            icon: SvgPicture.asset(
              'assets/icons/support.svg',
            ),
            title: "Hỗ trợ",
            inactiveIcon: SvgPicture.asset(
              'assets/icons/support.svg',
            ),
            activeForegroundColor: const Color(0xff005DA4),
            inactiveBackgroundColor: Colors.white.withValues(alpha: 0.2),
          ),
        ),
        PersistentTabConfig(
          screen: ExtensionScreen(
            id: widget.infoHomeModel.listApartment[0].id,
          ),
          item: ItemConfig(
            icon: SvgPicture.asset(
              'assets/icons/video.svg',
              height: 28.h,
              width: 28.w,
              fit: BoxFit.fill,
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
          screen: PersonalScreen(
            infoHomeModel: widget.infoHomeModel,
          ),
          item: ItemConfig(
            icon: SvgPicture.asset(
              'assets/icons/personal.svg',
              fit: BoxFit.fill,
              height: 28.h,
              width: 28.w,
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
        // width: 375.w,
        // height: 80.h,
        child: Style13BottomNavBar(
          navBarConfig: navBarConfig,
          navBarDecoration: const NavBarDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 4,
                offset: Offset(3, 4), // Shadow position
              ),
            ],
          ),
        ),
      ),
      margin: EdgeInsets.only(bottom: 2.h),
      backgroundColor: Colors.white,
      //navBarHeight: 55.h,
    );
  }
}
