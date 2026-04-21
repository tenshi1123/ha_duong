import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/bql_model/home_model.dart';
import 'package:ha_duong/bql_model/info_model_bql.dart';
import 'package:ha_duong/bql_model/technical_requests_model.dart';
import 'package:ha_duong/bql_repo/bql_home_repo.dart';
import 'package:ha_duong/bql_repo/technical_requests_repo.dart';
import 'package:ha_duong/modules/bql/home/change_info/detail_change_info_screen.dart';
import 'package:ha_duong/modules/bql/home/home.dart';
import 'package:ha_duong/modules/bql/home/yeucau_hotro/request_detail_screen.dart';
import 'package:ha_duong/modules/bql/notification/detail_noti_screen.dart';
import 'package:ha_duong/utils/constants/color.dart';
import 'package:ha_duong/utils/constants/styles.dart';

import 'package:intl/intl.dart';

class ThongBaoDaTaoScreen extends StatefulWidget {
  const ThongBaoDaTaoScreen({super.key, required this.listNotiModel});
  final List<NotiValueModel> listNotiModel;
  @override
  State<ThongBaoDaTaoScreen> createState() => _ThongBaoDaTaoScreenState();
}

class _ThongBaoDaTaoScreenState extends State<ThongBaoDaTaoScreen>
    with SingleTickerProviderStateMixin {
  int activeTabIndex = 0;
  int selectedIndex = 0;
  int selectedType = 1;

  final List<NotiTypeModel> notificationTypeList = [
    NotiTypeModel(value: 1, name: "Ban quản lý", total: "0"),
    NotiTypeModel(value: 2, name: "Thanh toán", total: "0"),
    NotiTypeModel(value: 3, name: "Xử lý phản ánh", total: "0"),
    NotiTypeModel(value: 4, name: "Yêu cầu hỗ trợ", total: "0"),
    NotiTypeModel(value: 5, name: "Yêu cầu tiện ích", total: "0"),
    NotiTypeModel(value: 6, name: "Yêu cầu đổi thông tin", total: "0"),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<NotiValueModel> filtered = widget.listNotiModel
        .where((item) => item.type == selectedType.toString())
        .toList();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: keyBlack),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        title: Text(
          'Thông báo',
          style: defaultText18B,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTabs(),
            const SizedBox(height: 8),
            selectedType == 4
                ? HotroNoti()
                : selectedType == 5
                    ? TienIch()
                    : selectedType == 6
                        ? ChangeInfo()
                        : filtered.isEmpty
                            ? Center(
                                child: Text(
                                  'Không có thông báo',
                                  style: defaultText14B,
                                ),
                              )
                            : Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: ListView.separated(
                                    itemCount: filtered.length,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 1.h),
                                    separatorBuilder: (_, __) =>
                                        const Divider(),
                                    itemBuilder: (_, index) {
                                      final item = filtered[index];
                                      return _buildNotificationItem(item);
                                    },
                                  ),
                                ),
                              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return SizedBox(
      height: 56.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        itemCount: notificationTypeList.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, index) {
          final type = notificationTypeList[index];
          final isSelected = selectedType == type.value;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedType = type.value;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white
                    : const Color.fromARGB(255, 249, 249, 249),
                border: Border.all(
                    color: isSelected ? Colors.blue : Colors.transparent),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Text(
                    type.name,
                    style: TextStyle(
                      color: isSelected ? Colors.blue : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if ((int.tryParse(type.total) ?? 0) > 0)
                    Container(
                      margin: const EdgeInsets.only(left: 6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        type.total.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
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

  Widget _buildNotificationItem(NotiValueModel item) {
    return ListTile(
      leading: Image.asset(
        'assets/images/bill.png',
        height: 40.h,
        width: 40.w,
        fit: BoxFit.fill,
      ),
      title: Text(
        item.title,
        style: defaultText14B.copyWith(
            color: item.isActive == '0'
                ? keyBlack
                : keyBlack.withValues(alpha: 0.5)),
      ),
      subtitle: Text(
        "${item.createdAt.hour.toString().padLeft(2, '0')}:${item.createdAt.minute.toString().padLeft(2, '0')} - ${item.createdAt.day.toString().padLeft(2, '0')}/${item.createdAt.month.toString().padLeft(2, '0')}/${item.createdAt.year}",
        style: defaultText14Re.copyWith(
            color: item.isActive == '0'
                ? keyBlack
                : keyBlack.withValues(alpha: 0.5)),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => DetailNotiScreen(
                  model: item,
                )),
          ),
        );
      },
    );
  }
}

class HotroNoti extends StatefulWidget {
  const HotroNoti({super.key});

  @override
  State<HotroNoti> createState() => _HotroNotiState();
}

class _HotroNotiState extends State<HotroNoti> {
  late List<TechnicalSupportModel> listTechnicalRequests;
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    try {
      final response = await TechnicalRequestsRepo()
          .getListTechnicalRequests(buildingId: "");
      setState(() {
        listTechnicalRequests = response;
      });
    } catch (e) {
      debugPrint('Lỗi khi gọi API: $e');
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
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
              Spacer(),
              Text(
                DateFormat('dd/MM HH:mm').format(model.createdAt),
                style: defaultText12B,
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

class TienIch extends StatefulWidget {
  const TienIch({super.key});

  @override
  State<TienIch> createState() => _TienIchState();
}

class _TienIchState extends State<TienIch> {
  late List<ExtensionModel> listExtension;
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    try {
      final response = await HomeRepo()
          .getListTechnicalRequests(buildingId: homeSelecteBuilding?.id ?? '');
      setState(() {
        listExtension = response;
      });
    } catch (e) {
      // Xử lý lỗi nếu cần
      debugPrint('Lỗi khi gọi API: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        //padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        itemCount: listExtension.length,
        itemBuilder: (context, index) {
          //final reversedIndex = listExtension.length - 1 - index;
          final item = listExtension[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _RequestCard2(
              model: item,
            ),
          );
        },
      ),
    );
  }
}

class _RequestCard2 extends StatelessWidget {
  final ExtensionModel model;

  const _RequestCard2({
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

class ChangeInfo extends StatefulWidget {
  const ChangeInfo({super.key});

  @override
  State<ChangeInfo> createState() => _ChangeInfoState();
}

class _ChangeInfoState extends State<ChangeInfo> {
  late List<ResidentPendingModel> listTechnicalRequests;

  @override
  void initState() {
    fetchData();
    super.initState();
    //_loadSupportData();
  }

  Future<void> fetchData() async {
    try {
      final response =
          await TechnicalRequestsRepo().getListChangeInfo(buildingId: "");
      setState(() {
        listTechnicalRequests = response;
      });
    } catch (e) {
      // Xử lý lỗi nếu cần
      debugPrint('Lỗi khi gọi API: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
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
              child: _RequestCard3(
                model: item,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RequestCard3 extends StatelessWidget {
  final ResidentPendingModel model;

  const _RequestCard3({
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
