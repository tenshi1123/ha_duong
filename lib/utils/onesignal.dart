import 'package:flutter/material.dart';
import 'package:ha_duong/app.dart';
import 'package:ha_duong/models/chat_model.dart';
import 'package:ha_duong/models/suport_model.dart';
import 'package:ha_duong/modules/bottomnavbar/support/request_status_screen.dart';
import 'package:ha_duong/modules/notification/detail_noti_screen.dart';
import 'package:ha_duong/modules/notification/detail_post_screen.dart';
import 'package:ha_duong/repo/chat_noti_repo.dart';
import 'package:ha_duong/repo/support_repo.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

// Future<void> initOneSignal() async {
//   OneSignal.initialize('de0e64c9-755d-49f3-a46c-c37b494cbfe2');
//   OneSignal.Notifications.requestPermission(true).then((value) {});
// }
// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> initOneSignal() async {
  OneSignal.initialize('de0e64c9-755d-49f3-a46c-c37b494cbfe2');
  OneSignal.Notifications.requestPermission(true).then((value) {});

  OneSignal.Notifications.addClickListener((event) async {
    final data = event.notification.additionalData;
    if (data != null) {
      String requestId = data['id'].toString();

      if (data['type'] == 'hotro') {
        DetailTechnicalRequestModel detailRequest =
            await SupportRepo().getRequestStatus(requestId);

        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (_) => RequestStatusScreen(
              requestStatus: detailRequest.listRequestStatus,
              createAt: detailRequest.technicalSupportModel.createAt,
              technicalSupportModel: detailRequest.technicalSupportModel,
            ),
          ),
        );
      } else if (data['type'] == 'thongbao') {
        NotiValueModel notiModel = await ChatRepo().getDetailNoti(requestId);

        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (_) => DetailNotiScreen(
              notiModel: notiModel,
            ),
          ),
        );
      } else if (data['type'] == 'bangtin') {
        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (_) => DetailPostScreen(
              postId: requestId,
            ),
          ),
        );
      }
    }
  });
}

void registerOneSignalEventListener({
  required Function(OSNotificationClickEvent) onOpened,
  required Function(OSNotificationClickResult) onReceivedInForeground,
}) {
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("de0e64c9-755d-49f3-a46c-c37b494cbfe2");
  OneSignal.Notifications.requestPermission(true);
}

const tagName = "userId";

void sendUserTag(int schoolId) {
  OneSignal.User.addTagWithKey("schoolId", schoolId);
}

void deleteUserTag() {
  OneSignal.User.removeTag("userId");
}
