import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/app.dart';
import 'package:ha_duong/bql_model/home_model.dart';
import 'package:ha_duong/bql_model/info_model_bql.dart';
import 'package:ha_duong/bql_repo/technical_requests_repo.dart';
import 'package:ha_duong/modules/bql/home/change_info/detail_change_info_screen.dart';
import 'package:ha_duong/modules/bql/home/home.dart';
import 'package:ha_duong/utils/constants/styles.dart';

class ChangeInfoScreen extends StatefulWidget {
  const ChangeInfoScreen({super.key, required this.listBuild});
  final List<BuildingModel> listBuild;
  @override
  State<ChangeInfoScreen> createState() => _ChangeInfoScreenState();
}

class _ChangeInfoScreenState extends State<ChangeInfoScreen> with RouteAware {
  int currentPage = 1;
  bool isLoading = true;
  late List<ResidentPendingModel> listTechnicalRequests;

  @override
  void initState() {
    fetchData();
    super.initState();
    //_loadSupportData();
  }

  Future<void> fetchData() async {
    try {
      final response = await TechnicalRequestsRepo()
          .getListChangeInfo(buildingId: homeSelecteBuilding?.id ?? '0');
      setState(() {
        listTechnicalRequests = response;
        isLoading = false;
      });
    } catch (e) {
      // Xử lý lỗi nếu cần
      debugPrint('Lỗi khi gọi API: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Thay đổi thông tin"),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 20.h,
            width: double.infinity,
            color: Colors.lightBlue,
            child: Container(
              width: double.infinity,
              height: 20.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
              ),
            ),
          ),
          Container(
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            margin: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              bottom: 16.h,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff00A1E4), width: 1.5.w),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<BuildingModel>(
                isExpanded: true,
                value: homeSelecteBuilding,
                icon: Icon(Icons.keyboard_arrow_down, size: 20.sp),
                hint: Text(
                  'Chọn toà nhà',
                  style: defaultText14M,
                ),
                items: widget.listBuild.map((b) {
                  return DropdownMenuItem(
                    value: b,
                    child: Text(
                      b.name,
                      style: defaultText14M,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    homeSelecteBuilding = value;
                    fetchData();
                  });
                },
              ),
            ),
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                    itemCount: listTechnicalRequests.length,
                    itemBuilder: (context, index) {
                      final item = listTechnicalRequests[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailChangeInfoScreen(
                                  id: item.id,
                                  title1: item.typeName,
                                  title2: item.text,
                                ),
                              ),
                            );
                            fetchData();
                            setState(() {});
                          },
                          child: _RequestCard(
                            model: item,
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  final ResidentPendingModel model;

  const _RequestCard({
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              model.typeName,
              style: defaultText14M.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.keyboard_arrow_right_outlined,
              color: Colors.black,
              size: 24.0,
            ),
          ],
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          margin: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: const Color(0xff282828).withValues(alpha: 0.06),
            ),
          ),
          child: Text(
            model.text,
            style: defaultText16Re.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}
