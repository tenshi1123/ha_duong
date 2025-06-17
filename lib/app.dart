import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'modules/splash/splash_screen.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          navigatorObservers: [routeObserver],
          locale: const Locale('vi'),
          supportedLocales: const [
            Locale('vi'), // 🇻🇳 Tiếng Việt
            Locale('en'), // 🇺🇸 Tiếng Anh (nếu cần)
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          title: 'Hà Dương',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(
              fontSizeFactor: 1.sp,
              displayColor: Colors.black,
              bodyColor: Colors.black,
              decorationColor: Colors.black,
            ),
          ),
          home: const Splshscreen(),
          routes: const <String, WidgetBuilder>{},
        );
      },
    );
  }
}
