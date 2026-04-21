import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/bql_model/home_model.dart';
import 'package:ha_duong/bql_model/technical_requests_model.dart';
import 'package:ha_duong/bql_repo/technical_requests_repo.dart';
import 'package:ha_duong/modules/bql/home/home.dart';
import 'package:ha_duong/modules/bql/home/yeucau_hotro/request_detail_screen.dart';
import 'package:ha_duong/utils/constants/styles.dart';

class SupportRequestPage extends StatefulWidget {
  const SupportRequestPage(
      {super.key, required this.type, required this.listBuild});
  final int type;
  final List<BuildingModel> listBuild;
  @override
  State<SupportRequestPage> createState() => _SupportRequestPageState();
}

class _SupportRequestPageState extends State<SupportRequestPage> {
  int currentPage = 1;
  bool isLoading = true;
  late List<TechnicalSupportModel> listTechnicalRequests;
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    try {
      // Gọi API ở đây - thay thế bằng logic thật của bạn
      final response = await TechnicalRequestsRepo()
          .getListTechnicalRequests(buildingId: homeSelecteBuilding?.id ?? '0');

      // Cập nhật state sau khi có dữ liệu
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Danh sách yêu cầu hỗ trợ"),
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
      body: RefreshIndicator(
        onRefresh: () async {
          fetchData();
          setState(() {});
        },
        child: Column(
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
                border:
                    Border.all(color: const Color(0xff00A1E4), width: 1.5.w),
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 16.h),
                      itemCount: listTechnicalRequests.length,
                      itemBuilder: (context, index) {
                        final item = listTechnicalRequests[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _RequestCard(
                            model: item,
                          ),
                        );
                      },
                    ),
                  ),
            // _PaginationFooter(
            //   currentPage: currentPage,
            //   onPageChanged: (newPage) {
            //     setState(() {
            //       currentPage = newPage;
            //       // TODO: load lại dữ liệu nếu cần
            //     });
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  final TechnicalSupportModel model;

  const _RequestCard({
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RequestDetailScreen(
              id: model.id,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Yêu cầu ${model.settingSupportName}',
                style: defaultText16B,
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: model.lastestStatusType == ''
                      ? const Color(0xff8A8A8A).withValues(alpha: 0.08)
                      : model.lastestStatusType == '0'
                          ? const Color(0xff004071).withValues(alpha: 0.08)
                          : model.lastestStatusType == '1'
                              ? const Color(0xff129F20).withValues(alpha: 0.08)
                              : const Color(0xffE80707).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(model.lastestStatusName,
                    style: defaultText14M.copyWith(
                      color: model.lastestStatusType == ''
                          ? const Color(0xff8A8A8A)
                          : model.lastestStatusType == '0'
                              ? const Color(0xff004071)
                              : model.lastestStatusType == '1'
                                  ? const Color(0xff129F20)
                                  : const Color(0xffE80707),
                    )),
              ),
            ],
          ),
          const SizedBox(height: 4),
          model.note != ''
              ? Text(
                  model.note,
                  style: defaultText14M,
                )
              : const SizedBox(),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: 'Tình trạng : ',
                    style: defaultText14M.copyWith(
                      color: const Color(0xff8A8A8A).withValues(alpha: 0.8),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: model.settingSupportStateName,
                        style: defaultText14B,
                      ),
                    ],
                  ),
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xff282828).withValues(alpha: 0.06),
              ),
            ),
            child: Text(
              'Căn hộ ${model.apartmentName} - tòa ${model.buildingName}',
              style: defaultText14M,
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}
