import 'package:ha_duong/l10n/app_localizations.dart';
import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/bql_model/home_model.dart';
import 'package:ha_duong/bql_model/info_model_bql.dart';
import 'package:ha_duong/bql_repo/bql_home_repo.dart';
import 'package:ha_duong/bql_repo/notification_repo.dart';
import 'package:ha_duong/main.dart';
import 'package:ha_duong/modules/bottomnavbar/bql_bottom_nav_bar.dart';
import 'package:ha_duong/modules/bql/home/detail_post_screen.dart';
import 'package:ha_duong/modules/bql/home/yeucau_hotro/list_request_screen.dart';
import 'package:ha_duong/modules/bql/home/yeucau_hotro/request_detail_screen.dart';
import 'package:ha_duong/modules/bql/info/bql_personal_screen.dart';
import 'package:ha_duong/modules/bql/notification/notification_screen.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:ha_duong/utils/widget/custom_widget.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

BuildingModel? homeSelecteBuilding;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.homeModel, required this.isTest});
  final bool isTest;
  final HomeModel homeModel;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final controller1 = PageController(viewportFraction: 1, keepPage: true);
  final controller2 = PageController(viewportFraction: 0.75, keepPage: true);
  final controller3 = PageController(viewportFraction: 0.75, keepPage: true);
  List<BuildingModel> buildings = [];
  late HomeModel _homeModel;
  List<PostModel> posts = [];
  String selectedCategoryId = "1";
  bool showAll = false;
  final int defaultVisibleCount = 2;
  @override
  void initState() {
    super.initState();
    buildings = widget.homeModel.listBuilding;
    homeSelecteBuilding ??= widget.homeModel.listBuilding.first;
    _homeModel = widget.homeModel;
    if (widget.isTest) {
      changeBuilding(widget.homeModel.listBuilding[5]);
    }

    fetchPostsByCategory(selectedCategoryId);
  }

  Future<void> fetchPostsByCategory(String categoryId) async {
    setState(() {
      selectedCategoryId = categoryId;
    });
    // Replace this with your actual API URL
    List<PostModel> postModel = await HomeRepo().changeCategory(
      apartmentId: homeSelecteBuilding?.id ?? _homeModel.listBuilding.first.id,
      categoryId: categoryId,
    );
    setState(() {
      posts = postModel;
    });
  }

  Future<void> changeBuilding(BuildingModel? value) async {
    HomeModel newHomeModel = await HomeRepo().changeBuilding(
        buildingId: value?.id ?? '0',
        listBuilding: widget.homeModel.listBuilding);
    setState(() {
      homeSelecteBuilding = value;
      _homeModel = newHomeModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: RefreshIndicator(
        onRefresh: () {
          return fetchPostsByCategory(selectedCategoryId);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 375.w,
                height: 286.h,
                child: Stack(children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    //add border radius to image, mẹ ảnh trông như có boder sẵn nhưng lại không có
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.r),
                        bottomRight: Radius.circular(40.r),
                      ),
                      child: Image(
                        width: MediaQuery.of(context).size.width,
                        height: 266.h,
                        image: const AssetImage(
                          'assets/images/home_background.png',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40.h,
                    left: 16.w,
                    child: SizedBox(
                        width: 340.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        pushScreenWithNavBar(
                                            context, const BqlPersonalScreen());
                                      },
                                      child: ValueListenableBuilder<List<File>>(
                                        valueListenable: mainAvatarNotifier,
                                        builder: (context, value, _) {
                                          if (value.isNotEmpty) {
                                            return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(28.r),
                                              child: Image.file(
                                                value.first,
                                                width: 56.r,
                                                height: 56.r,
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          } else {
                                            return CircleAvatar(
                                              radius: 28.r,
                                              backgroundImage: NetworkImage(
                                                infoHomeModel.avatar,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 12.dm),
                                    GestureDetector(
                                      onTap: () async {
                                        List<NotiValueModel> notiList =
                                            await NotificationRepo()
                                                .getListNoti(
                                                    buildingId:
                                                        homeSelecteBuilding
                                                                ?.id ??
                                                            '-1',
                                                    show: 25,
                                                    page: 1,
                                                    type: '');
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ThongBaoDaTaoScreen(
                                              listNotiModel: notiList,
                                            ),
                                          ),
                                        );
                                      },
                                      child: SvgPicture.asset(
                                        'assets/icons/noti.svg',
                                        width: 24.w,
                                        height: 24.h,
                                        colorFilter: const ColorFilter.mode(
                                            Colors.white, BlendMode.srcIn),
                                      ),
                                    )
                                    // _buildIconButton(
                                    //   'chat_icon',
                                    //   () {
                                    //     Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const ListConversationScreen(),
                                    //       ),
                                    //     );
                                    //   },
                                    // ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              AppLocalizations.of(context)!.bqlXinChao,
                              style: defaultText16.copyWith(
                                color: Colors.white.withValues(alpha: 0.64),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    infoHomeModel.name,
                                    style: defaultText20B.copyWith(
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    pushScreenWithNavBar(
                                        context, const BqlPersonalScreen());
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => BqlPersonalScreen(
                                    //       infoModel: widget.infoModel,
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.r)),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.bqlTaiKhoan,
                                        style: defaultText12M.copyWith(
                                          color: const Color(0xff004071),
                                        ),
                                      ),
                                      SizedBox(width: 4.w),
                                      Icon(
                                        Icons.chevron_right,
                                        size: 18.dg,
                                        color: const Color(0xff004071),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                              //height: 40.h,
                              margin: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 16.h,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<BuildingModel>(
                                  isExpanded: true,
                                  value: homeSelecteBuilding,
                                  icon: const Icon(Icons.arrow_drop_down,
                                      color: Colors.black),
                                  dropdownColor:
                                      Colors.white, // nền của menu dropdown
                                  hint: Text(
                                    AppLocalizations.of(context)!.bqlChonToaNha,
                                    style: defaultText14M.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                  items: buildings.map((b) {
                                    return DropdownMenuItem(
                                      value: b,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/location.png',
                                            height: 20.5.h,
                                          ),
                                          SizedBox(width: 8.w),
                                          Expanded(
                                            child: Text(
                                              b.name,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: defaultText14M.copyWith(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    changeBuilding(value);
                                  },
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w, bottom: 10.h, right: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: AppLocalizations.of(context)!.bqlBanCo,
                        style: defaultText14Re,
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  '${_homeModel.listTechnicalRequests.length} yêu cầu',
                              style: defaultText14B),
                          TextSpan(text: AppLocalizations.of(context)!.bqlHoTroMoiTrongNgay),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Xử lý khi bấm vào "Xem tất cả"
                        // Ví dụ: Chuyển đến list yêu cầu hỗ trợ
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SupportRequestPage(
                              type: 1,
                              listBuild: widget.homeModel.listBuilding,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.bqlXemTatCa,
                        style: defaultText12M.copyWith(
                            color: const Color(0xff004071)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 16.w, right: 16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.only(
                  top: 6.h,
                  bottom: 9.h,
                ), // nếu cần
                child: Column(
                  children: List.generate(
                      _homeModel.listTechnicalRequests.length, (index) {
                    final item = _homeModel.listTechnicalRequests[index];
                    return RequestItem(
                      model: item,
                      onTap: () {
                        // Xử lý khi bấm vào
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RequestDetailScreen(
                              id: item.id,
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w, bottom: 10.h, right: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: AppLocalizations.of(context)!.bqlBanCo,
                        style: defaultText14Re,
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  '${_homeModel.listTechnicalRequestsChuaHT.length} yêu cầu',
                              style: defaultText14B),
                          const TextSpan(text: ' chưa được xử lý'),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Xử lý khi bấm vào "Xem tất cả"
                        // Ví dụ: Chuyển đến list yêu cầu hỗ trợ
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SupportRequestPage(
                              type: 1,
                              listBuild: widget.homeModel.listBuilding,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.bqlXemTatCa,
                        style: defaultText12M.copyWith(
                            color: const Color(0xff004071)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 16.w, right: 16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.only(
                  top: 6.h,
                  bottom: 9.h,
                ), // nếu cần
                child: Column(
                  children: List.generate(
                      _homeModel.listTechnicalRequestsChuaHT.length, (index) {
                    final item = _homeModel.listTechnicalRequestsChuaHT[index];
                    return RequestItem(
                      model: item,
                      onTap: () {
                        // Xử lý khi bấm vào
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RequestDetailScreen(
                              id: item.id,
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w, bottom: 10.h, top: 12.h),
                child: Text(
                  AppLocalizations.of(context)!.bqlBangTinToaNha,
                  style: defaultText16B,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: _homeModel.listCategoryModel.map((cat) {
                    final bool isSelected = cat.id == selectedCategoryId;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(cat.name),
                        selected: isSelected,
                        onSelected: (_) => fetchPostsByCategory(cat.id),
                        selectedColor: Colors.white,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Colors.lightBlue
                              : const Color(0xff8A8A8A),
                          fontSize: 14.sp,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.w600,
                        ),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: isSelected
                                ? Colors.lightBlue
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
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: SizedBox(
                  width: 375.w,
                  height: 250.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          bottomLeft: Radius.circular(16.r),
                        ),
                        child: SizedBox(
                          height: 230.h,
                          width: 375.w,
                          child: PageView.builder(
                            padEnds: false,
                            controller: controller3,
                            itemCount: posts.length,
                            itemBuilder: (_, index) {
                              final sortedPosts = [
                                ...posts.where((p) => p.type != '1'),
                                ...posts.where((p) => p.type == '1'),
                              ].reversed.toList();
                              return PostItem(
                                postModel: sortedPosts[index],
                              );
                            },
                          ),
                        ),
                      ),
                      _homeModel.listPostModel.length < 3
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
                                controller3.animateToPage(index,
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
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
    required this.postModel,
  });
  final PostModel postModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        PostModel detailModel =
            await HomeRepo().getDetailPostModel(postModel.id);
        pushWithoutNavBar(
          context,
          MaterialPageRoute(
            builder: ((context) => DetailPostScreen(
                  postModel: detailModel,
                )),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(16.r),
                ),
                border: Border.all(color: const Color(0xfff0f0f0))),
            child: Image.network(
              'https://bms.haduong.com.vn/images/${postModel.img}',
              width: 240.w,
              height: 160.h,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Text(
              postModel.name,
              style: defaultText14B,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class ApartmentDropdown extends StatelessWidget {
  final BuildingModel selectedApartment;
  final List<BuildingModel> apartmentList;
  final void Function(BuildingModel?) onChanged;

  const ApartmentDropdown({
    super.key,
    required this.selectedApartment,
    required this.apartmentList,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      width: 343.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(56.r)),
        color: Colors.white.withAlpha(30), // 12% of 255 ≈ 30
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<BuildingModel>(
          isExpanded: true,
          value: selectedApartment,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          dropdownColor: Colors.white,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          onChanged: onChanged,
          items: apartmentList
              .map(
                (apartment) => DropdownMenuItem<BuildingModel>(
                  value: apartment,
                  child: Text(apartment.name),
                ),
              )
              .toList(),
          selectedItemBuilder: (BuildContext context) {
            return apartmentList.map((apartment) {
              return Row(
                children: [
                  Image.asset(
                    'assets/images/location.png',
                    height: 20.5.h,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    apartment.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
