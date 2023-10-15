import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maskany_app/data/data_sources/local/shared_pref.dart';
import 'package:maskany_app/presentation/view_model/CUBIT/cubit/app_cubit.dart';
import 'package:maskany_app/presentation/view_model/CUBIT/cubit/auth_cubit.dart';
import 'package:maskany_app/presentation/views/Auth/login_view.dart';
import 'package:maskany_app/presentation/views/global_settings_view.dart';
import 'package:maskany_app/presentation/views/packages_view.dart';
import 'package:maskany_app/presentation/views/profile_settings_view.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/animations/right_to_left_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

import '../../core/app_resources/images.dart';
import '../../core/constants.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الحساب',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BlocProvider.of<AuthCubit>(context);
          return Padding(
            padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.r),
                    child: Container(
                      width: 100.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.r)),
                      child: cubit.userdata?.image != null
                          ? Image.network(cubit.userdata!.image!,
                              fit: BoxFit.cover)
                          : cubit.image != null
                              ? Image.file(
                                  cubit.image!,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(Images.profile, fit: BoxFit.cover),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  cubit.userdata!.username ?? '',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  cubit.userdata!.email ?? '',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(
                  height: 20.h,
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(PageAnimationTransition(
                        page: ProfileSettingsVIew(
                          email: cubit.userdata!.email!,
                          phoneNumber: cubit.userdata!.phoneNumber == null
                              ? 'أضف رقم الهاتف'
                              : cubit.userdata!.phoneNumber!,
                        ),
                        pageAnimationType: RightToLeftTransition()));
                  },
                  leading: const Icon(Icons.info_outline_rounded),
                  title: Text(
                    'معلومات شخصية',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20.r,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(PageAnimationTransition(
                        page: PackagesView(),
                        pageAnimationType: RightToLeftTransition()));
                  },
                  leading: const Icon(Icons.diamond_rounded),
                  title: Text(
                    'الباقات',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20.r,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(PageAnimationTransition(
                        page: const GlobalSettingsView(),
                        pageAnimationType: RightToLeftTransition()));
                  },
                  leading: const Icon(Icons.settings),
                  title: Text(
                    'الاعدادات',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20.r,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.location_on),
                  title: Text(
                    cubit.userdata!.location ?? 'غير محدد',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.add_card),
                  title: Text(
                    'طرق الدفع',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: SizedBox(
                    width: 155.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset(Images.visa),
                        SizedBox(
                          width: 10.w,
                        ),
                        Image.asset(
                          'assets/images/pngegg.png',
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        PageAnimationTransition(
                            page: const LoginView(),
                            pageAnimationType: BottomToTopTransition()));
                    BlocProvider.of<AppCubit>(context).btmNavBar(0);

                    CacheHelper.clearData(key: tokenHolder);
                  },
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  title: Text(
                    'تسجيل الخروج',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.red),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
