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
      onesignalId: onesignalId ?? '',
    );
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
              width: 32.w,
              height: 32.h,
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
      navBarBuilder: (navBarConfig) => Builder(
        builder: (context) =>
            customNavBarWithCenterCircle(context, navBarConfig),
      ),
    );
  }
}

Widget customNavBarWithCenterCircle(BuildContext context, NavBarConfig config) {
  return Container(
    height: 80.h,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 6,
          offset: Offset(0, -2),
        )
      ],
    ),
    child: Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        // Icon giữa (nổi)
        Positioned(
          top: -28.h,
          child: GestureDetector(
            onTap: () => config.onItemSelected(2),
            child: Column(
              children: [
                Container(
                  height: 64.h,
                  width: 64.w,
                  padding: EdgeInsets.all(8.r),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      //color: Color(0xff005DA4),
                      gradient: LinearGradient(
                        colors: [Color(0xff007AD7), Color(0xff004071)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: config.items[2].icon,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  config.items[2].title ?? '',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: config.selectedIndex == 2
                        ? const Color(0xff005DA4)
                        : const Color(0xff8A8A8A),
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ),

        // Các icon hai bên
        Positioned.fill(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(config.items.length, (index) {
              if (index == 2) {
                return SizedBox(width: 64.w);
              }
              final item = config.items[index];
              final isSelected = config.selectedIndex == index;
              return GestureDetector(
                onTap: () => config.onItemSelected(index),
                child: SizedBox(
                  width: 64.w,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      if (isSelected)
                        Positioned(
                          top: 0,
                          child: Container(
                            width: 60.w,
                            height: 4.h,
                            decoration: BoxDecoration(
                              color: const Color(0xff005DA4),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(4.r),
                                bottomRight: Radius.circular(4.r),
                              ),
                            ),
                          ),
                        ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 6.h),
                          isSelected ? item.icon : item.inactiveIcon,
                          SizedBox(height: 8.h),
                          Text(
                            item.title ?? '',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: isSelected
                                  ? item.activeForegroundColor
                                  : const Color(0xff8A8A8A),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    ),
  );
}
