import 'package:arabic_font/arabic_font.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'core/constants.dart';
import 'presentation/view_model/CUBIT/cubit/app_cubit.dart';
import 'presentation/view_model/CUBIT/cubit/auth_cubit.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'classobserve.dart';
import 'core/app_resources/colors.dart';
import 'data/data_sources/local/shared_pref.dart';
import 'data/data_sources/network/dio_helper.dart';
import 'generated/l10n.dart';
import 'presentation/views/splash_screen_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.grey.shade100));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // isviewed = CacheHelper.getData(key: 'loc');

  // isviewed = await SessionManager().get('view') ?? false;
  // debugPrint(isviewed.toString());
  runApp(DevicePreview(
    builder: (context) => const MyApp(),
    enabled: !kReleaseMode,
  ));
  // Widget widget;
  CacheHelper.getData(key: tokenKey);
  debugPrint('USER TOKEN : ${CacheHelper.getData(key: tokenKey)}');

  // if(tokenHolder != null){
  //   widget= AppLayout();

  // }else{
  //   widget =
  // }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //  SystemUiOverlayStyle(statusBarColor: Colors.white);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthCubit(),
            ),
            BlocProvider(
                create: (context) => AppCubit()
                  ..checkLocationPermission(
                      Permission.locationWhenInUse, context)
                  // ..getCurrentLatLong()
                  ..getAllproperties()
                  ..getCategories()
                  ..getAllFavorites()

                // ..fillcategriesLists(),
                ),
            // BlocProvider(
            //   create: (context) => LocationCubit()
            //     ..getPermission(context)
            //     ..getCurrentLatLong(),
            // )
          ],
          child: MaterialApp(
            builder: (contexttt, child) => ResponsiveBreakpoints.builder(
              child: child!,
              breakpoints: [
                const Breakpoint(start: 0, end: 900, name: MOBILE),
                const Breakpoint(start: 901, end: 1400, name: TABLET),
                // const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                // const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
              ],
            ),
            debugShowCheckedModeBanner: false,
            title: 'Maskany',
            locale: const Locale('ar'),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              scaffoldBackgroundColor: Colors.grey.shade100,
              fontFamily: ArabicThemeData.font(
                arabicFont: ArabicFont.avenirArabic,
              ),
              package: ArabicThemeData.package,
              textTheme: TextTheme(
                  bodyLarge: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  bodySmall: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.xsmallFontColor),
                  bodyMedium: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                  displayLarge: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
            themeMode: ThemeMode.dark,
            home: const SplashScreen(),
          ),
        ),
      ),
    );
  }
}
