import 'package:ha_duong/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ha_duong/bql_model/home_model.dart';
import 'package:ha_duong/bql_repo/bql_home_repo.dart';
import 'package:ha_duong/modules/bql/apartment/detail_apartment.dart';
import 'package:ha_duong/modules/bql/bill/dien_nuoc_screen.dart';
import 'package:ha_duong/modules/bql/home/home.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ApartmentScreen extends StatefulWidget {
  const ApartmentScreen({super.key, required this.homeModel});
  final HomeModel homeModel;
  @override
  State<ApartmentScreen> createState() => _ApartmentScreenState();
}

class _ApartmentScreenState extends State<ApartmentScreen> {
  bool isFilterExpanded = false;

  final TextEditingController roomController = TextEditingController();
  //BuildingModel? selectedBuilding;
  StatusModel? selectedStatus;
  PostModel? selectedPurpose;

  List<BuildingModel> buildings = [];
  List<StatusModel> statuses = [];
  List<PostModel> purposes = [];
  List<ApartmentModel> apartments = [];
  List<ApartmentModel> filteredApartment = [];
  List<ApartmentModel> pagedList = [];
  int currentPage = 1;
  int itemsPerPage = 10;
  int totalPages = 1;
  final TextEditingController _searchController = TextEditingController();
  bool isLoading = false;
  void paginateData() {
    totalPages = (apartments.length / itemsPerPage).ceil();
    final start = (currentPage - 1) * itemsPerPage;
    final end = (start + itemsPerPage).clamp(0, apartments.length);
    pagedList = apartments.sublist(start, end);
  }

  @override
  void initState() {
    super.initState();
    buildings = widget.homeModel.listBuilding;
    //selectedBuilding = homeSelecteBuilding;
    getListApartment();
    getListStatus();
  }

  Future<void> getListStatus() async {
    if (homeSelecteBuilding != null) {
      try {
        final response = await HomeRepo().getListStatus();
        final response2 =
            await HomeRepo().getPurposeUse(homeSelecteBuilding?.id ?? '');
        setState(() {
          statuses = response;
          purposes = response2;
        });
      } catch (e) {
        debugPrint('Lỗi khi gọi API: $e');
      }
    }
  }

  Future<void> getListApartment() async {
    if (homeSelecteBuilding != null) {
      try {
        final response = await HomeRepo().getListApartment(
          page: 1,
          show: 1000,
          buildingId: int.tryParse(homeSelecteBuilding?.id ?? '') ?? 0,
          purposeUseId: int.tryParse(selectedPurpose?.id ?? ''),
          status: selectedStatus?.value,
        );
        setState(() {
          apartments = response;
          paginateData();
        });
      } catch (e) {
        debugPrint('Lỗi khi gọi API: $e');
      }
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
          AppLocalizations.of(context)!.bqlCanHo,
          style: defaultText18B.copyWith(color: Colors.white),
        )),
        backgroundColor: const Color(0xFF1CA0DD),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              // NỘI DUNG CUỘN ĐƯỢC
              Expanded(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // TOÀN BỘ PHẦN: bộ lọc, danh sách căn hộ
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 4)
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.filter_alt_outlined,
                                  color: Colors.grey),
                              const SizedBox(width: 8),
                              Text(
                                "Lọc tìm kiếm căn hộ",
                                style: defaultText16B,
                              ),
                              const Spacer(),
                              if (isFilterExpanded)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      roomController.clear();
                                      // homeSelecteBuilding = null;
                                      selectedStatus = null;
                                      selectedPurpose = null;
                                    });
                                  },
                                  child: const Text(
                                    "Xoá bộ lọc",
                                    style: TextStyle(color: Color(0xff25AAE1)),
                                  ),
                                ),
                              IconButton(
                                icon: Icon(
                                  isFilterExpanded
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isFilterExpanded = !isFilterExpanded;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        if (isFilterExpanded)
                          Container(
                            padding: const EdgeInsets.all(16),
                            color: Colors.white,
                            child: Column(
                              children: [
                                if (homeSelecteBuilding != null)
                                  Container(
                                    height: 48.h,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    margin:
                                        EdgeInsets.only(left: 0.w, right: 0.w),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF5F9FA),
                                      borderRadius: BorderRadius.circular(24.r),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.search,
                                            color: Colors.grey, size: 24.sp),
                                        SizedBox(width: 8.w),
                                        Expanded(
                                          child: TextField(
                                            controller: _searchController,
                                            style: TextStyle(fontSize: 14.sp),
                                            decoration: InputDecoration(
                                              hintText:
                                                  AppLocalizations.of(context)!
                                                      .bqlTimKiemTenCanHo,
                                              hintStyle: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14.sp),
                                              border: InputBorder.none,
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                final query =
                                                    value.trim().toLowerCase();
                                                if (query.isEmpty) {
                                                  filteredApartment = [];
                                                } else {
                                                  filteredApartment = apartments
                                                      .where((b) => b.name
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
                                                filteredApartment = [];
                                              });
                                            },
                                            child: Icon(Icons.close,
                                                size: 20.sp,
                                                color: Colors.grey),
                                          ),
                                      ],
                                    ),
                                  ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                // Dropdowns
                                _buildDropdown(
                                  value: homeSelecteBuilding?.name,
                                  hint: AppLocalizations.of(context)!
                                      .bqlChonToaNha,
                                  items: buildings.map((b) => b.name).toList(),
                                  onChanged: (val) {
                                    final matched = buildings.firstWhere(
                                      (b) => b.name == val,
                                      orElse: () => buildings.first,
                                    );
                                    setState(() {
                                      homeSelecteBuilding = matched;
                                      selectedStatus = null;
                                      selectedPurpose = null;
                                      getListStatus();
                                      getListApartment();
                                    });
                                  },
                                ),
                                const SizedBox(height: 12),
                                _buildDropdown(
                                  value: selectedStatus?.name,
                                  hint: AppLocalizations.of(context)!
                                      .bqlChonTrangThai,
                                  items: statuses.map((s) => s.name).toList(),
                                  onChanged: (val) {
                                    final matched = statuses.firstWhere(
                                      (b) => b.name == val,
                                      orElse: () => statuses.first,
                                    );
                                    setState(() {
                                      selectedStatus = matched;
                                      getListApartment();
                                    });
                                  },
                                ),
                                const SizedBox(height: 12),
                                _buildDropdown(
                                  value: selectedPurpose?.name,
                                  hint: 'Chọn mục đích sử dụng',
                                  items: purposes.map((p) => p.name).toList(),
                                  onChanged: (val) {
                                    final matched = purposes.firstWhere(
                                      (b) => b.name == val,
                                      orElse: () => purposes.first,
                                    );
                                    setState(() {
                                      selectedPurpose = matched;
                                      getListApartment();
                                    });
                                  },
                                ),
                                const SizedBox(height: 12),
                                IconButton(
                                  icon: Icon(
                                    isFilterExpanded
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isFilterExpanded = !isFilterExpanded;
                                    });
                                  },
                                ),
                                if (homeSelecteBuilding != null &&
                                    _searchController.text.isNotEmpty) ...[
                                  SizedBox(height: 16.h),
                                  isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : Container(
                                          height: 250.h,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 16.w),
                                          decoration: BoxDecoration(
                                            color: const Color(
                                                0xFFF2F7FB), // nền nhẹ
                                            border: Border.all(
                                                color: Colors.blueAccent
                                                    .withOpacity(0.3)),
                                            borderRadius:
                                                BorderRadius.circular(16.r),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 4,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: ListView.builder(
                                            // shrinkWrap: true,
                                            // physics:
                                            //     const NeverScrollableScrollPhysics(),
                                            itemCount: filteredApartment.length,
                                            itemBuilder: (context, index) {
                                              final b =
                                                  filteredApartment[index];
                                              return ListTile(
                                                leading: const Icon(
                                                    Icons.location_city),
                                                title: Text(b.name),
                                                onTap: () {
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
                              ],
                            ),
                          ),

                        const SizedBox(height: 8),
                        Stack(
                          children: [
                            pagedList.isEmpty
                                ? Center(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .bqlKhongCoCanHoNao,
                                      style: defaultText16M.copyWith(
                                          color: Colors.grey),
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: pagedList.length,
                                    itemBuilder: (context, index) {
                                      final item = pagedList[index];
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.h),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  item.isExpanded =
                                                      !item.isExpanded;
                                                });
                                              },
                                              child: ListTile(
                                                leading: SvgPicture.asset(
                                                  'assets/icons/apartment_icon.svg',
                                                  width: 28.w,
                                                  height: 28.h,
                                                ),
                                                title: Text(
                                                  'Căn hộ ${item.name}',
                                                  style: defaultText16M,
                                                ),
                                                trailing: IconButton(
                                                  icon: Icon(
                                                    item.isExpanded
                                                        ? Icons.remove_circle
                                                        : Icons.add_circle,
                                                    size: 24.dm,
                                                    color: item.isExpanded
                                                        ? Colors.green
                                                        : Colors.green,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      item.isExpanded =
                                                          !item.isExpanded;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (item.isExpanded)
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16.w,
                                                  vertical: 4.h),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFF2F7FB),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.r),
                                                ),
                                                padding: EdgeInsets.all(16.dm),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      item.name,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16.sp),
                                                    ),
                                                    Divider(
                                                      color:
                                                          Colors.grey.shade300,
                                                      thickness: 1,
                                                    ),
                                                    _buildDetailRow(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .bqlChuHo,
                                                        item.fullName),
                                                    _buildDetailRow(
                                                        "Số điện thoại",
                                                        item.phone,
                                                        isPhone: true,
                                                        context: context),
                                                    _buildDetailRow(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .bqlTang,
                                                        item.numberFloor
                                                            .toString()),
                                                    _buildDetailRow(
                                                        "Số người",
                                                        item.totalPeople
                                                            .toString()),
                                                    _buildDetailRow(
                                                        "Số phương tiện",
                                                        item.totalPhuongTien
                                                            .toString()),
                                                    _buildDetailRow(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .bqlTinhTrang,
                                                        item.apartmentStatus),
                                                    _buildDetailRow(
                                                        "Mục đích sử dụng",
                                                        item.purposes),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          // Điều hướng đến chi tiết
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (_) =>
                                                                  ApartmentInfoScreen(
                                                                id: int.tryParse(
                                                                        item.id) ??
                                                                    0,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              const Color(
                                                                  0xFF25AAE1),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.r),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .bqlChiTiet,
                                                          style: defaultText14M
                                                              .copyWith(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                            Container(color: Colors.black),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),

              // PHẦN PHÂN TRANG
              if (totalPages > 1)
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 6.h,
                    left: 16.w,
                    right: 16.w,
                  ),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.start, // tránh canh giữa bị thừa
                    children: [
                      // Nút "preview"
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
                            color: const Color(0xff25AAE1).withOpacity(0.16),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: const Color(0xff25AAE1).withOpacity(0.5),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/icons/preview.svg',
                              width: 10.dg,
                              height: 10.dg,
                            ),
                          ),
                        ),
                      ),
                      // Danh sách số trang
                      SizedBox(
                        width: 275.w,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...getVisiblePages(currentPage, totalPages)
                                  .map((page) {
                                final isSelected = currentPage == page;
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
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
                                            color: const Color(0xff25AAE1)
                                                .withOpacity(0.5),
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
                            ],
                          ),
                        ),
                      ),

                      // Nút "next"
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
                            color: const Color(0xff25AAE1).withOpacity(0.16),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: const Color(0xff25AAE1).withOpacity(0.5),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/icons/next.svg',
                              width: 10.dg,
                              height: 10.dg,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}

Widget _buildDropdown({
  required String? value,
  required String hint,
  required List<String> items,
  required ValueChanged<String?> onChanged,
}) {
  return DropdownButtonFormField<String>(
    value: value,
    decoration: InputDecoration(
      hintText: hint,
      //contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
    ),
    items: items
        .map((e) => DropdownMenuItem(
            value: e,
            child: Text(
              e,
              style: defaultText14M,
            )))
        .toList(),
    onChanged: onChanged,
  );
}

Widget _buildDetailRow(String title, String value,
    {bool isPhone = false, BuildContext? context}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(title)),
        SizedBox(
          width: 200.w,
          child: isPhone && context != null
              ? Row(
                  children: [
                    Expanded(
                      child: Text(
                        ': $value',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final Uri launchUri = Uri(
                          scheme: 'tel',
                          path: value,
                        );
                        try {
                          await launchUrl(launchUri);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Không thể gọi điện')),
                          );
                        }
                      },
                      child:
                          Icon(Icons.phone, size: 20.sp, color: Colors.green),
                    ),
                    SizedBox(width: 12.w),
                    InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: value));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Đã sao chép số điện thoại')),
                        );
                      },
                      child: Icon(Icons.copy, size: 20.sp, color: Colors.blue),
                    ),
                  ],
                )
              : Text(
                  ': $value',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
        ),
      ],
    ),
  );
}
