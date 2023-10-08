import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<AppCubit>(context);
        return Scaffold(
          body: Stack(
            children: [
              CustomGoogleMapMarkerBuilder(
                customMarkers:
                    cubit.filterCategories(cubit.categoryIndex).map((e) {
                  return MarkerData(
                      marker: Marker(
                          markerId: MarkerId(e.locationLink),
                          position: LatLng(
                            double.parse(e.lat),
                            double.parse(e.long),
                          ),
                          infoWindow: const InfoWindow(),
                          onTap: () {
                            LocationBottomSheet.locationBTMSheet(context, e);
                          }),
                      child: CustomMarker(
                          price: e.price, isviewed: cubit.isviewedfromC));
                }).toList(),
                builder: (p0, Set<Marker>? markers) {
                  return GoogleMap(
                    compassEnabled: true,
                    // indoorViewEnabled: true,
                    mapToolbarEnabled: true,

                    mapType: MapType.satellite,
                    zoomGesturesEnabled: true,

                    // cloudMapId: '961ba1ad7f1204e8',
                    // initialCameraPosition: cubit.firstVIew!,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(
                          double.parse(cubit.property[0].lat),
                          double.parse(cubit.property[0].long),
                        ),
                        zoom: 8),
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,

                    padding: const EdgeInsets.only(top: 100),
                    markers: markers ?? {},
                    // markers:
                    //     _createMarkers(cubit.property, context, cubit),
                    // markers: _markers.values.toSet(),
                    onMapCreated: (GoogleMapController controller) {
                      cubit.googleMapController = controller;
                      // cubit.googleMapController!.setMapStyle(AutofillHints.);
                    },

                    onTap: (latlong) {},
                  );
                },
              ),
              Card(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  height: 60.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Flex(direction: Axis.horizontal, children: [
                    Flexible(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) =>
                                CustomCategoryContainer(
                                    index: index, list: cubit.category),
                            itemCount: cubit.category.length)),
                  ]),
                ),
              ),

              // Align(
              //   alignment: Alignment.bottomRight,

              //   child: Container(
              //     width: 100.w,
              //     height: 40.h,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(20.r),
              //         color: ColorsManager.kprimaryColor),
              //   ),
              // )
            ],
          )
          // : Center(
          //     child: LoadingAnimationWidget.staggeredDotsWave(
          //         color: ColorsManager.kprimaryColor, size: 40.r),
          //   ),
          ,
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: FloatingActionButton.extended(
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
            onPressed: () {},
          ),
        );
      },
    );
  }

  // void onMapCreated(GoogleMapController controller) {
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  void customMarker(image) {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(10, 10)), image)
        .then((icon) {
      setState(() {
        markerIcon = icon;
      });
    });
  }

  // Future<void> _onBuildCompleted() async {
  //   await Future.wait(data.map((value) async {
  //     Marker marker = await _generatemarkersFromWidget(value);
  //     _markers[marker.markerId.value] = marker;
  //   }));

  //   setState(() {
  //     isloaded =true;
  //   });
  // }

  // Future<Marker> _generatemarkersFromWidget(Map<String, dynamic> data) async {
  //   RenderRepaintBoundary boundary =
  //       data['key'].currentContext?.findRenderObject() ;
  //   ui.Image image = await boundary.toImage(pixelRatio: 2);
  //   ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  //   return Marker(
  //       markerId: MarkerId(
  //         data['id'],
  //       ),
  //       position: data['position'],
  //       icon: BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List()));
  // }

//   Set<Marker> _createMarkers(List<PropertiesModel> locations, context, cubit) {
// // String title='';
//     final Iterable<Marker> markers = locations.map(
//       (location) {
//         customMarker(Images.marker);
//         return Marker(
//           markerId: MarkerId(location.title),
//           onTap: () {
//             LocationBottomSheet.locationBTMSheet(context, location);
//             // Navigator.push(
//             //     context,
//             //     PageAnimationTransition(
//             //         page: Test(location: location),
//             //         pageAnimationType: RightToLeftFadedTransition()));
//           },
//           // icon: markerIcon,
//           position:
//               LatLng(double.parse(location.lat), double.parse(location.long)),
//           infoWindow: InfoWindow(
//             title: location.title,
//           ),
//         );
//       },
//     );

//     return markers.toSet();
//   }
}
