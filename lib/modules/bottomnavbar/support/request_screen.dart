import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/models/suport_model.dart';
import 'package:ha_duong/modules/bottomnavbar/support/request_status_screen.dart';
import 'package:ha_duong/repo/support_repo.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:ha_duong/l10n/app_localizations.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key, required this.id});
  final String id;
  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ListTechnicalSupportModel data;
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  String? selectedStatus = 'Tất cả';
  List<String> listStatus = ['Tất cả'];
  DateTime? selectedDate;
  Set<String> loadingIds = {};

  List<TechnicalSupportModel> get filteredListDangXuly {
    var list = data.listDangXuly;
    if (searchQuery.trim().isNotEmpty) {
      list = list
          .where((e) => e.settingSupportName
              .toLowerCase()
              .contains(searchQuery.trim().toLowerCase()))
          .toList();
    }
    if (selectedStatus != null && selectedStatus != 'Tất cả') {
      list = list.where((e) => e.latestStatusName == selectedStatus).toList();
    }
    if (selectedDate != null) {
      String formattedDate1 =
          "${selectedDate!.day.toString().padLeft(2, '0')}/${selectedDate!.month.toString().padLeft(2, '0')}/${selectedDate!.year}";
      String formattedDate2 =
          "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}";
      list = list
          .where((e) =>
              e.createAt.contains(formattedDate1) ||
              e.createAt.contains(formattedDate2))
          .toList();
    }
    return list;
  }

  List<TechnicalSupportModel> get filteredListHoanTat {
    var list = data.listHoanTat;
    if (searchQuery.trim().isNotEmpty) {
      list = list
          .where((e) => e.settingSupportName
              .toLowerCase()
              .contains(searchQuery.trim().toLowerCase()))
          .toList();
    }
    if (selectedStatus != null && selectedStatus != 'Tất cả') {
      list = list.where((e) => e.latestStatusName == selectedStatus).toList();
    }
    if (selectedDate != null) {
      String formattedDate1 =
          "${selectedDate!.day.toString().padLeft(2, '0')}/${selectedDate!.month.toString().padLeft(2, '0')}/${selectedDate!.year}";
      String formattedDate2 =
          "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}";
      list = list
          .where((e) =>
              e.createAt.contains(formattedDate1) ||
              e.createAt.contains(formattedDate2))
          .toList();
    }
    return list;
  }

  @override
  void initState() {
    super.initState();
    fetchData(widget.id);
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> fetchData(String id) async {
    try {
      final response = await SupportRepo().getListSupport(id);
      setState(() {
        data = response;
        listStatus = ['Tất cả'];
        for (var item in data.listDangXuly) {
          if (item.latestStatusName != null &&
              !listStatus.contains(item.latestStatusName)) {
            listStatus.add(item.latestStatusName!);
          }
        }
        for (var item in data.listHoanTat) {
          if (item.latestStatusName != null &&
              !listStatus.contains(item.latestStatusName)) {
            listStatus.add(item.latestStatusName!);
          }
        }
        if (!listStatus.contains(selectedStatus)) {
          selectedStatus = 'Tất cả';
        }
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
  void dispose() {
    searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD9D9D9),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.request),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xff0F2645), // Màu chữ tab khi được chọn
          unselectedLabelColor: Colors.grey, // Màu chữ tab không được chọn
          indicatorColor:
              const Color(0xff0F2645), // Màu gạch dưới khi được chọn
          indicatorWeight: 2.0,
          tabs: [
            Tab(text: AppLocalizations.of(context)!.processing),
            Tab(text: AppLocalizations.of(context)!.completed),
          ],
        ),
      ),
      body: (isLoading)
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  color: Colors.white,
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "Tìm kiếm theo tên yêu cầu...",
                      hintStyle: defaultText14M,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: const Color(0xff00A1E4)),
                      ),
                      prefixIcon:
                          Icon(Icons.search, size: 20.sp, color: Colors.grey),
                    ),
                    style: defaultText14M,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40.h,
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8.r),
                            color: Colors.white,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: selectedStatus,
                              icon:
                                  Icon(Icons.keyboard_arrow_down, size: 16.sp),
                              items: listStatus.map((s) {
                                return DropdownMenuItem(
                                  value: s,
                                  child: Text(s,
                                      style: defaultText14M,
                                      overflow: TextOverflow.ellipsis),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedStatus = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: selectedDate ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (picked != null && picked != selectedDate) {
                              setState(() {
                                selectedDate = picked;
                              });
                            }
                          },
                          child: Container(
                            height: 40.h,
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8.r),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today,
                                    size: 16.sp, color: Colors.grey),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    selectedDate == null
                                        ? "Chọn ngày"
                                        : "${selectedDate!.day.toString().padLeft(2, '0')}/${selectedDate!.month.toString().padLeft(2, '0')}/${selectedDate!.year}",
                                    style: defaultText14M,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (selectedDate != null)
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedDate = null;
                                      });
                                    },
                                    child: Icon(Icons.close,
                                        size: 16.sp, color: Colors.grey),
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Center(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await fetchData(widget.id);
                          },
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: filteredListDangXuly.length,
                            itemBuilder: (context, index) {
                              return _buildRequestCard(
                                  model: filteredListDangXuly[index]);
                            },
                          ),
                        ),
                      ),
                      filteredListHoanTat.isEmpty
                          ? Center(
                              child: Text(AppLocalizations.of(context)!
                                  .noCompletedRequests))
                          : RefreshIndicator(
                              onRefresh: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                await fetchData(widget.id);
                              },
                              child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: filteredListHoanTat.length,
                                itemBuilder: (context, index) {
                                  return _buildRequestCard(
                                      model: filteredListHoanTat[index]);
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildRequestCard({
    required TechnicalSupportModel model,
  }) {
    return GestureDetector(
      onTap: () async {
        if (loadingIds.contains(model.id)) return;
        setState(() {
          loadingIds.add(model.id);
        });
        try {
          DetailTechnicalRequestModel detailRequest =
              await SupportRepo().getRequestStatus(model.id);
          if (!mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => RequestStatusScreen(
                    requestStatus: detailRequest.listRequestStatus,
                    createAt: model.createAt,
                    technicalSupportModel: model,
                  )),
            ),
          );
        } finally {
          if (mounted) {
            setState(() {
              loadingIds.remove(model.id);
            });
          }
        }
      },
      child: Container(
        width: 343.w,
        height: 198.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        margin: EdgeInsets.only(top: 16.h, right: 16.w, left: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        //height: index == 0 ? 76.h : 60.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Text('Yêu cầu ${model.settingSupportName}',
                    style: defaultText14M),
                const Spacer(),
                Text(model.createAt,
                    style: defaultText14Re.copyWith(
                      color: const Color.fromARGB(255, 58, 58, 58),
                    )),
              ],
            ),
            const Divider(
              color: Color(0xffD9D9D9),
              thickness: 1,
            ),
            Text(AppLocalizations.of(context)!.statusShort,
                style: defaultText14M.copyWith(color: const Color(0xff8A8A8A))),
            Text(
              model.settingSupportStateName,
              style: defaultText14M,
            ),
            const Divider(
              color: Color(0xffD9D9D9),
              thickness: 1,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!.txtTrangThai1,
                        style: defaultText14M.copyWith(
                            color: const Color(0xff8A8A8A))),
                    SizedBox(
                      height: 4.h,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        // common color
                        color: model.latestStatusType == null
                            ? const Color(0xff8A8A8A).withValues(alpha: 0.08)
                            : model.latestStatusType == '0'
                                ? const Color(0xff004071)
                                    .withValues(alpha: 0.08)
                                : model.latestStatusType == '1'
                                    ? const Color(0xff129F20)
                                        .withValues(alpha: 0.08)
                                    : const Color(0xffE80707)
                                        .withValues(alpha: 0.08),

                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                          model.latestStatusName ??
                              AppLocalizations.of(context)!.unprocessed,
                          style: defaultText14M.copyWith(
                            color: model.latestStatusType == null
                                ? const Color(0xff8A8A8A)
                                : model.latestStatusType == '0'
                                    ? const Color(0xff004071)
                                    : model.latestStatusType == '1'
                                        ? const Color(0xff129F20)
                                        : const Color(0xffE80707),
                          )),
                    ),
                    // Container(
                    //   // width: 20.w,
                    //   // height: 20.h,
                    //   padding:
                    //       EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    //   decoration: BoxDecoration(
                    //     // common color
                    //     color: const Color(0xff005DA4),

                    //     borderRadius: BorderRadius.circular(6.r),
                    //   ),
                    //   child: Text(
                    //       model.latestStatusName ??
                    //           model.settingSupportStateName,
                    //       style: defaultText14M.copyWith(
                    //         color: Colors.white,
                    //       )),
                    // ),
                  ],
                ),
                const Spacer(),
                loadingIds.contains(model.id)
                    ? SizedBox(
                        width: 16.w,
                        height: 16.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xff00A1E4),
                        ),
                      )
                    : Icon(
                        Icons.arrow_forward_ios,
                        color: const Color(0xff383838),
                        size: 16.w,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
