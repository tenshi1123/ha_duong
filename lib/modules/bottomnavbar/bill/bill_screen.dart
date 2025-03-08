import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/modules/bottomnavbar/bill/detail_bill_screen.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class TabBarApp extends StatelessWidget {
  const TabBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(useMaterial3: true), home: const TabBarExample());
  }
}

class TabBarExample extends StatelessWidget {
  const TabBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Center(child: Text('Hoá đơn')),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(child: Text('Chờ thanh toán(2)')),
              Tab(
                child: Text('Lịch sử thanh toán'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return WaitingPayment(
                  index: index,
                );
              },
            ),
            ListView.builder(
              itemCount: 8,
              itemBuilder: (context, index) {
                return PaymentHistory(
                  index: index,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentHistory extends StatelessWidget {
  const PaymentHistory({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: 343.w,
      margin: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: index == 0 ? 20.h : 0,
        bottom: 8.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12.r),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 16.w,
              ),
              Image.asset(
                'assets/images/bill.png',
                height: 40.h,
                width: 40.w,
                fit: BoxFit.fill,
              ),
              SizedBox(
                width: 12.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      Text(
                        'Hoá đơn tháng 0' '${9 - index}' '/2024',
                        style: defaultText14B,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Image.asset(
                        'assets/images/done.png',
                        height: 14.h,
                        width: 14.w,
                        fit: BoxFit.fill,
                      )
                    ],
                  ),
                  Text(
                    'Phí dịch vụ',
                    style:
                        defaultText12B.copyWith(color: const Color(0xff8A8A8A)),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                  onTap: () {
                    pushWithoutNavBar(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const DetailBillScreen(
                              type: 0,
                            )),
                      ),
                    );
                  },
                  child: Image.asset('assets/images/arrow_right.png')),
              SizedBox(
                width: 16.w,
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          const Divider(),
          const Spacer(),
        ],
      ),
    );
  }
}

class WaitingPayment extends StatelessWidget {
  const WaitingPayment({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.h,
      width: 343.w,
      margin: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: index == 0 ? 20.h : 0,
        bottom: 8.h,
      ),
      decoration: BoxDecoration(
          color: const Color(0xff1B91C4),
          borderRadius: BorderRadius.all(
            Radius.circular(12.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.16),
              spreadRadius: 0,
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ]),
      child: Container(
        height: 72.h,
        width: 339.w,
        margin: EdgeInsets.only(left: 4.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(8.r),
            right: Radius.circular(12.r),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 16.w,
            ),
            Image.asset(
              'assets/images/bill.png',
              height: 40.h,
              width: 40.w,
              fit: BoxFit.fill,
            ),
            SizedBox(
              width: 12.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'Hoá đơn tháng ${10 + index}/2024',
                  style: defaultText14B,
                ),
                Text(
                  'Phí dịch vụ',
                  style:
                      defaultText12B.copyWith(color: const Color(0xff8A8A8A)),
                ),
                SizedBox(
                  height: 5.h,
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                pushWithoutNavBar(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const DetailBillScreen(
                          type: 1,
                        )),
                  ),
                );
              },
              child: Image.asset(
                'assets/images/arrow_right.png',
                height: 24.h,
                width: 24.w,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: 16.w,
            ),
          ],
        ),
      ),
    );
  }
}
