import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/app.dart';
import 'package:ha_duong/bql_model/home_model.dart';
import 'package:ha_duong/bql_repo/bql_home_repo.dart';
import 'package:ha_duong/modules/bql/home/home.dart';
import 'package:ha_duong/utils/constants/styles.dart';

class ListExtensionScreen extends StatefulWidget {
  const ListExtensionScreen(
      {super.key, required this.type, required this.listBuild});
  final int type;
  final List<BuildingModel> listBuild;
  @override
  State<ListExtensionScreen> createState() => _ListExtensionScreenState();
}

class _ListExtensionScreenState extends State<ListExtensionScreen>
    with RouteAware {
  int currentPage = 1;
  bool isLoading = true;
  late List<ExtensionModel> listExtension;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    try {
      final response = await HomeRepo()
          .getListTechnicalRequests(buildingId: homeSelecteBuilding?.id ?? '0');
      setState(() {
        listExtension = response;
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
        title: const Text("Danh sách đăng ký tiện ích"),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: widget.type == 1
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : null,
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
                    itemCount: listExtension.length,
                    itemBuilder: (context, index) {
                      //final reversedIndex = listExtension.length - 1 - index;
                      final item = listExtension[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _RequestCard(
                          model: item,
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
  final ExtensionModel model;

  const _RequestCard({
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //height: 175.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      // margin: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xff282828).withValues(alpha: 0.06),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 60.w,
                child: Text(
                  'Dịch vụ',
                  style: defaultText14M.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  ': ${model.buildingUtilitiesName}',
                  style: defaultText14M.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 60.w,
                child: Text(
                  'Căn hộ',
                  style: defaultText14M.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  ': ${model.apartmentName}',
                  style: defaultText14M.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 60.w,
                child: Text(
                  'Họ tên',
                  style: defaultText14M.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  ': ${model.fullName}',
                  style: defaultText14M.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 60.w,
                child: Text(
                  'SDT',
                  style: defaultText14M.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  ': ${model.phone}',
                  style: defaultText14M.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thời gian',
                style: defaultText14M.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  ': ${model.createAt}',
                  style: defaultText14M.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 60.w,
                child: Text(
                  'Note',
                  style: defaultText14M.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  ': ${model.note}',
                  style: defaultText14M.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
