import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maskany_app/presentation/view_model/CUBIT/cubit/app_cubit.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../data/models/propertiesModel/propertiesModel.dart';

import '../../../../core/app_resources/colors.dart';
import '../../../../core/app_resources/images.dart';
import 'custom_rowIcons.dart';

class CustomHorizontalCOntainer extends StatelessWidget {
  const CustomHorizontalCOntainer({
    super.key,
    required this.model,
    required this.index,
  });
  final List<PropertiesModel> model;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.topR,
      height: 330.h,
      width: 230.w,
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(15.r)),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: FittedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 260.w,
              height: 170.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: Hero(
                  tag: model[index].title,
                  child: SvgPicture.asset(
                    Images.houseS,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: ResponsiveBreakpoints.of(context).isMobile
                      ? 230.w
                      : 240.w,
                  child: Text(
                    model[index].title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15.sp),
                  ),
                ),
                BlocBuilder<AppCubit, AppState>(
                  builder: (context, state) {
                    var cubit = BlocProvider.of<AppCubit>(context);
                    return Visibility(
                      visible: cubit.allfavorites
                          .any((e) => e.property!.id == model[index].id),

                      replacement: GestureDetector(
                        onTap: () {
                          cubit.addtoFavorites(id: model[index].id);
                        },
                        child: Icon(
                          Icons.favorite_border,
                          size: ResponsiveBreakpoints.of(context).isMobile
                              ? 25.r
                              : 30.r,
                        ),
                      ),
                      // maintainAnimation: true,
                      child: GestureDetector(
                        onTap: () {
                          print(cubit.allfavorites[index].id);
                          cubit.deleteFromFav(
                              favoriteItemID: cubit.allfavorites[index].id);
                        },
                        child: Icon(
                          Icons.favorite_rounded,
                          color: Colors.red,
                          size: ResponsiveBreakpoints.of(context).isMobile
                              ? 25.r
                              : 30.r,
                        ),
                      ),
                    );
                    //  (cubit.allfavorites
                    //         .map((e) => e.property!.id)
                    //         .contains(model[index].id) )
                    //     ? GestureDetector(
                    //       onTap: (){
                    //         print(cubit.allfavorites[index].id);
                    //         cubit.deleteFromFav(favoriteItemID: cubit.allfavorites[index].id);

                    //       },
                    //       child: Icon(
                    //           Icons.favorite_rounded,
                    //           color: Colors.red,
                    //           size: ResponsiveBreakpoints.of(context).isMobile
                    //               ? 25.r
                    //               : 30.r,
                    //         ),
                    //     )
                    //     : GestureDetector(
                    //       onTap: (){
                    //          cubit.addtoFavorites(id: model[index].id);
                    //       },
                    //       child: Icon(
                    //           Icons.favorite_border,
                    //           size: ResponsiveBreakpoints.of(context).isMobile
                    //               ? 25.r
                    //               : 30.r,
                    //         ),
                    //     );
                  },
                )
              ],
            ),
            Text(
              model[index].city,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: 10.sp),
            ),
            Text(
              'شهريأ / ${model[index].price.toString()}',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: 15.sp)
                  .copyWith(color: ColorsManager.kprimaryColor),
            ),
            // SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 140.w,
                ),
                IconRow(
                    count: model[index].bathrooms,
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
  }
}
