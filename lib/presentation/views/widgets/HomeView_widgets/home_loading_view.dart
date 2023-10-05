import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maskany_app/presentation/views/widgets/HomeView_widgets/custom_textfield.dart';
import 'package:maskany_app/presentation/views/widgets/HomeView_widgets/hotizontal_shimmer.dart';
import 'package:maskany_app/presentation/views/widgets/HomeView_widgets/vertical_shimmer.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../core/app_resources/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../view_model/CUBIT/cubit/app_cubit.dart';

class HomeLoadingView extends StatelessWidget {
  const HomeLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade100,
      body: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
            child: Column(
              children: [
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              color: ColorsManager.kprimaryColor),
                          SizedBox(
                            width: 6.w,
                          ),
                          Text(
                            'السعودية, البارحة',
                            style: ResponsiveBreakpoints.of(context).isMobile
                                ? Theme.of(context).textTheme.bodySmall
                                : Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontSize: 8.sp),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        S.of(context).Welcome,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      const CustomTextField(),
                      // SizedBox(
                      //   height: 20.h,
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).NearestPlaces,
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text(S.of(context).SeeMore,
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                const HorizontalShimmer(),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).suggestedPlaces,
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text(
                      S.of(context).SeeMore,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                const VerticalShimmer()
              ],
            ),
          );
        },
      ),
    );
  }
}
