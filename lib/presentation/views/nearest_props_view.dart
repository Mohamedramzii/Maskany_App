import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maskany_app/presentation/view_model/CUBIT/cubit/app_cubit.dart';
import 'package:maskany_app/presentation/views/details_view.dart';
import 'package:page_animation_transition/animations/right_to_left_faded_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

import 'widgets/HomeView_widgets/custom_vertical_container.dart';

class NearestPropsView extends StatelessWidget {
  const NearestPropsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50.h, left: 20.w, right: 20.w),
        child: Column(
          children: [
            const Text('الأماكن القريبة منك'),
            Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            PageAnimationTransition(
                                page: DetailsView(
                                    model: BlocProvider.of<AppCubit>(context)
                                        .nearestPlaces[index]),
                                pageAnimationType:
                                    RightToLeftFadedTransition())),
                        child: CustomVerticalContainer(
                            model: BlocProvider.of<AppCubit>(context)
                                .nearestPlaces[index],
                            index: index),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 20.h,
                        ),
                    itemCount: BlocProvider.of<AppCubit>(context)
                        .nearestPlaces
                        .length))
          ],
        ),
      ),
    );
  }
}
