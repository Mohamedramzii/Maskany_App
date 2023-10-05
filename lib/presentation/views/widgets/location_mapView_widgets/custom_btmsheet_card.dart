import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../view_model/CUBIT/cubit/app_cubit.dart';
import '../../details_view.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

import '../../../../core/app_resources/colors.dart';
import '../../../../core/app_resources/fonts.dart';
import '../../../../core/app_resources/images.dart';
import '../../../../data/models/propertiesModel/propertiesModel.dart';

class CustomBtmsheetCard extends StatelessWidget {
  const CustomBtmsheetCard({super.key, required this.model});
  final PropertiesModel model;
  static double rate = 2.5;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<AppCubit>(context);
        return GestureDetector(
          onTap: () {
            Navigator.push(
                    context,
                    PageAnimationTransition(
                        page: DetailsView(
                          model: model,
                        ),
                        pageAnimationType: BottomToTopTransition()))
                .then((value) => cubit.viewed());
          },
          child: Card(
            shadowColor: Colors.black,
            elevation: 1,
            child: Container(
              width: double.infinity,
              height: 200.h,
              padding: EdgeInsets.all(5.r),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: ColorsManager.borderColor,
                  )),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150.w,
                        child: Text(
                          model.title,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Text(
                        model.city,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      RatingBar(
                        allowHalfRating: true,
                        initialRating: rate,
                        // tapOnlyMode: true,
                        // glow: true,
                        // glowColor: Colors.yellow, unratedColor: Colors.grey,
                        ignoreGestures: true,
                        itemSize: 20.r,
                        maxRating: 5,
                        minRating: 0,
                        ratingWidget: RatingWidget(
                            full: const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            half: const Icon(Icons.star_half,
                                color: Colors.yellow),
                            empty: const Icon(Icons.star, color: Colors.grey)),
                        onRatingUpdate: (value) => rate = value,
                      ),
                      Text(
                        '12 مشاهد',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        '${model.price} جنيه',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: ColorsManager.kprimaryColor,
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {},
                        color: ColorsManager.kprimaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r)),
                        minWidth: 140.w,
                        child: Text(
                          'أشتري الأن',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 7.w,
                  ),
                  Expanded(
                    child: Image.asset(
                      Images.villa,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
