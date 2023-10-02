import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maskany_app/core/constants.dart';
import 'package:maskany_app/data/data_sources/network/dio_helper.dart';
import 'package:maskany_app/data/models/propertiesModel/propertiesModel.dart';

import '../../../views/favorite_view.dart';
import '../../../views/home_view.dart';
import '../../../views/location_map_view.dart';
import '../../../views/profile_view.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  double rate = 2.5;
  int currentindex = 0;
  bool isviewedfromC = false;

  viewed() {
    isviewedfromC = true;
    emit(IsViewedSuccessState());
  }
  // viewed(PropertiesModel location) async {
  //   location.isviewed = true;
  //   // isviewedfromC = location.isviewed;
  //   // isviewed= await CacheHelper.saveData(key: 'loc', value: location.isviewed);
  //   // await SessionManager().set('view',location.isviewed);
  //   print('${location.name} : ${location.isviewed}');
  //   emit(IsViewedSuccessState());
  // }

  List<Widget> screen = [
    const HomeView(),
    const FavoriteView(),
    const LocationMapView(),
    const ProfileView()
  ];

  //  @override
  // Future<void> close() {
  //   super.close();
  //   // Do nothing to prevent the Cubit from being closed
  //   return Future.value();
  // }
  //! Bottom Nav bar
  btmNavBar(index) {
    currentindex = index;
    emit(NavBarIndexChangedSuccess());
  }

  // void closeCubit() {
  //   close();

  // }

  //! --------------------------------MAP-----------------------
  CameraPosition? firstVIew;
  Position? currentLocation;
  GoogleMapController? googleMapController;
//! ----------------------------------------------------------

//! Getting User Permission
  Future getPermission(context) async {
    late bool locationService;
    late LocationPermission permission;
    //! check if location service is enabled or not
    locationService = await Geolocator.isLocationServiceEnabled();
    if (!locationService) {
      return debugPrint('Location services are disabled.');
    }

    //! checks for permission
    permission = await Geolocator.checkPermission();

    //! permissions types (if permission is denied)
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return debugPrint('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return debugPrint(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    print('########## $permission');
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      // await getCurrentLatLong();
    }

    //! Getting Current location using lat long
    Future<void> getCurrentLatLong() async {
      //! getCurrentPosition() gets latlong
      currentLocation = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((value) {
        return value;
      });
      emit(GetCurrentLocationSuccess());

      //! when open google maps, the first place to view (usually user current location)
      firstVIew = CameraPosition(
        target: LatLng(currentLocation!.latitude, currentLocation!.longitude),
        zoom: 15,
      );
    }
  }

  //! Getting Current location using lat long
  Future<void> getCurrentLatLong() async {
    //! getCurrentPosition() gets latlong
    currentLocation = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) => value);

    emit(GetCurrentLocationSuccess());

    //! when open google maps, the first place to view (usually user current location)
    firstVIew = CameraPosition(
      target: LatLng(currentLocation!.latitude, currentLocation!.longitude),
      zoom: 18,
    );
  }

  PropertiesModel? properties;
  List<PropertiesModel> property = [];
  List<PropertiesModel> someProp = [];
  getAllproperties() async {
    emit(GetAllPropertiesLoadingState());
    //  isviewed = CacheHelper.getData(key: 'loc');
    try {
      Response response = await DioHelper.getData(url: EndPoints.properties);
      for (var item in response.data) {
        property.add(PropertiesModel.fromJson(item));
        someProp = property.where((e) => e.category.name == 'شقق').toList();

      }

      debugPrint('######### ${someProp[0].city} ###############');

      // property.add(properties!);
      debugPrint('Get All properties Success');
      emit(GetAllPropertiesSuccessState());
    } catch (e) {
      debugPrint('Get All properties Failed -- ${e.toString()}');
      emit(GetAllPropertiesFailureState());
    }
  }
}
