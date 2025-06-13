import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../repo/login_repo.dart';

const oneSignalAppId = "";

Future<void> initOneSignal() async {
  OneSignal.initialize('de0e64c9-755d-49f3-a46c-c37b494cbfe2');
  OneSignal.Notifications.requestPermission(true).then((value) {});
  var onesignalId = await OneSignal.User.getOnesignalId();
  //await LoginRepo().pushOnesignalId(onesignalId ?? '');
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
