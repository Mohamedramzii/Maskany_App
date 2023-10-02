import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maskany_app/presentation/view_model/CUBIT/cubit/app_cubit.dart';
import 'package:read_more_text/read_more_text.dart';
import '../../core/app_resources/colors.dart';
import '../../core/app_resources/fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/common_widgets/custom_buttom.dart';
import '../../data/models/propertiesModel/propertiesModel.dart';
import 'widgets/HomeView_widgets/custom_rowIcons.dart';
import '../../core/app_resources/images.dart';
import '../../generated/l10n.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key, required this.model, this.index=0});
  final PropertiesModel model;
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
              style: Fonts.large,
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ))
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: SvgPicture.asset(
                      Images.houseS,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: 23.h,
                  ),
                  Text(
                    model.title,
                    style: Fonts.semiLarge,
                  ),
                  Text(
                    model.city,
                    style: Fonts.xsmall,
                  ),
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
                            empty: const Icon(Icons.star, color: Colors.grey)),
                        onRatingUpdate: (value) => cubit.rate = value,
                      ),
                      Text(
                        '12 مشاهد',
                        style: Fonts.xsmall,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    S.of(context).homeDesc,
                    style: Fonts.semiLarge,
                  ),
                  ReadMoreText(
                      // "فاخرة بتجهيزات فندقية في حي العقيق شمال الرياض تتميز بالهدوء والخصوصية، تبعد 5 دقائق عن منطقة البوليڤارد و الرياض بارك وقريبه جدا من جميع الخدمات الصحية والترفيهية",
                      model.details,
                      numLines: 2,
                      style: Fonts.xsmall,
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
                            count: model.space,
                            icon: SvgPicture.asset(Images.size),
                            style: Fonts.medium,
                            fontsize: 10),
                        IconRow(
                            count: model.bathrooms,
                            icon: SvgPicture.asset(Images.shower),
                            style: Fonts.medium,
                            fontsize: 10),
                        IconRow(
                            count: model.floor,
                            icon: SvgPicture.asset(Images.chair),
                            style: Fonts.medium,
                            fontsize: 10),
                        IconRow(
                            count: model.rooms,
                            icon: SvgPicture.asset(Images.bed),
                            style: Fonts.medium,
                            fontsize: 10),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    width: double.infinity,
                    height: 60.h,
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
                              style: Fonts.medium,
                            ),
                            Text(
                              'السعودية , الخرج',
                              style: Fonts.xsmall,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(S.of(context).places, style: Fonts.medium),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    width: 315.w,
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
                        target: LatLng(double.parse(model.lat),
                            double.parse(model.long)),
                        zoom: 18,
                      ),
                      myLocationButtonEnabled: false,
                      myLocationEnabled: false,
                      zoomControlsEnabled: false,

                      padding: const EdgeInsets.only(top: 100),
                      markers: {
                        Marker(
                            markerId: const MarkerId('homeLocation'),
                            infoWindow: InfoWindow(title: model.title),
                            position: LatLng(double.parse(model.lat),
                                double.parse(model.long)))
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
