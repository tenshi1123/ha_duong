import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/models/info_model.dart';
import 'package:ha_duong/modules/bottomnavbar/bill/detail_bill_screen.dart';
import 'package:ha_duong/repo/home_repo.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class BillScreen extends StatefulWidget {
  const BillScreen({super.key});

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  bool isLoading = true;
  late ListReceiptsModel data; // thay bằng model cụ thể của bạn

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      // Gọi API ở đây - thay thế bằng logic thật của bạn
      final response = await HomeRepo().getListReceipts();

      // Cập nhật state sau khi có dữ liệu
      setState(() {
        data = response;
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
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Center(child: Text('Hoá đơn')),
          centerTitle: true,
          bottom: TabBar(
            labelColor: const Color(0xff0F2645), // Màu chữ tab khi được chọn
            unselectedLabelColor: Colors.grey, // Màu chữ tab không được chọn
            indicatorColor:
                const Color(0xff0F2645), // Màu gạch dưới khi được chọn
            indicatorWeight: 2.0, // Độ dày của gạch dưới
            tabs: <Widget>[
              Tab(
                  child: Text(
                      'Chờ thanh toán (${data.listReceiptsunpaid.length})')),
              const Tab(
                child: Text('Lịch sử thanh toán'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            data.listReceiptsunpaid.isEmpty
                ? Center(
                    child: Text(
                      'Không có hoá đơn chờ thanh toán',
                      style: defaultText14B.copyWith(color: Colors.black54),
                    ),
                  )
                : ListView.builder(
                    itemCount: data.listReceiptsunpaid.length,
                    itemBuilder: (context, index) {
                      return WaitingPayment(
                        index: index,
                        model: data.listReceiptsunpaid[index],
                      );
                    },
                  ),
            data.listReceiptspaid.isEmpty
                ? Center(
                    child: Text(
                      'Không có lịch sử thanh toán',
                      style: defaultText14B.copyWith(color: Colors.black54),
                    ),
                  )
                : ListView.builder(
                    itemCount: data.listReceiptspaid.length,
                    itemBuilder: (context, index) {
                      return PaymentHistory(
                        index: index,
                        model: data.listReceiptspaid[index],
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
  const PaymentHistory({super.key, required this.index, required this.model});
  final int index;
  final ReceiptsModel model;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        //call api
        AllReceiptDetailModel receiptsDetailModel =
            await HomeRepo().getDetailReceipts(model.id);

        pushWithoutNavBar(
          context,
          MaterialPageRoute(
            builder: ((context) => DetailBillScreen(
                  type: 0,
                  receiptsDetailModel: receiptsDetailModel,
                )),
          ),
        );
      },
      child: Container(
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
                          model.name,
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
                      'Đã thanh toán',
                      style: defaultText12B.copyWith(
                          color: const Color(0xff129F20)),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                  ],
                ),
                const Spacer(),
                Image.asset('assets/images/arrow_right.png'),
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
      ),
    );
  }
}

class WaitingPayment extends StatelessWidget {
  const WaitingPayment({super.key, required this.index, required this.model});
  final int index;
  final ReceiptsModel model;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        //call api
        AllReceiptDetailModel receiptsDetailModel =
            await HomeRepo().getDetailReceipts(model.id);

        pushWithoutNavBar(
          context,
          MaterialPageRoute(
            builder: ((context) => DetailBillScreen(
                  type: 1,
                  receiptsDetailModel: receiptsDetailModel,
                )),
          ),
        );
      },
      child: Container(
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
                    model.name,
                    style: defaultText14B,
                  ),
                  // Text(
                  //   'Hạn thanh toán ${model.hanThanhToan}',
                  //   style:
                  //       defaultText12B.copyWith(color: const Color(0xff8A8A8A)),
                  // ),
                  RichText(
                    text: TextSpan(
                      text: 'Hạn thanh toán: ',
                      style: defaultText14M.copyWith(
                        color: const Color(0xff8A8A8A).withValues(alpha: 0.8),
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: model.hanThanhToan,
                          style: defaultText14B.copyWith(
                            color: const Color(0xffE80707),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
              const Spacer(),
              Image.asset(
                'assets/images/arrow_right.png',
                height: 24.h,
                width: 24.w,
                fit: BoxFit.fill,
              ),
              SizedBox(
                width: 16.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
