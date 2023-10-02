import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'core/constants.dart';
import 'presentation/view_model/CUBIT/cubit/app_cubit.dart';
import 'presentation/view_model/CUBIT/cubit/auth_cubit.dart';
import 'presentation/views/AppLayout.dart';

import 'classobserve.dart';
import 'data/data_sources/local/shared_pref.dart';
import 'data/data_sources/network/dio_helper.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.white));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // isviewed = CacheHelper.getData(key: 'loc');

  isviewed = await SessionManager().get('view') ?? false;
  debugPrint(isviewed.toString());
  runApp(DevicePreview(
    builder: (context) => const MyApp(),
    enabled: !kReleaseMode,
  ));
  // Widget widget;
  // tokenHolder = CacheHelper.getData(key: tokenKey);
  // debugPrint('USER TOKEN : $tokenHolder');

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
                  ..getPermission(context)
                  ..getCurrentLatLong()
                  ..getAllproperties()),
            // BlocProvider(
            //   create: (context) => LocationCubit()
            //     ..getPermission(context)
            //     ..getCurrentLatLong(),
            // )
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Maskany',
            
            locale: const Locale('ar', 'EG'),
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
              // fontFamily: 
            ),
            themeMode: ThemeMode.dark,
            home: const AppLayout(),
          ),
        ),
      ),
    );
  }
}
