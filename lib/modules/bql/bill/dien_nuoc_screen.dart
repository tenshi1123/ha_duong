import 'package:ha_duong/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ha_duong/bql_model/home_model.dart';
import 'package:ha_duong/bql_repo/bql_home_repo.dart';
import 'package:ha_duong/modules/bql/home/home.dart';
import 'package:ha_duong/utils/constants/string.dart';
import 'package:ha_duong/utils/constants/styles.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({super.key, required this.listBuild});
  final List<BuildingModel> listBuild;
  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  bool isFilterExpanded = false;

  final TextEditingController roomController = TextEditingController();
  List<BuildingModel> buildings = [];
  List<BuildingModel> listMonth = [];
  List<ReceiptsModel> dichVuList = [];
  //BuildingModel? selectedBuilding;
  BuildingModel? selectMonth;
  final TextEditingController _searchController = TextEditingController();
  List<ReceiptsModel> filtereddichVuList = [];
  List<ReceiptsModel> pagedList = [];
  bool isLoading = false;
  int currentPage = 1;
  int itemsPerPage = 10;
  int totalPages = 1;

  void paginateData() {
    totalPages = (dichVuList.length / itemsPerPage).ceil();

    final start = (currentPage - 1) * itemsPerPage;
    final end = (start + itemsPerPage).clamp(0, dichVuList.length);

    pagedList = dichVuList.sublist(start, end);
  }

  @override
  void initState() {
    super.initState();
    buildings = widget.listBuild;
    //selectedBuilding = homeSelecteBuilding;
    getListMonth();
  }

  Future<void> getListMonth() async {
    if (homeSelecteBuilding != null) {
      try {
        final response = await HomeRepo()
            .getListBuilding(buildingId: homeSelecteBuilding!.id);
        setState(() {
          listMonth = response;
        });
      } catch (e) {
        debugPrint('Lỗi khi gọi API: $e');
      }
    }
  }

  Future<void> fetchData() async {
    if (selectMonth == null) {
      return;
    }
    try {
      final response = await HomeRepo().getPageDienNuoc(
        page: 1,
        show: 500,
        buildingId: int.tryParse(homeSelecteBuilding?.id ?? '') ?? 0,
        receiptId: int.tryParse(selectMonth?.id ?? '') ?? 0,
      );
      setState(() {
        filtereddichVuList = dichVuList = response.listReceipts;
        paginateData();
        isLoading = false;
      });
    } catch (e) {
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
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Chỉ số điện/nước',
            style: defaultText18B.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: const Color(0xFF1CA0DD),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            //height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            margin: EdgeInsets.only(
                left: 16.w, right: 16.w, bottom: 16.h, top: 16.h),
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
                  AppLocalizations.of(context)!.bqlChonToaNha,
                  style: defaultText14M,
                ),
                items: buildings.map((b) {
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
                    //filtereddichVuList = dichVuList = [];
                    selectMonth = null;
                    listMonth = [];
                    getListMonth();
                  });
                },
              ),
            ),
          ),
          homeSelecteBuilding != null
              ? Container(
                  height: 50.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  margin: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    bottom: 16.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color(0xff00A1E4), width: 1.5.w),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<BuildingModel>(
                      isExpanded: true,
                      value: selectMonth,
                      icon: Icon(Icons.keyboard_arrow_down, size: 20.sp),
                      hint: Text(
                        AppLocalizations.of(context)!.bqlChonThang,
                        style: defaultText14M,
                      ),
                      items: listMonth.map((b) {
                        return DropdownMenuItem(
                          value: b,
                          child: Text(
                            b.time,
                            style: defaultText14M,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectMonth =
                              listMonth.firstWhere((e) => e.id == value?.id);
                          isLoading = true;
                          currentPage = 1;
                        });
                        fetchData();
                      },
                    ),
                  ),
                )
              : const SizedBox(),
          if (selectMonth != null)
            Container(
              height: 48.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              margin: EdgeInsets.only(left: 16.w, right: 16.w),
              decoration: BoxDecoration(
                color: const Color(0xffF5F9FA),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey, size: 24.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: TextStyle(fontSize: 14.sp),
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.bqlTimKiemTenCanHo,
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 14.sp),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          final query = value.trim().toLowerCase();
                          if (query.isEmpty) {
                            filtereddichVuList = [];
                          } else {
                            filtereddichVuList = dichVuList
                                .where((b) => b.apartmentName
                                    .toLowerCase()
                                    .contains(query))
                                .toList();
                          }
                        });
                      },
                    ),
                  ),
                  if (_searchController.text.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        _searchController.clear();
                        setState(() {
                          filtereddichVuList = [];
                        });
                      },
                      child: Icon(Icons.close, size: 20.sp, color: Colors.grey),
                    ),
                ],
              ),
            ),
          if (selectMonth != null && _searchController.text.isNotEmpty) ...[
            SizedBox(height: 16.h),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Container(
                    height: 300.h,
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F7FB), // nền nhẹ
                      border:
                          Border.all(color: Colors.blueAccent.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      itemCount: filtereddichVuList.length,
                      itemBuilder: (context, index) {
                        final b = filtereddichVuList[index];
                        return ListTile(
                          leading: const Icon(Icons.location_city),
                          title: Text(b.apartmentName),
                          onTap: () {
                            print("Chọn: ${b.apartmentName}");
                            // Clear sau khi chọn
                            _searchController.clear();
                            setState(() {
                              pagedList = [b];
                            });
                          },
                        );
                      },
                    ),
                  ),
          ],
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    itemCount: pagedList.length,
                    itemBuilder: (context, index) {
                      final item = pagedList[index];
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                item.isExpanded = !item.isExpanded;
                              });
                            },
                            child: ListTile(
                              leading: SvgPicture.asset(
                                  'assets/icons/electric_water_icon.svg'),
                              title: Text("Căn hộ ${item.apartmentName}"),
                              trailing: IconButton(
                                icon: Icon(
                                  item.isExpanded
                                      ? Icons.remove_circle
                                      : Icons.add_circle,
                                  color: item.isExpanded
                                      ? Colors.green
                                      : Colors.green,
                                ),
                                onPressed: () {
                                  setState(() {
                                    item.isExpanded = !item.isExpanded;
                                  });
                                },
                              ),
                            ),
                          ),
                          if (item.isExpanded)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 4),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF2F7FB),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w, vertical: 8.h),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.bqlTenCanHo,
                                            style: defaultText14M.copyWith(
                                                color: const Color(0xff8A8A8A)),
                                          ),
                                          SizedBox(
                                            width: 311.w,
                                            child: Text(
                                              item.apartmentName,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 16.h),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w, vertical: 8.h),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                      ),
                                      child: Column(
                                        children: [
                                          _buildDetailRow(
                                              "Số điện",
                                              "KWh",
                                              defaultText14M.copyWith(
                                                  color:
                                                      const Color(0xff8A8A8A)),
                                              defaultText14M.copyWith(
                                                  color:
                                                      const Color(0xff8A8A8A))),
                                          _buildDetailRow(
                                              "Số điện sử dụng",
                                              formatVnIntString(
                                                  item.dienTieuThu),
                                              defaultText16B,
                                              defaultText16B.copyWith(
                                                  color: Colors.lightBlue)),
                                          _buildDetailRow(
                                              "Số điện đầu kì",
                                              formatVnIntString(
                                                  item.dienCsc.toString()),
                                              defaultText16B,
                                              defaultText16B),
                                          _buildDetailRow(
                                              "Số điện cuối kì",
                                              formatVnIntString(
                                                  item.dienCsm.toString()),
                                              defaultText16B,
                                              defaultText16B),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 16.h),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w, vertical: 8.h),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                      ),
                                      child: Column(
                                        children: [
                                          _buildDetailRow(
                                              "Số nước",
                                              "m3",
                                              defaultText14M.copyWith(
                                                  color:
                                                      const Color(0xff8A8A8A)),
                                              defaultText14M.copyWith(
                                                  color:
                                                      const Color(0xff8A8A8A))),
                                          _buildDetailRow(
                                              "Số nước sử dụng",
                                              formatVnIntString(
                                                  item.nuocTieuThu),
                                              defaultText16B,
                                              defaultText16B.copyWith(
                                                  color: Colors.lightBlue)),
                                          _buildDetailRow(
                                              "Số nước đầu kì",
                                              formatVnIntString(item.nuocCsc),
                                              defaultText16B,
                                              defaultText16B),
                                          _buildDetailRow(
                                              "Số nước cuối kì",
                                              formatVnIntString(item.nuocCsm),
                                              defaultText16B,
                                              defaultText16B),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                ),
                              ),
                            ),
                          // Divider giữa các mục
                          Divider(
                            height: 1,
                            endIndent: 16.w,
                            indent: 16.w,
                            color: const Color(0xFFE0E0E0),
                          ),
                        ],
                      );
                    },
                  ),
                ),
          if (totalPages > 1)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 1),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: currentPage > 1
                          ? () {
                              setState(() {
                                currentPage--;
                                paginateData();
                              });
                            }
                          : null,
                      child: Container(
                        height: 32.h,
                        width: 32.h,
                        decoration: BoxDecoration(
                          color:
                              const Color(0xff25AAE1).withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color:
                                const Color(0xff25AAE1).withValues(alpha: 0.5),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/preview.svg',
                            width: 10.h,
                            height: 10.h,
                          ),
                        ),
                      ),
                    ),
                    ...getVisiblePages(currentPage, totalPages).map((page) {
                      final isSelected = currentPage == page;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              currentPage = page;
                              paginateData();
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              height: 32.h,
                              width: 32.h,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.lightBlue
                                    : Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color:
                                      const Color(0xff25AAE1).withOpacity(0.5),
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '$page',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.lightBlue,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    GestureDetector(
                      onTap: currentPage < totalPages
                          ? () {
                              setState(() {
                                currentPage++;
                                paginateData();
                              });
                            }
                          : null,
                      child: Container(
                        height: 32.h,
                        width: 32.h,
                        decoration: BoxDecoration(
                          color:
                              const Color(0xff25AAE1).withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color:
                                const Color(0xff25AAE1).withValues(alpha: 0.5),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/next.svg',
                            width: 10.h,
                            height: 10.h,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}

Widget _buildDetailRow(
    String title, String value, TextStyle style1, TextStyle style2) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Expanded(child: Text(title, style: style1)),
        Text(value, style: style2),
      ],
    ),
  );
}

List<int> getVisiblePages(int currentPage, int totalPages) {
  return List.generate(totalPages, (index) => index + 1);
}
