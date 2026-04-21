import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/bql_model/home_model.dart';
import 'package:ha_duong/bql_model/info_model_bql.dart';
import 'package:ha_duong/bql_repo/notification_repo.dart';
import 'package:ha_duong/modules/bql/notification/create_noti_screen.dart';
import 'package:ha_duong/modules/bql/notification/notification_screen.dart';
import 'package:ha_duong/utils/constants/styles.dart';

class ToaNhaSelectorScreen extends StatefulWidget {
  const ToaNhaSelectorScreen({super.key, required this.homemodel});
  final HomeModel homemodel;
  @override
  _ToaNhaSelectorScreenState createState() => _ToaNhaSelectorScreenState();
}

class _ToaNhaSelectorScreenState extends State<ToaNhaSelectorScreen> {
  int selectedTab = 0;
  List<BuildingModel> buildings = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    buildings = widget.homemodel.listBuilding;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 136.h,
            padding: EdgeInsets.only(top: 40.h),
            decoration: const BoxDecoration(
              color: Color(0xFF25AAE1),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Container(
                height: 52.h,
                width: 343.w,
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Row(
                  children: [
                    _buildTabButton("Thông báo đã tạo", 0),
                    _buildTabButton("Tạo thông báo", 1),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.h),
            child: Text(
              "Chọn tòa nhà",
              style: defaultText16M,
            ),
          ),
          const SizedBox(height: 8),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: buildings.length,
                    itemBuilder: (context, index) {
                      final item = buildings[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () async {
                            if (selectedTab == 0) {
                              // Navigate to ThongBaoDaTaoScreen
                              List<NotiValueModel> notiList =
                                  await NotificationRepo().getListNoti(
                                      buildingId: item.id,
                                      show: 25,
                                      page: 1,
                                      type: '');
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ThongBaoDaTaoScreen(
                                    listNotiModel: notiList,
                                  ),
                                ),
                              );
                            } else {
                              // Navigate to ThongBaoDaTaoScreen
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => TaoThongBaoScreen(
                                    buildingId: item.id,
                                    buildingName: item.name,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                )
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 5.w,
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff25AAE1),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12.r),
                                      bottomLeft: Radius.circular(12.r),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 16.h, horizontal: 12.w),
                                    child: Text(
                                      item.name,
                                      style: defaultText14M,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, int index) {
    final isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          setState(() {
            selectedTab = index;
            isLoading = true;
          });
          await addLoading();
          setState(() {
            isLoading = false;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xff0C8DC2) : Colors.transparent,
            borderRadius: BorderRadius.circular(36.r),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Future addLoading() async {
    await Future.delayed(const Duration(milliseconds: 50));
  }
}

class ToaNha {
  final String name;
  final Color color;

  ToaNha({required this.name, required this.color});
}
