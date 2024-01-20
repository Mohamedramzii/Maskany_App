import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maskany_app/presentation/views/test_view.dart';
import '../../core/constants.dart';
import '../../data/data_sources/local/shared_pref.dart';
import 'AppLayout.dart';

import '../../core/app_resources/images.dart';
import 'Auth/login_view.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 2), (_) {
      Navigator.pushReplacement(
          context,
          PageAnimationTransition(
              page: CacheHelper.getData(key: tokenKey) != null
                  ? const AppLayout() //applayout instead
                  : const LoginView(),
              pageAnimationType: BottomToTopTransition()));
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 180.w,
          height: 212.h,
          child: Image.asset(
            Images.logo,
          ),
        ),
      ).animate().slide(
          duration: const Duration(seconds: 1),
          curve: Curves.easeInBack,
          begin: const Offset(-0.9, 0),
          end: const Offset(0, 0)),
    );
  }
}
