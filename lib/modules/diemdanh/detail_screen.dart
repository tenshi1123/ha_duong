import 'package:ha_duong/modules/bottomnavbar/bill/bill_screen.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen(
      {super.key,
      required this.title1,
      required this.title2,
      required this.title3});
  final String title1;
  final String title2;
  final String title3;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff273D8C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        title: Text(
          'Chi tiết buổi học',
          style: defaultText18B.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title1,
                style: defaultText14M.copyWith(color: const Color(0xff273D8C)),
              ),
              SizedBox(height: 12.h),
              Text(
                widget.title2,
                style: defaultText16B.copyWith(color: const Color(0xff273D8C)),
              ),
              SizedBox(height: 12.h),
              Text(
                'Nội dung buổi học: ${widget.title3}',
                style: defaultText14M.copyWith(color: const Color(0xff273D8C)),
              ),
              SizedBox(height: 12.h),
              SizedBox(
                height: 420.h,
                width: 343.w,
                child: const NestedTabBar(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NestedTabBar extends StatefulWidget {
  const NestedTabBar({super.key});
  @override
  State<NestedTabBar> createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int activeTabIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
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
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar.secondary(
          controller: _tabController,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(
              8.r,
            ),
            //color: const Color(0xff273D8C),
          ),
          isScrollable: false,
          automaticIndicatorColorAdjustment: false,
          dividerColor: Colors.white,
          labelStyle: defaultText14M,
          labelColor: Colors.white,
          unselectedLabelColor: const Color(0xff273D8C),
          tabs: [
            Tab(
              child: Container(
                height: 34.h,
                width: 108.w,
                decoration: BoxDecoration(
                    color: activeTabIndex == 0
                        ? const Color(0xFF273D8C)
                        : const Color(0xFFEFF1F7),
                    borderRadius: BorderRadius.all(Radius.circular(8.r))),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text("Bài tập"),
                ),
              ),
            ),
            Tab(
              child: Container(
                height: 34.h,
                width: 108.w,
                decoration: BoxDecoration(
                    color: activeTabIndex == 1
                        ? const Color(0xFF273D8C)
                        : const Color(0xFFEFF1F7),
                    borderRadius: BorderRadius.all(Radius.circular(8.r))),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text("Tài liệu"),
                ),
              ),
            ),
            Tab(
              child: Container(
                height: 34.h,
                width: 108.w,
                decoration: BoxDecoration(
                    color: activeTabIndex == 2
                        ? const Color(0xFF273D8C)
                        : const Color(0xFFEFF1F7),
                    borderRadius: BorderRadius.all(Radius.circular(8.r))),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text("Đánh giá"),
                ),
              ),
            ),
          ],
        ),
        // TabBar.secondary(
        //   tabAlignment: TabAlignment.start,
        //   padding: EdgeInsets.zero,
        //   indicatorPadding: EdgeInsets.zero,
        //   labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
        //   isScrollable: true,
        //   indicatorColor: keyBlack,
        //   indicatorSize: TabBarIndicatorSize.label,
        //   indicator: UnderlineTabIndicator(
        //     borderSide: BorderSide(width: 2.w), //hight of indicator
        //     insets: EdgeInsets.symmetric(
        //         horizontal:
        //             20.w), //give some padding to reduce the size of indicator
        //   ),
        //   unselectedLabelColor: keyBlack.withOpacity(0.3),
        //   labelStyle: defaultText14M,
        //   labelColor: keyBlack,
        //   controller: _tabController,
        //   tabs: <Widget>[
        //     homeTab(title: 'Toàn bộ', isSeprator: false),
        //     homeTab(title: 'Chưa làm'),
        //     homeTab(title: 'Hoàn thành'),
        //   ],
        // ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              Container(
                height: 367.h,
                width: 343.w,
                margin: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 16.h,
                  horizontal: 16.w,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(50),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image(
                          image:
                              const AssetImage('assets/images/icon_file.png'),
                          height: 48.h,
                          width: 48.w,
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tenbaitap.PDF',
                              style: defaultText16B,
                            ),
                            Text(
                              'chọn bài tập bạn muốn xem',
                              style: defaultText14Re.copyWith(
                                color: Colors.black.withAlpha(60),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const Divider(thickness: 1),
                    Text(
                      'Hạn nộp bài: 26 tháng 1,2025',
                      style: defaultText14B,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (!await launchUrl(Uri.parse(
                            'https://vietjack.com/ngu-phap-tieng-anh/trac-nghiem-bai-kiem-tra-trinh-do-tieng-anh-online.jsp'))) {
                          throw Exception('Could not launch ');
                        }
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: 120.w,
                            height: 80.h,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/images/image.png')
                                    as ImageProvider,
                              ),
                              gradient: LinearGradient(
                                  begin: FractionalOffset.topCenter,
                                  end: FractionalOffset.bottomCenter,
                                  colors: [
                                    Colors.grey.withOpacity(0.0),
                                    Colors.black,
                                  ],
                                  stops: const [
                                    0.0,
                                    1.0,
                                  ]),
                            ),
                          ),
                          Container(
                            width: 120.w,
                            height: 80.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: FractionalOffset.topCenter,
                                  end: FractionalOffset.bottomCenter,
                                  colors: [
                                    Colors.white,
                                    Colors.black.withAlpha(40),
                                  ],
                                  stops: const [
                                    0.0,
                                    1.0,
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //Tai lieu
              Column(
                children: [
                  SizedBox(
                    width: 343.w,
                    height: 80.h,
                    child: Row(
                      children: [
                        Text('Không có tài liệu', style: defaultText16M)
                      ],
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    width: 343.w,
                    height: 80.h,
                    child: Row(
                      children: [
                        Text('Không có đánh giá', style: defaultText16M)
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
