import 'package:ha_duong/models/chat_model.dart';
import 'package:ha_duong/utils/constants/color.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailNotiScreen extends StatefulWidget {
  const DetailNotiScreen({super.key, required this.notiModel});
  final NotiValueModel notiModel;
  @override
  State<DetailNotiScreen> createState() => _DetailNotiScreenState();
}

class _DetailNotiScreenState extends State<DetailNotiScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int activeTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
    _tabController.addListener(() {
      setState(() {
        activeTabIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: keyBlack),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        title: Text(
          'Chi tiết thông báo',
          style: defaultText18B,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey.shade300,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image(
            //   image: const AssetImage('assets/images/notification.png'),
            //   height: 180.h,
            //   width: 343.w,
            //   fit: BoxFit.fill,
            // ),

            Text(
              'Thông báo nhân viên kỹ thuật phục vụ yêu cầu hỗ trợ',
              style: defaultText16B,
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              '20:05 - 28/10/2022',
              style: defaultText14Re.copyWith(
                color: const Color(0xff292929).withValues(alpha: 0.8),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              'Bộ phận kỹ thuật xin thông báo rằng yêu cầu hỗ trợ kỹ thuật của Bạn liên quan đến kỹ thuật đã được xử lý hoàn tất vào lúc 20h ngày 30/10/2022.',
              style: defaultText14Re.copyWith(
                  color: const Color(0xff292929).withValues(alpha: 0.8)),
            ),
          ],
        ),
      ),
    );
  }
}
