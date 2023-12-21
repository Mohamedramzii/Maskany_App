import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import '../../data/models/propertiesModel/properties_model2/properties_model2.dart';
import '../view_model/CUBIT/cubit/app_cubit.dart';
import 'package:read_more_text/read_more_text.dart';
import '../../core/app_resources/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/common_widgets/custom_buttom.dart';
import 'widgets/HomeView_widgets/custom_rowIcons.dart';
import '../../core/app_resources/images.dart';
import '../../generated/l10n.dart';

class DetailsView extends StatefulWidget {
  const DetailsView({super.key, required this.model, this.index = 0});
  final PropertiesModel2 model;
  final int index;

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<AppCubit>(context);
        return WillPopScope(
          onWillPop: () async {
            //  await BlocProvider.of<AppCubit>(context).filterCategories(0);
            if (cubit.isNavigatetoDetailsFromMap) {
              await BlocProvider.of<AppCubit>(context)
                  .getAllpropertiesWithPagination(context: context);
              // setState(() {});
              debugPrint(
                  '################ User navigated back to Screen map ##############');
              cubit.isNavigatetoDetailsFromMap = false;
            } else {
              debugPrint('################ Not From Map Screen ##############');
            }
            return Future.value(true);
          },
          child: Scaffold(
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
                    // print('#*#*#*#*#*#* ${index} #*#*#*#*#*#');
                    cubit.favoritesID.contains(widget.model.id)
                        ? cubit.deleteFromFav(propertyID: widget.model.id!)
                        : cubit.addtoFavorites(id: widget.model.id);
                  },
                  child: Icon(
                    Icons.favorite,
                    color: cubit.favoritesID.contains(widget.model.id)
                        ? Colors.red
                        : Colors.grey,
                    size: ResponsiveBreakpoints.of(context).isMobile
                        ? 25.r
                        : 30.r,
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: ResponsiveBreakpoints.of(context).isMobile
                          ? 5.h
                          : 15.h,
                    ),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 200.0.h,
                        autoPlay: false,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        autoPlayInterval: const Duration(seconds: 1),
                      ),
                      items: widget.model.images!.map((i) {
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
                                  imageUrl:
                                      'http://66.45.248.247:8000${i.image}',
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                    child: LoadingAnimationWidget
                                        .staggeredDotsWave(
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
                      widget.model.title!,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      widget.model.city!,
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
                                text: '${widget.model.price}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: ColorsManager.kprimaryColor),
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
                        widget.model.details!,
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
                              count: widget.model.space!,
                              fontsize: 10,
                              style: Theme.of(context).textTheme.bodyMedium,
                              icon: const Text('م²')),
                          IconRow(
                              count: widget.model.bathrooms!,
                              icon: SvgPicture.asset(Images.shower),
                              style: Theme.of(context).textTheme.bodyMedium,
                              fontsize: 10),
                          IconRow(
                              count: widget.model.floor!,
                              icon: SvgPicture.asset(Images.chair),
                              style: Theme.of(context).textTheme.bodyMedium,
                              fontsize: 10),
                          IconRow(
                              count: widget.model.rooms!,
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
                          target: LatLng(double.parse(widget.model.lat!),
                              double.parse(widget.model.long!)),
                          zoom: 18,
                        ),
                        myLocationButtonEnabled: false,
                        myLocationEnabled: false,
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: false,

                        padding: const EdgeInsets.only(top: 100),
                        markers: {
                          Marker(
                              markerId: MarkerId('${widget.model.id}'),
                              infoWindow: InfoWindow(title: widget.model.title),
                              position: LatLng(double.parse(widget.model.lat!),
                                  double.parse(widget.model.long!)))
                        },
                        // onMapCreated: (GoogleMapController controller) {
                        //   cubit.googleMapController = controller;
                        //   // cubit.googleMapController!.setMapStyle(AutofillHints.);
                        // },

                        onTap: (latlong) {
                          cubit
                              .navigateToGoogleMaps(widget.model.locationLink!);
                        },
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
          ),
        );
      },
    );
  }
}
