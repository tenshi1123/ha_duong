import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ha_duong/bql_model/home_model.dart';
import 'package:ha_duong/bql_model/info_model_bql.dart';
import 'package:ha_duong/bql_repo/login_repo_bql.dart';
import 'package:ha_duong/modules/bql/apartment/apartment_screen.dart';
import 'package:ha_duong/modules/bql/bill/dien_nuoc_screen.dart';
import 'package:ha_duong/modules/bql/home/change_info/change_info.dart';
import 'package:ha_duong/modules/bql/home/home_bql.dart';
import 'package:ha_duong/modules/bql/home/yeucau_hotro/list_request_screen.dart';
import 'package:ha_duong/modules/bql/home/yeucau_hotro/list_tien_ich.dart';
import 'package:ha_duong/modules/bql/home/yeucau_hotro/request_detail_screen.dart';
import 'package:ha_duong/modules/bql/notification/home_noti_screen.dart';
import 'package:ha_duong/utils/constants/styles.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:ha_duong/l10n/app_localizations.dart';

late InfoModelBql infoHomeModel;

class BottomNavBarBql extends StatefulWidget {
  const BottomNavBarBql({
    super.key,
    required this.infoModel,
    required this.homeModel,
  });
  final InfoModelBql infoModel;
  final HomeModel homeModel;
  @override
  _BottomNavBarBqlState createState() => _BottomNavBarBqlState();
}

class _BottomNavBarBqlState extends State<BottomNavBarBql> {
  int _currentIndex = 0;
  late List<Widget> _screens;
  @override
  void initState() {
    super.initState();
    setupOneSignal();
    infoHomeModel = widget.infoModel;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screens = [
      HomeScreen(
        homeModel: widget.homeModel,
        isTest: widget.infoModel.name == AppLocalizations.of(context)!.nhuThat,
      ),
      ApartmentScreen(
        homeModel: widget.homeModel,
      ),
      SupportRequestPage(
        type: 0,
        listBuild: widget.homeModel.listBuilding,
      ),
      ReceiptScreen(
        listBuild: widget.homeModel.listBuilding,
      ),
      ToaNhaSelectorScreen(
        homemodel: widget.homeModel,
      ),
    ];
  }

  Future<void> setupOneSignal() async {
    OneSignal.initialize('03d3a4a8-99c4-45be-bc16-39b4510fca48');
    OneSignal.Notifications.requestPermission(true).then((value) {});
    var onesignalId = await OneSignal.User.getOnesignalId();
    await LoginRepoBql().pushOnesignalId(
      onesignalId: onesignalId ?? '',
    );
    OneSignal.Notifications.addClickListener((event) async {
      final data = event.notification.additionalData;
      if (data != null) {
        String requestId = data['id'];
        if (data['type'] == 'hotro') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RequestDetailScreen(
                id: requestId,
              ),
            ),
          );
        }
      } else {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.supportRequest,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff004071),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    AppLocalizations.of(context)!.residentRequestsUpdatedHere,
                    textAlign: TextAlign.center,
                    style: defaultText14M.copyWith(
                      color: const Color(0xff8A8A8A),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            backgroundColor: Colors.lightBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SupportRequestPage(
                                  type: 1,
                                  listBuild: widget.homeModel.listBuilding,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.supportFeedback,
                            style: defaultText14M.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            backgroundColor: Colors.lightBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ChangeInfoScreen(
                                  listBuild: widget.homeModel.listBuilding,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.changeInformation,
                            style: defaultText14M.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      backgroundColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ListExtensionScreen(
                            type: 1,
                            listBuild: widget.homeModel.listBuilding,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      '  Danh sách đăng ký tiện ích  ',
                      style: defaultText14M.copyWith(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            );
          },
        );
      }
    });
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

  List<BottomNavigationBarItem> _items(BuildContext context) => [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home, color: Color(0xff004071)),
      label: AppLocalizations.of(context)!.home,
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        'assets/icons/apartment.svg',
      ),
      activeIcon: SvgPicture.asset(
        'assets/icons/active_apartment.svg',
      ),
      label: AppLocalizations.of(context)!.apartment,
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        'assets/icons/support.svg',
      ),
      activeIcon: SvgPicture.asset(
        'assets/icons/active_support.svg',
      ),
      label: AppLocalizations.of(context)!.support,
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        'assets/icons/dvu.svg',
      ),
      activeIcon: SvgPicture.asset(
        'assets/icons/active_dvu.svg',
      ),
      label: AppLocalizations.of(context)!.electricityWater,
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        'assets/icons/noti.svg',
      ),
      activeIcon: SvgPicture.asset(
        'assets/icons/active_noti.svg',
      ),
      label: AppLocalizations.of(context)!.notification,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: _currentIndex,
            onTap: (index) {
              if (index == 2) {
                // Hiển thị bottom sheet thay vì chuyển màn hình
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 24.h,
                          horizontal: 16.w,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.supportRequest,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff004071),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              AppLocalizations.of(context)!.residentRequestsUpdatedHere,
                              textAlign: TextAlign.center,
                              style: defaultText14M.copyWith(
                                color: const Color(0xff8A8A8A),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15.h),
                                      backgroundColor: Colors.lightBlue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => SupportRequestPage(
                                            type: 1,
                                            listBuild:
                                                widget.homeModel.listBuilding,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.supportFeedback,
                                      style: defaultText14M.copyWith(
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15.h),
                                      backgroundColor: Colors.lightBlue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => ChangeInfoScreen(
                                            listBuild:
                                                widget.homeModel.listBuilding,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.changeInformation,
                                      style: defaultText14M.copyWith(
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 15.h),
                                backgroundColor: Colors.lightBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ListExtensionScreen(
                                      type: 1,
                                      listBuild: widget.homeModel.listBuilding,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                '  Danh sách đăng ký tiện ích  ',
                                style: defaultText14M.copyWith(
                                    color: Colors.white),
                              ),
                            ),
                            SizedBox(height: 10.h),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                setState(() => _currentIndex = index);
              }
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            items: _items(context),
          ),
        ),
      ),
    );
  }
}
