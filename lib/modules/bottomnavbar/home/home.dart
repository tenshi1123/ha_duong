import 'package:ha_duong/models/info_model.dart';
import 'package:ha_duong/modules/bottomnavbar/bill/detail_bill_screen.dart';
import 'package:ha_duong/repo/home_repo.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/utils/widget/custom_widget.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../notification/notification_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.infoHomeModel});
  final InfoModel infoHomeModel;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller1 = PageController(viewportFraction: 1, keepPage: true);
  final controller2 = PageController(viewportFraction: 0.75, keepPage: true);
  final controller3 = PageController(viewportFraction: 0.75, keepPage: true);
  late InfoModel infoHomeModel;
  late ApartmentModel selectedApartment;
  @override
  void initState() {
    super.initState();
    infoHomeModel = widget.infoHomeModel;
    selectedApartment = widget.infoHomeModel.listApartment[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 375.w,
              height: 212.h,
              child: Stack(children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Image(
                    width: MediaQuery.of(context).size.width,
                    height: 255.h,
                    image: const AssetImage(
                      'assets/images/home_background.png',
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Positioned(
                  top: 64.h,
                  left: 16.w,
                  child: SizedBox(
                    width: 340.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipOval(
                              child: Image.network(
                                infoHomeModel.resident.img,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Text(
                                    'Error',
                                    style: defaultText14M.copyWith(
                                      color: Colors.white,
                                    ),
                                  );
                                },
                                height: 44.h,
                                width: 44.w,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Text(
                              infoHomeModel.resident.fullName,
                              style:
                                  defaultText20B.copyWith(color: Colors.white),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                pushWithoutNavBar(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) =>
                                        const NotificationScreen()),
                                  ),
                                );
                              },
                              child: Image(
                                image:
                                    const AssetImage('assets/images/bell.png'),
                                height: 24.h,
                                width: 24.w,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        ApartmentDropdown(
                          selectedApartment: infoHomeModel.listApartment[0],
                          apartmentList: infoHomeModel.listApartment,
                          onChanged: (value) {
                            setState(() {
                              selectedApartment = value!;
                            });
                          },
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    height: 16.h,
                    width: 375.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        topRight: Radius.circular(16.r),
                      ),
                      color: Colors.white,
                    ),
                  ),
                )
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, bottom: 10.h),
              child: Text(
                'Yêu cầu thanh toán',
                style: defaultText16B,
              ),
            ),
            Column(
              children:
                  List.generate(infoHomeModel.listReceipts.length, (index) {
                return Container(
                  height: 72.h,
                  width: 343.w,
                  margin: EdgeInsets.only(
                    left: 16.w,
                    bottom: 16.h,
                    right: 16.w,
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
                        Image.asset('assets/images/bill.png'),
                        SizedBox(
                          width: 12.w,
                        ),
                        Text(
                          infoHomeModel.listReceipts[index].name,
                          style: defaultText16,
                        ),
                        const Spacer(),
                        InkWell(
                            onTap: () async {
                              //call api
                              ReceiptsDetailModel receiptsDetailModel =
                                  await HomeRepo().getDetailReceipts(
                                      infoHomeModel.listReceipts[index].id
                                          .toString());

                              pushWithoutNavBar(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => DetailBillScreen(
                                        type: 0,
                                        receiptsDetailModel:
                                            receiptsDetailModel,
                                      )),
                                ),
                              );
                            },
                            child:
                                Image.asset('assets/images/arrow_right.png')),
                        SizedBox(
                          width: 16.w,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            Divider(
              thickness: 8.h,
              color: const Color(0xffF0F0F0),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, bottom: 10.h, top: 12.h),
              child: Text(
                'Bảng tin toà nhà',
                style: defaultText16B,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: SizedBox(
                width: 375.w,
                height: 218.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        bottomLeft: Radius.circular(16.r),
                      ),
                      child: SizedBox(
                        height: 206.h,
                        width: 375.w,
                        child: PageView.builder(
                          padEnds: false,
                          controller: controller3,
                          itemCount: infoHomeModel.listPost.length,
                          itemBuilder: (_, index) {
                            return PostItem(
                              link: 'https://i.imgur.com/8HUYYgc.png',
                              postTitle: infoHomeModel.listPost[index].name,
                              thumbnailUrl: 'https://i.imgur.com/8HUYYgc.png',
                            );
                          },
                        ),
                      ),
                    ),
                    SmoothPageIndicator(
                      controller: controller3,
                      count: infoHomeModel.listPost.length,
                      effect: CustomizableEffect(
                        activeDotDecoration: DotDecoration(
                          width: 20.w,
                          height: 8.h,
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        dotDecoration: DotDecoration(
                          width: 8.w,
                          height: 8.h,
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(16),
                          verticalOffset: 0,
                        ),
                        spacing: 6.0,
                      ),
                      onDotClicked: (index) {
                        controller2.animateToPage(index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Vội vl không tách widgetwidget
class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!await launchUrl(Uri.parse('https://ha_duong.edu.vn/'))) {
          throw Exception('Could not launch ');
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 240.w,
            height: 160.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16.r)),
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage(list[index]),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(
            'Đáp án Sách ngữ pháp sơ đồ tư duy Casalinnk',
            style: defaultText14B,
          )
        ],
      ),
    );
  }
}

List<String> list = [
  'assets/images/banner.png',
  'assets/images/banner1.png',
  'assets/images/banner2.png',
  'assets/images/banner3.png',
  'assets/images/banner4.png',
  'assets/images/banner5.png',
];
