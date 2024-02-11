// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

// Project imports:
import 'package:maskany_app/presentation/view_model/CUBIT/cubit/app_cubit.dart';
import 'package:maskany_app/presentation/views/widgets/favoritesView_widgets/custom_horizontal_fav_items.dart';
import '../../core/app_resources/colors.dart';
import '../../core/app_resources/images.dart';

// import 'package:lottie/lottie.dart';


class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).getAllFavorites();
    super.initState();
  }

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
                    ).animate().slide(
                        begin: Offset(2, 0),
                        duration: Duration(milliseconds: 400)),
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
