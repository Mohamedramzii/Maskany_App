// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_animation_transition/animations/right_to_left_faded_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

// Project imports:
import 'package:maskany_app/data/models/propertiesModel/properties_model2/properties_model2.dart';
import 'package:maskany_app/presentation/views/detailsForhorizontal.dart';
import '../../../../core/app_resources/colors.dart';
import '../../../../core/app_resources/images.dart';
import '../../../view_model/CUBIT/cubit/app_cubit.dart';
import '../HomeView_widgets/custom_rowIcons.dart';

class CustomHorizontalFavItems extends StatelessWidget {
  const CustomHorizontalFavItems({
    Key? key,
    required this.favs,
    required this.index,
  }) : super(key: key);
  final List<PropertiesModel2> favs;
  final int index;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return state is GetFavoritesLoadingState
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : FittedBox(
                child: Container(
                  width: 190.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(PageAnimationTransition(
                              page: DetailsViewForHorizontal(
                                model:
                                    BlocProvider.of<AppCubit>(context).allfavorites,
                                index: index,
                              ),
                              pageAnimationType: RightToLeftFadedTransition()));
                        },
                        child: SizedBox(
                            width: 170.w,
                            // width: double.infinity,
                            height: 140.h,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6.r),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'http://66.45.248.247:8000${favs[index].images![0].image}',
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Center(
                                  child:
                                      LoadingAnimationWidget.staggeredDotsWave(
                                          color: ColorsManager.kprimaryColor,
                                          size: 40.r),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Center(
                                  child:
                                      Icon(Icons.image_not_supported_rounded),
                                ),
                                errorListener: (value) => const Center(
                                  child:
                                      Icon(Icons.image_not_supported_rounded),
                                ),
                              ),
                            )),
                      ),
                      // SizedBox(height: 20.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 140.w,
                            child: Text(
                              favs[index].title!,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 10.sp),
                            ),
                          ),
                          BlocBuilder<AppCubit, AppState>(
                            builder: (context, state) {
                              var cubit = BlocProvider.of<AppCubit>(context);
                              return GestureDetector(
                                onTap: () {
                                  cubit.deleteFromFavortiteView(
                                      favID: favs[index].id!);
                                },
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size:
                                      ResponsiveBreakpoints.of(context).isMobile
                                          ? 25.r
                                          : 30.r,
                                ),
                              );
                            },
                          )
                        ],
                      ),
                      Text(
                        favs[index].city!,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 6.sp),
                      ),
                      Text(
                        'شهريأ / ${favs[index].price.toString()}',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 10.sp)
                            .copyWith(color: ColorsManager.kprimaryColor),
                      ),
                      // SizedBox(height: 10.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // SizedBox(
                          //   width: 105.w,
                          // ),
                          IconRow(
                              count: favs[index].bathrooms!,
                              fontsize: 8,
                              icon: SvgPicture.asset(
                                Images.size,
                                width: 15.w,
                              )),
                          IconRow(
                              count: 25,
                              fontsize: 8,
                              icon: SvgPicture.asset(
                                Images.shower,
                                width: 15.w,
                              )),
                          IconRow(
                              count: 25,
                              fontsize: 8,
                              icon: SvgPicture.asset(
                                Images.chair,
                                width: 15.w,
                              )),
                          IconRow(
                              count: 25,
                              fontsize: 8,
                              icon: SvgPicture.asset(
                                Images.bed,
                                width: 15.w,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              );
      },
    );
  }
}
