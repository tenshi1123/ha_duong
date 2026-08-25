import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/app.dart';
import 'package:ha_duong/models/chat_model.dart';
import 'package:ha_duong/models/info_model.dart';
import 'package:ha_duong/models/suport_model.dart';
import 'package:ha_duong/modules/bottomnavbar/support/request_screen.dart';
import 'package:ha_duong/modules/bottomnavbar/support/request_status_screen.dart';
import 'package:ha_duong/repo/chat_noti_repo.dart';
import 'package:ha_duong/repo/support_repo.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:ha_duong/utils/widget/custom_dialog.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ha_duong/l10n/app_localizations.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key, required this.id});
  final String id;

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> with RouteAware {
  late Future<List<TechnicalSupportModel>> _supportData;
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  void initState() {
    super.initState();
    _loadSupportData();
  }

  void _loadSupportData() {
    _supportData = SupportRepo().getSupportData(widget.id);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  // Hàm này tự chạy khi quay lại màn hình từ màn khác
  @override
  void didPopNext() {
    setState(() {
      _loadSupportData(); // Gọi lại API
    });
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffD9D9D9).withValues(alpha: 0.2),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              AppLocalizations.of(context)!.txtTrungTamHoTro,
              style: defaultText18B,
            ),
          ),
        ),
        // refresh indicator để kéo xuống làm mới dữ liệu
        body: RefreshIndicator(
          onRefresh: () async {
            _loadSupportData();
            setState(() {});
          },
          child: FutureBuilder<List<TechnicalSupportModel>>(
            future: _supportData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text(AppLocalizations.of(context)!.noData));
              }

              final data = snapshot.data!;
              // .where(
              //   (item) =>
              //       item.latestStatusType == '0' ||
              //       item.latestStatusType == null,
              // )
              // .toList();

              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          pushWithoutNavBar(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => RequestScreen(
                                    id: widget.id,
                                  )),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.supportList,
                              style: defaultText16B.copyWith(
                                color: const Color(0xff383838),
                              ),
                            ),
                            //arrow icon
                            Container(
                              margin: EdgeInsets.only(left: 10.w),
                              // width: 20.w,
                              // height: 20.h,
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: const Color(0xff383838),
                                size: 16.w,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      // Danh sách support items
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Column(
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length > 3 ? 3 : data.length,
                              itemBuilder: (context, index) {
                                final item = data[index];
                                return InkWell(
                                  onTap: () async {
                                    DetailTechnicalRequestModel detailRequest =
                                        await SupportRepo()
                                            .getRequestStatus(item.id);
                                    await pushWithoutNavBar(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) =>
                                            RequestStatusScreen(
                                              requestStatus: detailRequest
                                                  .listRequestStatus,
                                              createAt: item.createAt,
                                              technicalSupportModel: item,
                                            )),
                                      ),
                                    );
                                    _loadSupportData();
                                    setState(() {});
                                  },
                                  child: SupportItem(
                                    model: item,
                                    isdivider: data.length > 3
                                        ? index != 2
                                        : index != data.length - 1,
                                  ),
                                );
                              },
                            ),
                            data.length > 3
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 16.h, top: 10.h),
                                    child: InkWell(
                                      onTap: () {
                                        pushWithoutNavBar(
                                          context,
                                          MaterialPageRoute(
                                            builder: ((context) =>
                                                RequestScreen(
                                                  id: widget.id,
                                                )),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!.seeMore,
                                        style: defaultText14M.copyWith(
                                          color: const Color(0xff004071),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox()
                          ],
                        ),
                      ),

                      SizedBox(height: 24.h), // khoảng cách với row phía dưới

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              ChatModel model =
                                  await ChatRepo().getHomeChat(widget.id);
                              _makePhoneCall(model.hotline);
                              // pushWithoutNavBar(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => ChatScreen(
                              //       avatar: 'assets/images/avatar2.png',
                              //       chatModel: model,
                              //       apartmentId: widget.id,
                              //     ),
                              //   ),
                              // );
                            },
                            child: Container(
                              width: 150.w,
                              height: 86.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Image(
                                image: AssetImage(
                                    'assets/images/call_hotline.png'),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              List<PostModel> department =
                                  await SupportRepo().getDepartment(widget.id);
                              if (!context.mounted) return;
                              showPostDialog(context, department, widget.id);
                            },
                            child: Container(
                              width: 150.w,
                              height: 86.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Image(
                                image: AssetImage('assets/images/feedback.png'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),

                      // padding cuối
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class SupportItem extends StatelessWidget {
  const SupportItem({super.key, required this.model, required this.isdivider});
  final TechnicalSupportModel model;
  final bool isdivider;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 311.w,
      //height: index == 0 ? 76.h : 60.h,
      child: Column(
        children: [
          SizedBox(
            height: 12.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 16.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Text(model.settingSupportName,
                          style: defaultText14M.copyWith(
                            color: const Color(0xff383838),
                          )),
                      Container(
                        margin: EdgeInsets.only(left: 10.w),
                        // width: 20.w,
                        // height: 20.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          // common color
                          color: model.latestStatusType == null
                              ? const Color(0xff8A8A8A).withValues(alpha: 0.08)
                              : model.latestStatusType == '0'
                                  ? const Color(0xff004071)
                                      .withValues(alpha: 0.08)
                                  : model.latestStatusType == '1'
                                      ? const Color(0xff129F20)
                                          .withValues(alpha: 0.08)
                                      : const Color(0xffE80707)
                                          .withValues(alpha: 0.08),

                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(model.latestStatusName ?? AppLocalizations.of(context)!.unprocessedStatus,
                            style: defaultText14M.copyWith(
                              color: model.latestStatusType == null
                                  ? const Color(0xff8A8A8A)
                                  : model.latestStatusType == '0'
                                      ? const Color(0xff004071)
                                      : model.latestStatusType == '1'
                                          ? const Color(0xff129F20)
                                          : const Color(0xffE80707),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 290.w,
                    child: Text(
                      model.note,
                      style: defaultText14Re.copyWith(
                        color: const Color(0xff383838),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: const Color(0xff383838),
                size: 16.w,
              ),
              SizedBox(
                width: 16.w,
              ),
            ],
          ),
          isdivider
              ? Divider(
                  color: const Color(0xffD9D9D9),
                  thickness: 1,
                  indent: 16.w,
                  endIndent: 16.w,
                )
              : SizedBox(
                  height: 12.h,
                ),
        ],
      ),
    );
  }
}
