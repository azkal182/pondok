import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:pondok/app_router.dart';
import 'package:pondok/core/theme.dart';
import 'package:pondok/presentation/pages/home/blocs/poster_bloc.dart';
import 'package:pondok/presentation/pages/home/blocs/prayer_times_bloc.dart';
import 'package:pondok/presentation/pages/home/pages/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  HijriCalendar.setLocal('en');
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => di.sl<PrayerTimesBloc>(),
            ),
            BlocProvider(
              create: (_) => di.sl<PosterBloc>()..add(FetchPostersEvent()),
            ),
          ],
          child: MaterialApp.router(
            localizationsDelegates: const <LocalizationsDelegate<Object>>[
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const <Locale>[
              Locale('en', 'US'),
              Locale('id', 'ID'),
            ],
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            routerConfig: appRouter(),
          ),
        );
      },
      child: HomePage(),
    );
  }
}
