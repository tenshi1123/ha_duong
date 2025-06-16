import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ha_duong/models/chat_model.dart';
import 'package:ha_duong/models/info_model.dart';
import 'package:ha_duong/models/suport_model.dart';
import 'package:ha_duong/modules/bottomnavbar/support/request_screen.dart';
import 'package:ha_duong/modules/bottomnavbar/support/request_status_screen.dart';
import 'package:ha_duong/modules/chat/chat_screen.dart';
import 'package:ha_duong/repo/chat_noti_repo.dart';
import 'package:ha_duong/repo/support_repo.dart';
import 'package:ha_duong/utils/constants/styles.dart';
import 'package:ha_duong/utils/widget/custom_dialog.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffD9D9D9).withValues(alpha: 0.2),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              'Trung tâm hỗ trợ',
              style: defaultText18B,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30.h, left: 16.w),
                child: InkWell(
                  onTap: () {
                    pushWithoutNavBar(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => RequestScreen(
                              id: id,
                            )),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        'Danh sách hỗ trợ',
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
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                //height: 224.h,
                width: 343.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: FutureBuilder<List<TechnicalSupportModel>>(
                  future: SupportRepo().getSupportData(id),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<TechnicalSupportModel>> snapshot) {
                    List<Widget> children;
                    if (snapshot.hasData) {
                      children = <Widget>[
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          //snapshot.data!.length > 3 ? 3 : snapshot.data!.length
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                List<RequestStatusModel> requestStatus =
                                    await SupportRepo().getRequestStatus(
                                        snapshot.data![index].id);
                                pushWithoutNavBar(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => RequestStatusScreen(
                                          requestStatus: requestStatus,
                                          createAt:
                                              snapshot.data![index].createAt,
                                          technicalSupportModel:
                                              snapshot.data![index],
                                        )),
                                  ),
                                );
                              },
                              child: SupportItem(
                                model: snapshot.data![index],
                                isdivider: snapshot.data![index] !=
                                    snapshot.data!.last,
                              ),
                            );
                          },
                        ),
                      ];
                    } else if (snapshot.hasError) {
                      children = <Widget>[
                        const Icon(Icons.error_outline,
                            color: Colors.red, size: 60),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text('Error: ${snapshot.error}'),
                        ),
                      ];
                    } else {
                      children = const <Widget>[
                        SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator()),
                        Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text('Awaiting result...')),
                      ];
                    }
                    return Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: children),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 16.w,
                  ),
                  GestureDetector(
                    onTap: () async {
                      ChatModel model = await ChatRepo().getHomeChat(id);
                      pushWithoutNavBar(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            avatar: 'assets/images/avatar2.png',
                            chatModel: model,
                            apartmentId: id,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 164.w,
                      height: 86.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: const Image(
                        image: AssetImage('assets/images/chat.png'),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      List<PostModel> department =
                          await SupportRepo().getDepartment(id);
                      if (!context.mounted) return;
                      showPostDialog(context, department, id);
                      // pushWithoutNavBar(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: ((context) => RequestScreen(
                      //           id: id,
                      //         )),
                      //   ),
                      // );
                    },
                    child: Container(
                      width: 164.w,
                      height: 86.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: const Image(
                        image: AssetImage('assets/images/feedback.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              )
            ],
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
                        padding: const EdgeInsets.all(5),
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
                        child: Text(model.latestStatusName ?? 'chưa xử lý',
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
                  Text(
                    model.note,
                    style: defaultText14Re.copyWith(
                      color: const Color(0xff383838),
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
                  height: 10.h,
                ),
        ],
      ),
    );
  }
}
