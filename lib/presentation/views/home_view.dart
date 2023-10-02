import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maskany_app/presentation/view_model/CUBIT/cubit/app_cubit.dart';
import 'package:page_animation_transition/animations/right_to_left_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

import '../../core/app_resources/colors.dart';
import '../../core/app_resources/fonts.dart';
import '../../generated/l10n.dart';
import 'details_view.dart';
import 'widgets/HomeView_widgets/custom_horizontalContainer.dart';
import 'widgets/HomeView_widgets/custom_textfield.dart';
import 'widgets/HomeView_widgets/custom_vertical_container.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade100,
      body: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BlocProvider.of<AppCubit>(context);
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
                            style: Fonts.xsmall,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(S.of(context).Welcome,
                          style: Theme.of(context).textTheme.headlineSmall),
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
                    Text(S.of(context).NearestPlaces, style: Fonts.medium),
                    Text(S.of(context).SeeMore),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 160.w,
                    maxWidth: 350.w,
                    maxHeight: 210.h,
                    minHeight: 200.h,
                  ),
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(PageAnimationTransition(
                                page:  DetailsView(
                                  model: cubit.property[index],
                                  index: index,
                                ),
                                pageAnimationType: RightToLeftTransition()));
                          },
                          child:  CustomHorizontalCOntainer(
                            model: cubit.property,
                            index:index
                          )),
                      separatorBuilder: (context, index) => SizedBox(
                            width: 20.w,
                          ),
                      itemCount: cubit.property.length),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).suggestedPlaces, style: Fonts.medium),
                    Text(
                      S.of(context).SeeMore,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) =>
                          const CustomVerticalContainer(),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 10.h,
                          ),
                      itemCount: 8),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
