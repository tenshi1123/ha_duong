import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'modules/splash/splash_screen.dart';
import 'l10n/app_localizations.dart';
import 'l10n/l10n.dart';
import 'cubit/language_cubit.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit(),
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            // Use builder only if you need to use library outside ScreenUtilInit context
            builder: (_, child) {
              return MaterialApp(
                locale: locale,
                navigatorKey: navigatorKey,
                navigatorObservers: [routeObserver],
                supportedLocales: L10n.all,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                debugShowCheckedModeBanner: false,
                onGenerateTitle: (context) => AppLocalizations.of(context)!.txtHaDuongHousing,
                // You can use the library anywhere in the app even in theme
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  textTheme: Typography.englishLike2018.apply(
                    fontSizeFactor: 1.sp,
                    displayColor: Colors.black,
                    bodyColor: Colors.black,
                    decorationColor: Colors.black,
                  ),
                  dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
                ),
                home: const Splshscreen(),
                routes: const <String, WidgetBuilder>{},
              );
            },
          );
        },
      ),
    );
  }
}
