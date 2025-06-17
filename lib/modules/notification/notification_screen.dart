import 'package:ha_duong/models/chat_model.dart';
import 'package:ha_duong/modules/notification/detail_noti_screen.dart';
import 'package:ha_duong/repo/chat_noti_repo.dart';
import 'package:ha_duong/utils/constants/color.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key, required this.notiModel});
  final NotificationModel notiModel;
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  int activeTabIndex = 0;
  int selectedIndex = 0;
  int selectedType = 1;
  late NotificationModel _notiModel;

  @override
  void initState() {
    super.initState();
    _notiModel = widget.notiModel;
  }

  @override
  Widget build(BuildContext context) {
    late List<NotiValueModel> filtered = widget.notiModel.listNoti
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
            filtered.isEmpty
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
                        separatorBuilder: (_, __) => const Divider(),
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
        itemCount: _notiModel.listNotiType.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, index) {
          final type = _notiModel.listNotiType[index];
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
        ChatRepo().getDetailNoti(item.id);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => DetailNotiScreen(
                  notiModel: item,
                )),
          ),
        );
      },
    );
  }
}
