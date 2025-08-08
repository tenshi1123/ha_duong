import 'package:ha_duong/models/chat_model.dart';
import 'package:ha_duong/models/info_model.dart';
import 'package:ha_duong/modules/bottomnavbar/bill/detail_bill_screen.dart';
import 'package:ha_duong/repo/chat_noti_repo.dart';
import 'package:ha_duong/repo/home_repo.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/utils/widget/custom_widget.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../models/apartment_model.dart';
import '../../notification/notification_screen.dart';

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
  String selectedCategoryId = "1";
  List<PostModel> posts = [];
  @override
  void initState() {
    super.initState();
    infoHomeModel = widget.infoHomeModel;
    selectedApartment = widget.infoHomeModel.listApartment[0];
    fetchPostsByCategory(selectedCategoryId);
  }

  Future<void> fetchPostsByCategory(String categoryId) async {
    setState(() {
      selectedCategoryId = categoryId;
    });

    // Replace this with your actual API URL
    List<PostModel> postModel = await HomeRepo().changeCategory(
        apartmentId: widget.infoHomeModel.listApartment[0].id,
        categoryId: categoryId);

    setState(() {
      posts = postModel;
    });
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
              height: 230.h,
              child: Stack(children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Image(
                    width: MediaQuery.of(context).size.width,
                    height: 210.h,
                    image: const AssetImage(
                      'assets/images/home_background.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  top: 64.h,
                  left: 20.w,
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
                              onTap: () async {
                                NotificationModel notimodel = await ChatRepo()
                                    .getHomeNoti(selectedApartment.id);
                                pushWithoutNavBar(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => NotificationScreen(
                                          notiModel: notimodel,
                                        )),
                                  ),
                                );
                              },
                              child: Image(
                                image:
                                    const AssetImage('assets/images/bell.png'),
                                //height: 24.h,
                                width: 24.w,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        PopupMenuButton<ApartmentModel>(
                          onSelected: (value) {
                            setState(() {
                              selectedApartment = value;
                            });
                          },
                          constraints:
                              BoxConstraints(minWidth: 280.w, maxWidth: 320.w),
                          itemBuilder: (context) =>
                              widget.infoHomeModel.listApartment.map((address) {
                            return PopupMenuItem(
                              value: address,
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/location.png',
                                    height: 20.5.h,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    address.name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          offset: Offset(0, 42.h),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          color: Colors.white,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/images/location.png',
                                  height: 20.5.h,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    selectedApartment.name,
                                    style: const TextStyle(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const Icon(Icons.arrow_drop_down,
                                    color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                        // ApartmentDropdown(
                        //   selectedApartment: infoHomeModel.listApartment[0],
                        //   apartmentList: infoHomeModel.listApartment,
                        //   onChanged: (value) {
                        //     setState(() {
                        //       selectedApartment = value!;
                        //     });
                        //   },
                        // ),
                        SizedBox(
                          height: 4.h,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 20.w,
                      bottom: 10.h,
                      top: 16.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        topRight: Radius.circular(16.r),
                      ),
                    ),
                    child: Text(
                      'Yêu cầu thanh toán',
                      style: defaultText16B,
                    ),
                  ),
                ),
              ]),
            ),
            infoHomeModel.listReceipts.isEmpty
                ? Padding(
                    padding: EdgeInsets.only(left: 20.w, bottom: 10.h),
                    child: Text(
                      'Không có yêu cầu thanh toán nào',
                      style: defaultText14,
                    ),
                  )
                : Column(
                    children: List.generate(infoHomeModel.listReceipts.length,
                        (index) {
                      return Container(
                        height: 72.h,
                        width: 343.w,
                        margin: EdgeInsets.only(
                          left: 20.w,
                          bottom: 16.h,
                          right: 20.w,
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
                        child: InkWell(
                          onTap: () async {
                            //call api
                            AllReceiptDetailModel receiptsDetailModel =
                                await HomeRepo().getDetailReceipts(infoHomeModel
                                    .listReceipts[index].id
                                    .toString());

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
                                  width: 20.w,
                                ),
                                Image.asset(
                                  'assets/images/bill.png',
                                  height: 40.h,
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Text(
                                  infoHomeModel.listReceipts[index].name,
                                  style: defaultText16,
                                ),
                                const Spacer(),
                                Image.asset('assets/images/arrow_right.png'),
                                SizedBox(
                                  width: 20.w,
                                ),
                              ],
                            ),
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
              padding: EdgeInsets.only(left: 20.w, bottom: 10.h, top: 12.h),
              child: Text(
                'Bảng tin toà nhà',
                style: defaultText16B,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: infoHomeModel.listCategory.map((cat) {
                  final bool isSelected = cat.id == selectedCategoryId;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(cat.name),
                      selected: isSelected,
                      onSelected: (_) => fetchPostsByCategory(cat.id),
                      selectedColor: Colors.blue.shade50,
                      labelStyle: TextStyle(
                        color: isSelected
                            ? const Color(0xff004071)
                            : const Color(0xff8A8A8A),
                        fontSize: 14.sp,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.w600,
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: isSelected
                              ? const Color(0xff004071)
                              : Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      backgroundColor: Colors.white,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
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
                          itemCount: posts.length,
                          itemBuilder: (_, index) {
                            return PostItem(
                              postModel: posts[index],
                            );
                          },
                        ),
                      ),
                    ),
                    infoHomeModel.listPost.length < 3
                        ? const SizedBox()
                        : SmoothPageIndicator(
                            controller: controller3,
                            count: 3,
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
