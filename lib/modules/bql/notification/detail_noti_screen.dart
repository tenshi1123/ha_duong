import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/bql_model/info_model_bql.dart';
import 'package:ha_duong/utils/constants/styles.dart';

class DetailNotiScreen extends StatefulWidget {
  const DetailNotiScreen({super.key, required this.model});
  final NotiValueModel model;
  @override
  State<DetailNotiScreen> createState() => _DetailNotiScreenState();
}

class _DetailNotiScreenState extends State<DetailNotiScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int activeTabIndex = 0;
  late NotiValueModel item;
  @override
  void initState() {
    super.initState();
    item = widget.model;
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
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0), // độ cao divider
          child: Container(
            color: Colors.grey.shade300,
            height: 1.0,
          ),
        ),
        title: Text(
          'Chi tiết thông báo',
          style: defaultText18B,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
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
              widget.model.title,
              style: defaultText14B,
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              "${item.createdAt.hour.toString().padLeft(2, '0')}:${item.createdAt.minute.toString().padLeft(2, '0')} - ${item.createdAt.day.toString().padLeft(2, '0')}/${item.createdAt.month.toString().padLeft(2, '0')}/${item.createdAt.year}",
              style: defaultText14Re.copyWith(
                color: const Color(0xffA3A3A3),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(item.content, style: defaultText14Re),
          ],
        ),
      ),
    );
  }
}
