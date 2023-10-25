import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:responsive_framework/responsive_framework.dart';

import '../../../../core/app_resources/colors.dart';
import '../../../../core/app_resources/images.dart';
import '../../../../data/models/propertiesModel/properties_model2/properties_model2.dart';
import '../../../view_model/CUBIT/cubit/app_cubit.dart';
import 'custom_rowIcons.dart';

class CustomHorizontalCOntainer extends StatelessWidget {
  const CustomHorizontalCOntainer({
    super.key,
    required this.model,
    required this.index,
  });
  final List<PropertiesModel2> model;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.topR,
      height: 330.h,
      width: 230.w,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
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
                child: CachedNetworkImage(
                  imageUrl:
                      'http://66.45.248.247:8000${model[index].images![0].image}',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                        color: ColorsManager.kprimaryColor, size: 40.r),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(Icons.image_not_supported_rounded),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: ResponsiveBreakpoints.of(context).isMobile
                      ? 240.w
                      : 250.w,
                  child: Text(
                    model[index].title!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15.sp),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('#*#*#*#*#*#* ${index} #*#*#*#*#*#');
                    print('#*#*#*#*#*#* ${model[index].id} #*#*#*#*#*#');
                    BlocProvider.of<AppCubit>(context)
                            .favoritesID
                            .contains(model[index].id)
                        ? BlocProvider.of<AppCubit>(context)
                            .deleteFromFav(propertyID: model[index].id!)
                        : BlocProvider.of<AppCubit>(context)
                            .addtoFavorites(id: model[index].id);
                  },
                  child: Icon(
                    Icons.favorite,
                    color: BlocProvider.of<AppCubit>(context)
                            .favoritesID
                            .contains(model[index].id)
                        ? Colors.red
                        : Colors.grey,
                    size: ResponsiveBreakpoints.of(context).isMobile
                        ? 25.r
                        : 30.r,
                  ),
                ),
              ],
            ),
            Text(
              model[index].city!,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontSize: 10.sp),
            ),
            Text(
              model[index].rent! == true
                  ? '${model[index].price.toString()}  جنيه شهريأ'
                  : '${model[index].price.toString()} جنيه',
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
                  width: 155.w,
                ),
                IconRow(
                    count: model[index].space!,
                    fontsize: 10,
                    icon: const Text('م²')),
                IconRow(
                    count: model[index].bathrooms!,
                    fontsize: 10,
                    icon: SvgPicture.asset(
                      Images.shower,
                      width: 15.w,
                    )),
                IconRow(
                    count: model[index].floor!,
                    fontsize: 10,
                    icon: SvgPicture.asset(
                      Images.chair,
                      width: 15.w,
                    )),
                IconRow(
                    count: model[index].rooms!,
                    fontsize: 10,
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
