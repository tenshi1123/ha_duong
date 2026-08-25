import 'package:ha_duong/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ha_duong/bql_model/apartment_model.dart';
import 'package:ha_duong/bql_model/info_model_bql.dart';
import 'package:ha_duong/bql_repo/apartment_repo.dart';
import 'package:ha_duong/modules/bql/apartment/detail_bill_screen.dart';
import 'package:ha_duong/utils/constants/string.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class ApartmentInfoScreen extends StatefulWidget {
  const ApartmentInfoScreen({super.key, required this.id});
  final int id;
  @override
  State<ApartmentInfoScreen> createState() => _ApartmentInfoScreenState();
}

class _ApartmentInfoScreenState extends State<ApartmentInfoScreen> {
  bool showMenu = false;
  int _selectedMenuIndex = 0;

  List<_MenuItem> get menuItems => [
    _MenuItem('assets/icons/warehouse.svg', AppLocalizations.of(context)!.bqlCanHo, true),
    _MenuItem('assets/icons/user5.svg', AppLocalizations.of(context)!.bqlCuDan, false),
    _MenuItem('assets/icons/sports_car.svg', AppLocalizations.of(context)!.bqlPhuongTien, false),
    _MenuItem('assets/icons/allocation.svg', AppLocalizations.of(context)!.bqlPhiDichVu, false),
    _MenuItem('assets/icons/notification.svg', AppLocalizations.of(context)!.bqlSms, false),
    _MenuItem('assets/icons/receipt.svg', AppLocalizations.of(context)!.bqlBienLai, false),
  ];

  List<_InfoItem> get infoItems => [
    _InfoItem(AppLocalizations.of(context)!.bqlTenCanHo, AppLocalizations.of(context)!.bql2h601),
    _InfoItem(AppLocalizations.of(context)!.bqlTang, AppLocalizations.of(context)!.bqlTang6),
    _InfoItem('Diện tích (m2)', '82,35'),
    _InfoItem(AppLocalizations.of(context)!.bqlTinhTrang, AppLocalizations.of(context)!.bqlDangO),
    _InfoItem('Mục đích sử dụng', AppLocalizations.of(context)!.bqlHoDan),
  ];
  ApartmentDetailModel? apartmentDetail;
  List<CudanModel> listCudan = [];
  List<PhuongTienModel> listPhuongtien = [];
  List<PhiDichVuModel> listPhiDichVu = [];
  List<SmsModel> listSms = [];
  List<BienLaiModel> listBienlai = [];
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    apartmentDetail = await ApartmentRepo()
        .getDetailApartment<ApartmentDetailModel>(widget.id, 0);
    listCudan = (await ApartmentRepo()
        .getDetailApartment<List<CudanModel>>(widget.id, 1))!;
    listPhuongtien = (await ApartmentRepo()
        .getDetailApartment<List<PhuongTienModel>>(widget.id, 2))!;
    listPhiDichVu = (await ApartmentRepo()
        .getDetailApartment<List<PhiDichVuModel>>(widget.id, 3))!;
    listSms = (await ApartmentRepo()
        .getDetailApartment<List<SmsModel>>(widget.id, 4))!;
    listBienlai = (await ApartmentRepo()
        .getDetailApartment<List<BienLaiModel>>(widget.id, 5))!;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          showMenu ? const Color.fromARGB(255, 131, 131, 131) : Colors.white,
      appBar: AppBar(
        title: Text(
          'Thông tin ${menuItems[_selectedMenuIndex].title}',
          style: defaultBoldText.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        leading: const BackButton(color: Colors.white),
        actions: [
          IconButton(
            icon:
                Icon(showMenu ? Icons.close : Icons.menu, color: Colors.white),
            onPressed: () => setState(() {
              // if (showMenu) getdata();
              showMenu = !showMenu;
            }),
          ),
        ],
      ),
      body: Stack(
        children: [
          if (showMenu)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showMenu = false;
                  });
                },
                child: Container(
                  color: Colors.transparent, // Quan trọng để bắt sự kiện tap
                ),
              ),
            ),
          Column(
            children: [
              if (_isLoading) const Center(child: CircularProgressIndicator()),
              if (showMenu) _buildMenu(),
              if (!showMenu &&
                  _selectedMenuIndex == 0 &&
                  apartmentDetail != null)
                _HomeWidget(
                  model: apartmentDetail,
                ),
              if (!showMenu && _selectedMenuIndex == 1)
                _CudanWidget(
                  listCudan: listCudan,
                ),
              if (!showMenu && _selectedMenuIndex == 2)
                _PhuongTienWidget(
                  listPhuongtien: listPhuongtien,
                ),
              if (!showMenu && _selectedMenuIndex == 3)
                _PhiDichVuWidget(
                  listPhiDichVu: listPhiDichVu,
                ),
              if (!showMenu && _selectedMenuIndex == 4)
                _ListSmsWidget(
                  listSms: listSms,
                ),
              if (!showMenu && _selectedMenuIndex == 5)
                _ListBienlaiWidget(
                  listBienlai: listBienlai,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenu() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: menuItems.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 147.w / 80.h,
        ),
        itemBuilder: (_, index) {
          final item = menuItems[index];
          final isSelected = _selectedMenuIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedMenuIndex = index;
              });
            },
            child: Container(
              width: 147.w,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: isSelected ? Colors.lightBlue : const Color(0xffF6FAFB),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    item.icon,
                    color: isSelected ? Colors.white : Colors.lightBlue,
                    width: 24.w,
                    height: 24.h,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    item.title,
                    textAlign: TextAlign.center,
                    style: defaultText14B.copyWith(
                      color: isSelected
                          ? Colors.white
                          : const Color(0xff282828).withValues(
                              alpha: 0.6,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MenuItem {
  final String icon;
  final String title;
  final bool isSelected;

  _MenuItem(this.icon, this.title, this.isSelected);
}

class _InfoItem {
  final String label;
  final String value;

  _InfoItem(this.label, this.value);
}

class _HomeWidget extends StatelessWidget {
  const _HomeWidget({required this.model});
  final ApartmentDetailModel? model;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          // co dãn
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: 164.w,
                    margin: EdgeInsets.only(top: 16.h, right: 8.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.bqlTenCanHo,
                            style: defaultText14B.copyWith(color: Colors.grey)),
                        SizedBox(height: 4.h),
                        Text(
                          model?.name ?? '',
                          style: defaultBoldText,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 164.w,
                    margin: EdgeInsets.only(top: 16.h, left: 8.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.bqlTang,
                            style: defaultText14B.copyWith(color: Colors.grey)),
                        SizedBox(height: 4.h),
                        Text(model?.numberFloor ?? '', style: defaultBoldText),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 164.w,
              margin: EdgeInsets.only(top: 16.h),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Diện tích (m2)',
                      style: defaultText14B.copyWith(color: Colors.grey)),
                  SizedBox(height: 4.h),
                  Text(
                    model?.acreage ?? '',
                    style: defaultBoldText,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            Container(
              width: 164.w,
              margin: EdgeInsets.only(top: 16.h),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.bqlTinhTrang,
                      style: defaultText14B.copyWith(color: Colors.grey)),
                  SizedBox(height: 4.h),
                  Text(model?.apartmentStatus ?? '', style: defaultBoldText),
                ],
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
              width: 164.w,
              margin: EdgeInsets.only(top: 16.h, left: 16.w),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mục đích sử dụng',
                      style: defaultText14B.copyWith(color: Colors.grey)),
                  SizedBox(height: 4.h),
                  Text(
                    model?.purposeUseName ?? '',
                    style: defaultBoldText,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _CudanWidget extends StatelessWidget {
  const _CudanWidget({required this.listCudan});
  final List<CudanModel> listCudan;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: listCudan.length,
        itemBuilder: (_, index) {
          final item = listCudan[index];
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 343.w,
                    margin: EdgeInsets.only(top: 16.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.bqlHoTen,
                            style: defaultText14B.copyWith(color: Colors.grey)),
                        SizedBox(height: 4.h),
                        Text(
                          item.fullName,
                          style: defaultBoldText,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 343.w,
                    margin: EdgeInsets.only(top: 16.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.bqlEmail,
                            style: defaultText14B.copyWith(color: Colors.grey)),
                        SizedBox(height: 4.h),
                        Text(
                          item.email,
                          style: defaultBoldText,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 164.w,
                    margin: EdgeInsets.only(top: 16.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Số điện thoại',
                            style: defaultText14B.copyWith(color: Colors.grey)),
                        SizedBox(height: 4.h),
                        Text(
                          item.phone,
                          style: defaultBoldText,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 164.w,
                    margin: EdgeInsets.only(top: 16.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.bqlNgaySinh,
                            style: defaultText14B.copyWith(color: Colors.grey)),
                        SizedBox(height: 4.h),
                        Text(item.dob, style: defaultBoldText),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 164.w,
                    margin: EdgeInsets.only(top: 16.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.bqlCccd,
                            style: defaultText14B.copyWith(color: Colors.grey)),
                        SizedBox(height: 4.h),
                        Text(
                          item.cccd,
                          style: defaultBoldText,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 164.w,
                    margin: EdgeInsets.only(top: 16.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.bqlQuanHe,
                            style: defaultText14B.copyWith(color: Colors.grey)),
                        SizedBox(height: 4.h),
                        Text(item.relaName, style: defaultBoldText),
                      ],
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PhuongTienWidget extends StatelessWidget {
  const _PhuongTienWidget({required this.listPhuongtien});
  final List<PhuongTienModel> listPhuongtien;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: listPhuongtien.isEmpty
          ? Center(
              child: Text(
                AppLocalizations.of(context)!.bqlKhongCoPhuongTienNao,
                style: defaultText14M,
              ),
            )
          : ListView.separated(
              //padding: EdgeInsets.all(16.w),
              itemCount: listPhuongtien.length,
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
                thickness: 6.h,
              ),
              itemBuilder: (_, index) {
                final item = listPhuongtien[index];
                return Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 16.w,
                        ),
                        SvgPicture.asset('assets/icons/done.svg'),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text('Phương tiện ${index + 1}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 343.w,
                          margin: EdgeInsets.only(top: 16.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppLocalizations.of(context)!.bqlChuSoHuu,
                                  style: defaultText14B.copyWith(
                                      color: Colors.grey)),
                              SizedBox(height: 4.h),
                              Text(
                                item.fullName,
                                style: defaultBoldText,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 164.w,
                            margin: EdgeInsets.only(top: 16.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Số điện thoại)',
                                    style: defaultText14B.copyWith(
                                        color: Colors.grey)),
                                SizedBox(height: 4.h),
                                Text(
                                  item.phone,
                                  style: defaultBoldText,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 164.w,
                            margin: EdgeInsets.only(top: 16.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppLocalizations.of(context)!.bqlTenPhuongTien,
                                    style: defaultText14B.copyWith(
                                        color: Colors.grey)),
                                SizedBox(height: 4.h),
                                Text(item.vehicleName, style: defaultBoldText),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 343.w,
                          margin: EdgeInsets.only(top: 16.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppLocalizations.of(context)!.bqlBienSoXe,
                                  style: defaultText14B.copyWith(
                                      color: Colors.grey)),
                              SizedBox(height: 4.h),
                              Text(
                                item.licensePlates,
                                style: defaultBoldText,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 343.w,
                          margin: EdgeInsets.only(top: 16.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppLocalizations.of(context)!.bqlPhiGuiXe,
                                  style: defaultText14B.copyWith(
                                      color: Colors.grey)),
                              SizedBox(height: 4.h),
                              Text(
                                '${formatVnIntString(item.price)} VNĐ',
                                style: defaultBoldText,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    )
                  ],
                );
              },
            ),
    );
  }
}

class _PhiDichVuWidget extends StatefulWidget {
  const _PhiDichVuWidget({required this.listPhiDichVu});
  final List<PhiDichVuModel> listPhiDichVu;

  @override
  State<_PhiDichVuWidget> createState() => _PhiDichVuWidgetState();
}

class _PhiDichVuWidgetState extends State<_PhiDichVuWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.listPhiDichVu.isEmpty
        ? Center(
            child: Text(
            AppLocalizations.of(context)!.bqlKhongCoPhiDichVuNao,
            style: defaultText14M,
          ))
        : Expanded(
            child: ListView.builder(
              itemCount: widget.listPhiDichVu.length,
              itemBuilder: (context, index) {
                final item = widget.listPhiDichVu[index];
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            item.isExpanded = !item.isExpanded;
                          });
                        },
                        child: ListTile(
                          leading: SvgPicture.asset(
                            'assets/icons/allocation.svg',
                            width: 28.w,
                            height: 28.h,
                          ),
                          title: Text(
                            item.receiptName,
                            style: defaultText16M,
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              item.isExpanded
                                  ? Icons.remove_circle
                                  : Icons.add_circle,
                              size: 24.dm,
                              color:
                                  item.isExpanded ? Colors.green : Colors.green,
                            ),
                            onPressed: () {
                              setState(() {
                                item.isExpanded = !item.isExpanded;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    if (item.isExpanded)
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 4.h),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2F7FB),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.all(16.dm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDetailRow(
                                  "Phí cần thu",
                                  NumberFormat('#,###', AppLocalizations.of(context)!.bqlVivn)
                                      .format(int.parse(item.fee))),
                              _buildDetailRow(
                                  "Phí đã thu",
                                  NumberFormat('#,###', AppLocalizations.of(context)!.bqlVivn)
                                      .format(int.parse(item.feePaid))),
                              _buildDetailRow(AppLocalizations.of(context)!.bqlEmail, item.email),
                              _buildDetailRow(AppLocalizations.of(context)!.bqlSms, item.sms),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(context)!.bqlTrangThai,
                                        style: defaultText14Re,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6.w, vertical: 4.h),
                                      decoration: BoxDecoration(
                                        color: const Color(0xff129F20)
                                            .withValues(alpha: 0.8),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(6.r),
                                        ),
                                      ),
                                      child: Text(
                                        item.status,
                                        style: defaultText14M.copyWith(
                                          color: Colors.white,
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 12.h),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          );
  }
}

Widget _buildDetailRow(String title, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10.h),
    child: Row(
      children: [
        Expanded(
            child: Text(
          title,
          style: defaultText14Re,
        )),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}

class _ListSmsWidget extends StatefulWidget {
  const _ListSmsWidget({required this.listSms});
  final List<SmsModel> listSms;

  @override
  State<_ListSmsWidget> createState() => _ListSmsWidgetState();
}

class _ListSmsWidgetState extends State<_ListSmsWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.listSms.isEmpty
        ? Center(
            child: Text(
            AppLocalizations.of(context)!.bqlChuaCoSmsNao,
            style: defaultText14M,
          ))
        : Expanded(
            child: ListView.builder(
              itemCount: widget.listSms.length,
              itemBuilder: (context, index) {
                final item = widget.listSms[index];
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            item.isExpanded = !item.isExpanded;
                          });
                        },
                        child: ListTile(
                          leading: SvgPicture.asset(
                            'assets/icons/notification.svg',
                            width: 28.w,
                            height: 28.h,
                          ),
                          title: Text(
                            DateFormat(AppLocalizations.of(context)!.bqlYyyymmddKkmm)
                                .format(item.createdAt),
                            style: defaultText16M,
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              item.isExpanded
                                  ? Icons.remove_circle
                                  : Icons.add_circle,
                              size: 24.dm,
                              color:
                                  item.isExpanded ? Colors.green : Colors.green,
                            ),
                            onPressed: () {
                              setState(() {
                                item.isExpanded = !item.isExpanded;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    if (item.isExpanded)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2F7FB),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.all(16.dm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 343.w,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 16.w,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16.r),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.bqlNoiDung,
                                      style: defaultText14M.copyWith(
                                        color: const Color(0xff8A8A8A),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    Text(
                                      item.content,
                                      style: defaultText16B,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _infoBienlai('Số điện thoại', item.phone),
                                    Container(
                                      width: 164.w,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 4.h,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(16.r),
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.bqlLoaiTin,
                                            style: defaultText14M.copyWith(
                                              color: const Color(0xff8A8A8A),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 4.w,
                                              vertical: 2.h,
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.lightBlue,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4.r))),
                                            child: Text(
                                              item.type,
                                              style: defaultText14M.copyWith(
                                                color: Colors.white,
                                                fontSize: 13.sp,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _infoBienlai(AppLocalizations.of(context)!.bqlNguoiGui, item.userName),
                                    Container(
                                      width: 164.w,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 4.h,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(16.r),
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.bqlTrangThai,
                                            style: defaultText14M.copyWith(
                                              color: const Color(0xff8A8A8A),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 4.w,
                                              vertical: 2.h,
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4.r))),
                                            child: Text(
                                              item.status,
                                              style: defaultText14M.copyWith(
                                                color: Colors.white,
                                                fontSize: 13.sp,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          );
  }
}

class _ListBienlaiWidget extends StatefulWidget {
  const _ListBienlaiWidget({required this.listBienlai});
  final List<BienLaiModel> listBienlai;

  @override
  State<_ListBienlaiWidget> createState() => _ListBienlaiWidgetState();
}

class _ListBienlaiWidgetState extends State<_ListBienlaiWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.listBienlai.isEmpty
        ? Center(
            child: Text(
            AppLocalizations.of(context)!.bqlChuaCoBienLaiNao,
            style: defaultText14M,
          ))
        : Expanded(
            child: ListView.builder(
              itemCount: widget.listBienlai.length,
              itemBuilder: (context, index) {
                final item = widget.listBienlai[index];
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            item.isExpanded = !item.isExpanded;
                          });
                        },
                        child: ListTile(
                          leading: SvgPicture.asset(
                            'assets/icons/receipt.svg',
                            width: 28.w,
                            height: 28.h,
                          ),
                          title: Text(
                            item.receiptName,
                            style: defaultText16M,
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              item.isExpanded
                                  ? Icons.remove_circle
                                  : Icons.add_circle,
                              size: 24.dm,
                              color:
                                  item.isExpanded ? Colors.green : Colors.green,
                            ),
                            onPressed: () {
                              setState(() {
                                item.isExpanded = !item.isExpanded;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    if (item.isExpanded)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2F7FB),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.all(16.dm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //detail phieu thu
                              GestureDetector(
                                onTap: () async {
                                  //call api
                                  AllReceiptDetailModel receiptsDetailModel =
                                      await ApartmentRepo().getDetailReceipts(
                                    item.id,
                                  );

                                  pushWithoutNavBar(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) => DetailBillScreen(
                                            type: item.receiptsTextStatus,
                                            receiptsDetailModel:
                                                receiptsDetailModel,
                                          )),
                                    ),
                                  );
                                },
                                child: Container(
                                  //width: 343.w,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 12.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16.r),
                                    ),
                                  ),
                                  child: Text(AppLocalizations.of(context)!.bqlChiTietPhieuThu,
                                      style: defaultText14B.copyWith(
                                          color: Colors.white)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _infoBienlai(
                                        'Số điện thoại', item.phoneChuHo),
                                    _infoBienlai(AppLocalizations.of(context)!.bqlPhong, item.appartmentName),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _infoBienlai('Mục đích sử dụng',
                                        item.purposeUseName),
                                    _infoBienlai(
                                        'Diện tích (m2)', item.acreage),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _infoBienlai(AppLocalizations.of(context)!.bqlTongTien,
                                        '${formatVnIntString(item.totalFee)} VNĐ'),
                                    _infoBienlai(AppLocalizations.of(context)!.bqlSms, item.totalSmsReceipts),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _infoBienlai(AppLocalizations.of(context)!.bqlHttt, item.paymentTypeText),
                                    Container(
                                      width: 164.w,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 4.h,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(16.r),
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.bqlTrangThai,
                                            style: defaultText14M.copyWith(
                                              color: const Color(0xff8A8A8A),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 4.w,
                                              vertical: 4.h,
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4.r))),
                                            child: Text(
                                              item.receiptsTextStatus,
                                              style: defaultText14M.copyWith(
                                                color: Colors.white,
                                                fontSize: 13.sp,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          );
  }
}

Widget _infoBienlai(String title, String value) {
  return Container(
    width: 164.w,
    padding: EdgeInsets.symmetric(
      horizontal: 16.w,
      vertical: 4.h,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(16.r),
      ),
      color: Colors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          title,
          style: defaultText14M.copyWith(
            color: const Color(0xff8A8A8A),
          ),
        ),
        Text(
          value,
          style: defaultText16B,
        )
      ],
    ),
  );
}
