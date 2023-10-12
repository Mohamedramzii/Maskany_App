import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
// import 'package:lottie/lottie.dart';
import 'package:maskany_app/presentation/view_model/CUBIT/cubit/app_cubit.dart';
import 'package:maskany_app/presentation/views/widgets/favoritesView_widgets/custom_horizontal_items.dart';

import '../../core/app_resources/colors.dart';
import '../../core/app_resources/images.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<AppCubit>(context).getAllFavorites();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 16.h, right: 16.h, top: 16.h),
        child: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = BlocProvider.of<AppCubit>(context);
            if (cubit.allfavorites.isEmpty) {
              return state is! GetFavoritesLoadingState
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Lottie.asset(Images.emptySearch)),
                        Text(
                          'المفضلة لديك فارغة\n اضف الان!',
                          style: TextStyle(fontSize: 20.sp),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )
                  : Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                          color: ColorsManager.kprimaryColor, size: 35.r),
                    );
            } else {
              return Column(
                children: [
                  Text(
                    'المفضلة',
                    style: Theme.of(context).textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                  // Row(
                  //   children: [
                  //     Icon(Icons.location_on_outlined,
                  //         color: ColorsManager.kprimaryColor),
                  //     SizedBox(
                  //       width: 6.w,
                  //     ),
                  //     Text(
                  //       'السعودية, البارحة',
                  //       style: Theme.of(context).textTheme.bodySmall,
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                      child: GridView.builder(
                    // addAutomaticKeepAlives: true,
                    physics: const BouncingScrollPhysics(),
                    // shrinkWrap: false,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 6,
                            mainAxisSpacing: 8,
                            childAspectRatio: 0.78),
                    itemBuilder: (context, index) => CustomHorizontalFavItems(
                      favs: cubit.allfavorites,
                      index: index,
                    ),
                    itemCount: cubit.allfavorites.length,
                  ))
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
