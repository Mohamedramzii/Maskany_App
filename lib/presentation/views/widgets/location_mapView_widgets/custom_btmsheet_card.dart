// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

// Project imports:
import '../../../../core/app_resources/colors.dart';
import '../../../../data/models/propertiesModel/properties_model2/properties_model2.dart';
import '../../../view_model/CUBIT/cubit/app_cubit.dart';
import '../../details_view.dart';

class CustomBtmsheetCard extends StatelessWidget {
  const CustomBtmsheetCard({
    Key? key,
    required this.model,
  }) : super(key: key);
  final PropertiesModel2 model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<AppCubit>(context);
        return GestureDetector(
          onTap: () async {
            // Navigator.of(context).pop();
            cubit.seenOrnot(propertyID: model.id,context: context);
            Navigator.of(context).pop();

            Navigator.push(
                context,
                PageAnimationTransition(
                    page: DetailsView(
                      // model: model ?? PropertiesModel2(),
                      model: model,
                    ),
                    pageAnimationType: BottomToTopTransition()));
          },
          child: Card(
            shadowColor: Colors.black,
            elevation: 5,
            surfaceTintColor: Colors.white,
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
                          model.title!,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          model.city!,
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      // RatingBar(
                      //   allowHalfRating: true,
                      //   initialRating: rate,
                      //   // tapOnlyMode: true,
                      //   // glow: true,
                      //   // glowColor: Colors.yellow, unratedColor: Colors.grey,
                      //   ignoreGestures: true,
                      //   itemSize: 20.r,
                      //   maxRating: 5,
                      //   minRating: 0,
                      //   ratingWidget: RatingWidget(
                      //       full: const Icon(
                      //         Icons.star,
                      //         color: Colors.yellow,
                      //       ),
                      //       half: const Icon(Icons.star_half,
                      //           color: Colors.yellow),
                      //       empty: const Icon(Icons.star, color: Colors.grey)),
                      //   onRatingUpdate: (value) => rate = value,
                      // ),
                      // Text(
                      //   '12 مشاهد',
                      //   style: Theme.of(context).textTheme.bodySmall,
                      // ),
                      Text(
                        '${model.price} جنيه',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: ColorsManager.kprimaryColor,
                            ),
                      ),
                      MaterialButton(
                        onPressed: () {
                           cubit.navigateToWhatsapp(
                            model.phoneNumber == null
                                ? '01111111111'
                                : model.phoneNumber!);
                        },
                        color: ColorsManager.kprimaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r)),
                        minWidth: 140.w,
                        child: Text(
                          'أشتري الأن',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 7.w,
                  ),
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl:
                          'http://66.45.248.247:8000${model.images![0].image}',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
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
