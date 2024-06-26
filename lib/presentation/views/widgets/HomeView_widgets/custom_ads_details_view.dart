// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

// Project imports:
import 'package:maskany_app/data/models/ads_model/property.dart';
import '../../../../core/app_resources/colors.dart';
import '../../../../core/app_resources/images.dart';
import '../../../../core/common_widgets/custom_buttom.dart';
import '../../../../generated/l10n.dart';
import '../../../view_model/CUBIT/cubit/app_cubit.dart';
import 'custom_rowIcons.dart';

class CustomAdsDetailsView extends StatelessWidget {
  const CustomAdsDetailsView({
    super.key,
    required this.model,
    required this.index,
  });
  final List<Property> model;
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
              GestureDetector(
                onTap: () {
                  print('#*#*#*#*#*#* ${index} #*#*#*#*#*#');
                  cubit.favoritesID.contains(model[index].id)
                      ? cubit.deleteFromFav(propertyID: model[index].id!)
                      : cubit.addtoFavorites(id: model[index].id);
                },
                child: Icon(
                  Icons.favorite,
                  color: cubit.favoritesID.contains(model[index].id)
                      ? Colors.red
                      : Colors.grey,
                  size:
                      ResponsiveBreakpoints.of(context).isMobile ? 25.r : 30.r,
                ),
              ),
              // Visibility(
              //   visible:
              //       cubit.allfavorites.any((e) => e.id == model[index].id),

              // replacement:

              // Visibility(
              //   visible: cubit.allfavorites
              //       .any((element) => element.property!.id == model[index].id),

              //   replacement: GestureDetector(
              //     onTap: () {
              //       print('#*#*#*#*#*#* ${index} #*#*#*#*#*#');
              //       cubit.addtoFavorites(id: model[index].id);
              //     },
              //     child: Icon(
              //       Icons.favorite_border_outlined,
              //       color: Colors.grey,
              //       size: ResponsiveBreakpoints.of(context).isMobile
              //           ? 25.r
              //           : 30.r,
              //     ),
              //   ),
              //   // maintainAnimation: true,
              //   child: GestureDetector(
              //     onTap: () {
              //       print('#*#*#*#*#*#* ${index} #*#*#*#*#*#');

              //       if (index >= cubit.allfavorites.length) {
              //         print('+++++++ LAST +++++++++');
              //         Future.delayed(
              //           const Duration(milliseconds: 300),
              //           () => cubit.btmNavBar(1),
              //         );
              //         Navigator.of(context).pop();
              //       } else {
              //         cubit.deleteFromFav(
              //             propertyID: cubit.allfavorites[index].id!);
              //       }
              //     },
              //     child: Icon(
              //       Icons.delete,
              //       color: Colors.red,
              //       size: ResponsiveBreakpoints.of(context).isMobile
              //           ? 25.r
              //           : 30.r,
              //     ),
              //   ),
              // ),
              SizedBox(
                width: 15.w,
              ),
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
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 200.0.h,
                      autoPlay: false,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      autoPlayInterval: const Duration(seconds: 1),
                    ),
                    items: model[index].images!.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 3.0.w),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  ResponsiveBreakpoints.of(context).isMobile
                                      ? 15.r
                                      : 5.r),
                              child: CachedNetworkImage(
                                imageUrl: 'http://66.45.248.247:8000${i.image}',
                                fit: BoxFit.fill,
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
                            ),
                          );
                        },
                      );
                    }).toList(),
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
                          // RatingBar(
                          //   allowHalfRating: true,
                          //   initialRating: cubit.rate,
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
                          //       empty:
                          //           const Icon(Icons.star, color: Colors.grey)),
                          //   onRatingUpdate: (value) => cubit.rate = value,
                          // ),
                          // Text(
                          //   '12 مشاهد',
                          //   style: Theme.of(context).textTheme.bodySmall,
                          // ),
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
                            fontsize: 10,
                            style: Theme.of(context).textTheme.bodyMedium,
                            icon: const Text('م²')),
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
                  // Container(
                  //   width: double.infinity,
                  //   height: ResponsiveBreakpoints.of(context).isMobile
                  //       ? 60.h
                  //       : 80.h,
                  //   padding:
                  //       EdgeInsets.symmetric(horizontal: 15.w, vertical: 7.h),
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10.r),
                  //       color: ColorsManager.containerColor),
                  //   child: Row(
                  //     children: [
                  //       CircleAvatar(
                  //         radius: 25.r,
                  //         backgroundImage: const AssetImage(Images.profile),
                  //       ),
                  //       SizedBox(
                  //         width: 8.w,
                  //       ),
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             'احمد محمد',
                  //             style: Theme.of(context).textTheme.bodyMedium,
                  //           ),
                  //           Text(
                  //             'السعودية , الخرج',
                  //             style: Theme.of(context).textTheme.bodySmall,
                  //           ),
                  //         ],
                  //       )
                  //     ],
                  //   ),
                  // ),
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

                      onTap: (latlong) {
                        cubit.navigateToGoogleMaps(model[index].locationLink!);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomButton(text: 'تواصل مع المالك', onpressed: () {
                     cubit.navigateToWhatsapp(
                            model[index].phoneNumber == null
                                ? '01111111111'
                                : model[index].phoneNumber!);
                  }),
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
