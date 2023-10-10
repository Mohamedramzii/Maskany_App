import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import '../../data/models/propertiesModel/properties_model2/properties_model2.dart';
import '../view_model/CUBIT/cubit/app_cubit.dart';
import 'package:read_more_text/read_more_text.dart';
import '../../core/app_resources/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/common_widgets/custom_buttom.dart';
import '../../data/models/propertiesModel/propertiesModel.dart';
import 'widgets/HomeView_widgets/custom_rowIcons.dart';
import '../../core/app_resources/images.dart';
import '../../generated/l10n.dart';

class DetailsViewForHorizontal extends StatelessWidget {
  const DetailsViewForHorizontal({
    super.key,
    required this.model,
    required this.index,
  });
  final List<PropertiesModel2> model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<AppCubit>(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 3,
            title: Text(
              'تفاصيل المنزل',
              style: ResponsiveBreakpoints.of(context).isMobile
                  ? Theme.of(context).textTheme.displayLarge
                  : Theme.of(context).textTheme.bodyMedium,
            ),
            centerTitle: true,
            actions: [
              // Visibility(
              //   visible:
              //       cubit.allfavorites.any((e) => e.id == model[index].id),

              // replacement:
            
              Visibility(
                visible: cubit.allfavorites
                    .any((element) => element.property!.id == model[index].id),

                replacement: GestureDetector(
                  onTap: () {
                    print('#*#*#*#*#*#* ${index} #*#*#*#*#*#');
                    cubit.addtoFavorites(id: model[index].id);
                  },
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: ResponsiveBreakpoints.of(context).isMobile
                        ? 25.r
                        : 30.r,
                  ),
                ),
                // maintainAnimation: true,
                child: GestureDetector(
                  onTap: () {
                    print('#*#*#*#*#*#* ${index} #*#*#*#*#*#');
                    cubit.deleteFromFav(
                        favoriteItemID: cubit.allfavorites[index].id!);
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: ResponsiveBreakpoints.of(context).isMobile
                        ? 25.r
                        : 30.r,
                  ),
                ),
              ),
              SizedBox(width: 5.w,),
              //   // maintainAnimation: true,
              //   child: GestureDetector(
              //     onTap: () {
              //       // print('#*#*#*#*#*#* ${index} #*#*#*#*#*#');
              //       // cubit.deleteFromFav(favoriteItemID: cubit.allfavorites.id);
              //     },
              //     child: Icon(
              //       Icons.favorite_rounded,
              //       color: Colors.red,
              //       size: ResponsiveBreakpoints.of(context).isMobile
              //           ? 25.r
              //           : 30.r,
              //     ),
              //   ),
              // )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height:
                        ResponsiveBreakpoints.of(context).isMobile ? 5.h : 15.h,
                  ),
                  SizedBox(
                    height: 200.h,
                    width: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            ResponsiveBreakpoints.of(context).isMobile
                                ? 15.r
                                : 5.r),
                        //!Hero
                        child: SvgPicture.asset(
                          Images.houseS,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 23.h,
                  ),
                  Text(
                    model[index].title!,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    model[index].city!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          RatingBar(
                            allowHalfRating: true,
                            initialRating: cubit.rate,
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
                                empty:
                                    const Icon(Icons.star, color: Colors.grey)),
                            onRatingUpdate: (value) => cubit.rate = value,
                          ),
                          Text(
                            '12 مشاهد',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      RichText(
                          text: TextSpan(
                              text: '${model[index].price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: ColorsManager.kprimaryColor),
                              children: [
                            TextSpan(
                                text: 'جنيه مصري',
                                style: Theme.of(context).textTheme.bodySmall)
                          ]))
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    S.of(context).homeDesc,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  ReadMoreText(
                      // "فاخرة بتجهيزات فندقية في حي العقيق شمال الرياض تتميز بالهدوء والخصوصية، تبعد 5 دقائق عن منطقة البوليڤارد و الرياض بارك وقريبه جدا من جميع الخدمات الصحية والترفيهية",
                      model[index].details!,
                      numLines: 2,
                      style: Theme.of(context).textTheme.bodySmall,
                      readMoreText: 'المزيد',
                      readLessText: 'اقل'),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    width: double.infinity,
                    height: 40.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(color: Colors.grey, blurRadius: 1.5),
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconRow(
                            count: model[index].space!,
                            icon: SvgPicture.asset(Images.size),
                            style: Theme.of(context).textTheme.bodyMedium,
                            fontsize: 10),
                        IconRow(
                            count: model[index].bathrooms!,
                            icon: SvgPicture.asset(Images.shower),
                            style: Theme.of(context).textTheme.bodyMedium,
                            fontsize: 10),
                        IconRow(
                            count: model[index].floor!,
                            icon: SvgPicture.asset(Images.chair),
                            style: Theme.of(context).textTheme.bodyMedium,
                            fontsize: 10),
                        IconRow(
                            count: model[index].rooms!,
                            icon: SvgPicture.asset(Images.bed),
                            style: Theme.of(context).textTheme.bodyMedium,
                            fontsize: 10),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    width: double.infinity,
                    height: ResponsiveBreakpoints.of(context).isMobile
                        ? 60.h
                        : 80.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 7.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: ColorsManager.containerColor),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25.r,
                          backgroundImage: const AssetImage(Images.profile),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'احمد محمد',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              'السعودية , الخرج',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(S.of(context).places,
                      style: Theme.of(context).textTheme.bodyMedium),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    width: double.infinity,
                    height: 175.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: GoogleMap(
                      compassEnabled: false,
                      // indoorViewEnabled: true,
                      mapToolbarEnabled: false,

                      mapType: MapType.hybrid,
                      // cloudMapId: '961ba1ad7f1204e8',
                      initialCameraPosition: CameraPosition(
                        target: LatLng(double.parse(model[index].lat!),
                            double.parse(model[index].long!)),
                        zoom: 18,
                      ),
                      myLocationButtonEnabled: false,
                      myLocationEnabled: false,
                      zoomControlsEnabled: false,
                      zoomGesturesEnabled: false,

                      padding: const EdgeInsets.only(top: 100),
                      markers: {
                        Marker(
                            markerId: const MarkerId('homeLocation'),
                            infoWindow: InfoWindow(title: model[index].title),
                            position: LatLng(double.parse(model[index].lat!),
                                double.parse(model[index].long!)))
                      },
                      // onMapCreated: (GoogleMapController controller) {
                      //   cubit.googleMapController = controller;
                      //   // cubit.googleMapController!.setMapStyle(AutofillHints.);
                      // },

                      onTap: (latlong) {},
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomButton(text: 'أشتري الأن', onpressed: () {}),
                  SizedBox(
                    height: 30.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
