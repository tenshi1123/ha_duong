import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ha_duong/utils/onesignal.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app.dart';

ValueNotifier<List<File>> mainAvatarNotifier = ValueNotifier([]);
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Xử lý sync lại route và device orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  // KHÔNG cần .then lồng nhau
  await initializeDateFormatting();
  await initOneSignal();
  runApp(const App());
}
