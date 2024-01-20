import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:maskany_app/presentation/views/nearest_props_view.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'widgets/location_mapView_widgets/custom_marker.dart';
import 'widgets/location_mapView_widgets/custom_category_container.dart';
import '../../core/app_resources/colors.dart';
import '../../core/app_resources/images.dart';
import '../view_model/CUBIT/cubit/app_cubit.dart';
import 'widgets/location_mapView_widgets/custom_btmsheet.dart';

class LocationMapView extends StatefulWidget {
  const LocationMapView({super.key});

  @override
  State<LocationMapView> createState() => _LocationMapViewState();
}

class _LocationMapViewState extends State<LocationMapView> {
  @override
  void initState() {
    BlocProvider.of<AppCubit>(context)
        .checkLocationPermission(Permission.locationWhenInUse, context);
    BlocProvider.of<AppCubit>(context).filterCategories(0);
    print('################ User navigated back from Screen 2 ##############');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<AppCubit>(context);
        return Scaffold(
          body: state is GetAllPropertiesLoadingState
              ? Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                      color: ColorsManager.kprimaryColor, size: 40.r),
                )
              : Stack(
                  children: [
                    CustomGoogleMapMarkerBuilder(
                      customMarkers:
                          cubit.filterCategories(cubit.categoryIndex).map((e) {
                        return MarkerData(
                            marker: Marker(
                                markerId: MarkerId(e.id!.toString()),
                                position: LatLng(
                                  double.parse(e.lat!),
                                  double.parse(e.long!),
                                ),
                                infoWindow: const InfoWindow(),
                                onTap: () {
                                  print(
                                      '-*-*-*-*-/-/-/-/ ${e.id} *-*-*-*-*-*-*-');
                                  try {
                                    Future.delayed(
                                      const Duration(milliseconds: 500),
                                      () =>
                                          LocationBottomSheet.locationBTMSheet(
                                              context, e),
                                    );
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                }),
                            child: CustomMarker(
                                price: e.price!, isviewed: e.isSeen!));
                      }).toList(),
                      builder: (p0, Set<Marker>? markers) {
                        return GoogleMap(
                          compassEnabled: true,
                          // indoorViewEnabled: true,
                          mapToolbarEnabled: true,

                          mapType: cubit.isSatalite
                              ? MapType.hybrid
                              : MapType.normal,
                          zoomGesturesEnabled: true,
                          // onCameraMoveStarted: () => true,
                          // cloudMapId: '961ba1ad7f1204e8',
                          // initialCameraPosition: cubit.firstVIew!,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(
                                double.parse(cubit.allProperties[0].lat!),
                                double.parse(cubit.allProperties[0].long!),
                              ),
                              zoom: 9),
                          myLocationButtonEnabled: true,
                          myLocationEnabled: true,
                          zoomControlsEnabled: false,

                          padding: const EdgeInsets.only(top: 100),
                          markers: markers ?? {},
                          // markers:
                          //     _createMarkers(cubit, context, cubit),
                          // markers: _markers.values.toSet(),
                          onMapCreated: (GoogleMapController controller) {
                            cubit.googleMapController = controller;
                            // cubit.googleMapController!.setMapStyle(AutofillHints.);
                          },
                          // onCameraMove: (position) => true,
                          onTap: (latlong) {
                            // cubit.googleMapController!.moveCamera(
                            //     CameraUpdate.newCameraPosition(
                            //         cubit.currentLocation as CameraPosition));
                          },
                        );
                      },
                    ),
                    Container(
                      // width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      height: 60.h,
                      width: double.infinity.w,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0),
                          borderRadius: BorderRadius.circular(15.r)),
                      child: SizedBox(
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  CustomCategoryContainer(
                                      index: index, list: cubit.allcategories),
                              itemCount: cubit.allcategories.length)),
                    ),
                  ],
                ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FloatingActionButton.extended(
                heroTag: 'Mapstyles',
                backgroundColor: ColorsManager.kprimaryColor,
                label: Image.asset(
                  Images.satellite,
                  width: 25.r,
                  color: Colors.white,
                ),
                onPressed: () {
                  cubit.toggleMapType();
                },
              ),
              SizedBox(
                height: 5.h,
              ),
              FloatingActionButton.extended(
                heroTag: 'Nearest_Places',
                backgroundColor: ColorsManager.kprimaryColor,
                label: Row(
                  children: [
                    Image.asset(Images.menu),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      'عرض القائمة',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                    )
                  ],
                ),
                onPressed: () {
                  // cubit.isNotNavBar = true;
                  Navigator.push(
                      context,
                      PageAnimationTransition(
                          page: const NearestPropsView(),
                          pageAnimationType: BottomToTopTransition()));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // // void onMapCreated(GoogleMapController controller) {
  // BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  // void customMarker(image) {
  //   BitmapDescriptor.fromAssetImage(
  //           const ImageConfiguration(size: Size(10, 10)), image)
  //       .then((icon) {
  //     setState(() {
  //       markerIcon = icon;
  //     });
  //   });
  // }
}
