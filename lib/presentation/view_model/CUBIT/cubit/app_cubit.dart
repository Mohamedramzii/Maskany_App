// ignore_for_file: body_might_complete_normally_catch_error, unused_local_variable

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maskany_app/core/serverFailure.dart';
import 'package:maskany_app/data/data_sources/local/shared_pref.dart';
import 'package:maskany_app/data/models/categories_model/categories_model.dart';
import 'package:maskany_app/presentation/view_model/CUBIT/cubit/auth_cubit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants.dart';
import '../../../../data/data_sources/network/dio_helper.dart';
import '../../../../data/models/propertiesModel/properties_model2/properties_model2.dart';
import '../../../views/favorite_view.dart';
import '../../../views/home_view.dart';
import '../../../views/location_map_view.dart';
import '../../../views/profile_settings/profile_view.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  double rate = 2.5;
  int currentindex = 0;
  bool isviewedfromC = false;
  bool isSatalite = false;

  toggleMapType() {
    isSatalite = !isSatalite;
    emit(ToggleMapTypeSuccessState());
  }

  // viewed() {
  //   isviewedfromC = true;
  //   emit(IsViewedSuccessState());
  // }
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

  bool isNotNavBar = false;
  //! Bottom Nav bar
  btmNavBar(index) {
    currentindex = index;
    if (index == 1) {
      screen[1];
      emit(NavBarIndexChangedSuccess());
    }
    if (index == 2) {
      // getAllproperties();
      // screen[2];
      // emit(NavBarIndexChangedSuccess());
    }
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

  //! In IOS we should add isRestricted and isLimited
  Future<void> checkLocationPermission(
      Permission permission, BuildContext context) async {
    late PermissionStatus status;
    try {
      status = await permission.request();
    } catch (e) {
      if (status.isGranted) {
        debugPrint('Location Is Granted');
      } else if (status.isDenied) {
        await permission.request();
      } else if (status.isPermanentlyDenied) {
        await openAppSettings();
      } else {
        debugPrint('Just Locaion Error');
      }
    }
    getCurrentLatLong();
  }
  // void checkLocationPermission(context) async {
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     // Location permission is denied
  //     LocationPermission newPermission = await Geolocator.requestPermission();
  //     handlePermissionStatus(newPermission, context);
  //   } else if (permission == LocationPermission.deniedForever) {
  //     // Location permission is permanently denied
  //     // Show a dialog or navigate to app settings
  //     // to enable location permission manually
  //     handleForeverDeniedPermission(context);
  //   } else {
  //     // Location permission is granted
  //     // Proceed with location-related functionality
  //     handleLocationPermissionGranted(context);
  //   }
  // }

  // void handlePermissionStatus(LocationPermission permission, context) {
  //   if (permission == LocationPermission.denied) {
  //     // Location permission is still denied
  //     // Show a dialog or provide an alternative functionality
  //     // to proceed without location access
  //     handleDeniedPermission(context);
  //   } else if (permission == LocationPermission.deniedForever) {
  //     // Location permission is permanently denied
  //     // Show a dialog or navigate to app settings
  //     // to enable location permission manually
  //     handleForeverDeniedPermission(context);
  //   } else {
  //     // Location permission is granted
  //     // Proceed with location-related functionality
  //     handleLocationPermissionGranted(context);
  //   }
  // }

  // void handleDeniedPermission(context) {
  //   print('Location permission is denied');
  //   // Implement your logic here when location permission is denied
  //   openAppSettings().catchError((error) {
  //   // Error handling if the app settings cannot be opened
  //   print('Error opening app settings: $error');
  // });
  //   // Dialogs.successDialog(context);
  //   // SnackBars.failureSnackBar(
  //   //     context, "Location", 'Location permission is denied');
  // }

  // void handleForeverDeniedPermission(context) {
  //   print('Location permission is permanently denied');
  //   // Implement your logic here when location permission is permanently denied
  //   // SnackBars.failureSnackBar(
  //   //     context, "Location", 'Location permission is permanently denied');
  //       openAppSettings().catchError((error) {
  //   // Error handling if the app settings cannot be opened
  //   print('Error opening app settings: $error');
  // });
  // }

  // void handleLocationPermissionGranted(context) {
  //   print('Location permission is granted');
  //   // Implement your logic here when location permission is granted
  //   // You can start using location-related functionality
  //   // SnackBars.failureSnackBar(
  //   //     context, "Location", 'Location permission is granted');
  // }

  //! Getting Current location using lat long
  Future<void> getCurrentLatLong() async {
    //! getCurrentPosition() gets latlong
    currentLocation = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      emit(GetCurrentLocationSuccess());
      return value;
    }).catchError((e) async {
      await openAppSettings();
    });

    //! when open google maps, the first place to view (usually user current location)
    firstVIew = CameraPosition(
      target: LatLng(currentLocation!.latitude, currentLocation!.longitude),
      zoom: 15,
    );
  }

  List<String> category = ['الكل', 'شقق للأيجار', 'شقق للبيع'];
  List<CategoriesModel> allcategories = [];
  List<CategoriesModel> allcategoriesForAdvSearch = [];
  getCategories() {
    DioHelper.getData(url: EndPoints.categories).then((value) {
      for (var category in value.data) {
        allcategories.add(CategoriesModel.fromJson(category));
        allcategoriesForAdvSearch.add(CategoriesModel.fromJson(category));
      }
      allcategories.insert(0, CategoriesModel(id: 1, name: 'الكل'));
      emit(GetCategoriesState());
    });
  }

  List<PropertiesModel2> property = [];
  // List<PropertiesModel2> bee3Prop = [];
  // List<PropertiesModel2> egaarProp = [];
  List<PropertiesModel2> nearestPlaces = [];
  getAllproperties({required context}) async {
    // isInternetConnectFunc();
    CacheHelper.getData(key: tokenKey);
    property = [];
    // bee3Prop = [];
    // egaarProp = [];
    emit(GetAllPropertiesLoadingState());
    if (BlocProvider.of<AuthCubit>(context).userdata?.location == null) {
      await BlocProvider.of<AuthCubit>(context).getUserData();
      print('From getAllProps | getUserData');
    }
    var location = BlocProvider.of<AuthCubit>(context).userdata!.location;
    print('User Location From GetAllProps Method is: $location');
    try {
      Response response = await DioHelper.getData(
          url: EndPoints.properties, token: 'Token $tokenHolder');
      for (var item in response.data) {
        property.add(PropertiesModel2.fromJson(item));
        nearestPlaces = property
            .where((e) =>
                e.city ==
                location) //BlocProvider.of<AuthCubit>(context).userdata!.location
            .toList();
        // egaarProp = property
        //     .where((e) => e.category!.name == allcategories[1].name)
        //     .toList();
        // bee3Prop = property
        //     .where((e) => e.category!.name == allcategories[2].name)
        //     .toList();
      }

      debugPrint('######### ${property.length} ###############');
      debugPrint('######### ${nearestPlaces.length} ###############');
      // debugPrint('######### ${BlocProvider.of<AuthCubit>(context).userdata!.location} ###############');
      // debugPrint('######### ${egaarProp.length} ###############');
      // debugPrint('######### ${bee3Prop.length} ###############');

      // property.add(properties!);
      debugPrint('Get All properties Success');
      emit(GetAllPropertiesSuccessState());
    } catch (e) {
      if (e is DioError) {
        return ServerFailure.fromDioError(e);
      } else {
        // Handle other exceptions
        getAllproperties(context: context);
        // Display an appropriate error message to the user
      }
      debugPrint('Get All properties Failed -- ${e.toString()}');
      emit(GetAllPropertiesFailureState());
    }
  }

  int categoryIndex = 0;

  blabla(index) {
    categoryIndex = index;
    emit(IndexChangedSuccessState());
    print(categoryIndex);
  }

  List<PropertiesModel2> filterCategories(int index) {
    if (index == 0) return property;
    return property
        .where((e) => e.category!.name == allcategories[index].name)
        .toList();
  }

  List<PropertiesModel2> search = [];
  String emptyValue = '';
  getSearchedFor(String query) {
    search = property
        .where(
            (item) => item.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    // search=[];
    emit(GetSearchSuccessState());
  }

  int advSearchIndexForrooms = 1;
  changeNumbersIndexSelectionInAdvSearchForRooms(index) {
    advSearchIndexForrooms = index;
    emit(AdvSearchIndexChangeSuccessState());
  }

  int advSearchIndexForFloor = 1;
  changeNumbersIndexSelectionInAdvSearchForFloor(index) {
    advSearchIndexForFloor = index;
    emit(AdvSearchIndexChangeSuccessState());
  }

  bool isCheckBoxTapped = false;
  checkBoxTapped() {
    isCheckBoxTapped = !isCheckBoxTapped;
    emit(CheckBoxTappedSuccessState());
  }

  String? propType;
  String? location;
  bool isAllRooms = false;
  bool isAnotherFloor = false;

  List<PropertiesModel2> advancedSearch = [];
  // String emptyValue = '';
  getAdvancedSearchedFor1({
    required String propType,
    required String propLocation,
    // required int priceStart,
    // required int priceEnd,
    // required int spaceStart,
    // required int spaceEnd,
    // int? numberofRooms,
    // int? numberofFloor,
  }) {
    //! Gonna make try catch
    print(propType);
    print(propLocation);
    // print(priceStart);
    // print(priceEnd);
    // print(spaceStart);
    // print(spaceEnd);
    // print(numberofRooms);
    // print(numberofFloor);
    try {
      advancedSearch = property
          .where((item) =>
                  // (item.category!.name == propType.toString()) &&
                  // ((item.price! >= priceStart && item.price! <= priceEnd) &&
                  //     (item.space! >= spaceStart && item.price! <= spaceEnd) ||
                  //     (isAllRooms == true
                  //         ? item.rooms! > 0
                  //         : item.rooms == numberofRooms && isAnotherFloor == true
                  //             ? item.floor! > 4
                  //             : item.floor == numberofFloor)))

                  (item.category!.name == propType && item.city == propLocation)
              // &&
              // ((item.price! >= priceStart && item.price! <= priceEnd) &&
              //     (item.space! >= spaceStart && item.space! <= spaceEnd) &&
              //     ((isAllRooms == true)
              //         ? item.rooms! > 0
              //         : item.rooms == numberofRooms && isAnotherFloor == true
              //             ? item.floor! > 4
              //             : item.floor == numberofFloor))
              )

          // (item.category!.name == 'شقق للبيع'
          // // &&
          // //     item.city == 'دمياط الجديدة'
          // ) &&
          // ((item.price! >= 0 && item.price! <= 250000) &&
          //     (item.space! >= 100 && item.space! <= 250) &&
          //     (isAllRooms
          //         ? item.rooms! > 0
          //         : item.rooms == 2 && isAnotherFloor == true
          //             ? item.floor! > 4
          //             : item.floor == 2)))
          .toList();
    } catch (e) {
      print(e.toString());
    }
    debugPrint('Advanced Search Length : ${advancedSearch.length}');
    if (advancedSearch.isNotEmpty) {
      debugPrint('Advanced Search Item is : ${advancedSearch[0].title}');
    }
    // search=[];
    emit(GetSearchSuccessState());
  }

  getAdvancedSearchedFor2({
    required String propType,
    required String propLocation,
    required int priceStart,
    required int priceEnd,
    required int spaceStart,
    required int spaceEnd,
    int? numberofRooms,
    int? numberofFloor,
  }) {
    //! Gonna make try catch
    print(propType);
    print(priceStart);
    print(priceEnd);
    print(spaceStart);
    print(spaceEnd);
    print(numberofRooms);
    print(numberofFloor);
    try {
      advancedSearch = property
          .where((item) =>
              // (item.category!.name == propType.toString()) &&
              // ((item.price! >= priceStart && item.price! <= priceEnd) &&
              //     (item.space! >= spaceStart && item.price! <= spaceEnd) ||
              //     (isAllRooms == true
              //         ? item.rooms! > 0
              //         : item.rooms == numberofRooms && isAnotherFloor == true
              //             ? item.floor! > 4
              //             : item.floor == numberofFloor)))

              (item.category!.name == propType && item.city == propLocation) &&
              ((item.price! >= priceStart && item.price! <= priceEnd) &&
                  (item.space! >= spaceStart && item.space! <= spaceEnd) &&
                  (((isAllRooms == true)
                          ? item.rooms! > 0
                          : item.rooms == numberofRooms) &&
                      (isAnotherFloor == true
                          ? item.floor! > 4
                          : item.floor == numberofFloor))))

          // (item.category!.name == 'شقق للبيع'
          // // &&
          // //     item.city == 'دمياط الجديدة'
          // ) &&
          // ((item.price! >= 0 && item.price! <= 250000) &&
          //     (item.space! >= 100 && item.space! <= 250) &&
          //     (isAllRooms
          //         ? item.rooms! > 0
          //         : item.rooms == 2 && isAnotherFloor == true
          //             ? item.floor! > 4
          //             : item.floor == 2)))
          .toList();
    } catch (e) {
      print(e.toString());
    }
    debugPrint('Advanced Search Length : ${advancedSearch.length}');
    if (advancedSearch.isNotEmpty) {
      debugPrint('Advanced Search Item is : ${advancedSearch[0].title}');
    }
    // search=[];
    emit(GetSearchSuccessState());
  }

  List<PropertiesModel2> allfavorites = [];
  Set<int> favoritesID = {};
  getAllFavorites() async {
    CacheHelper.getData(key: tokenKey);

    allfavorites.clear();
    favoritesID.clear();
    emit(GetFavoritesLoadingState());
    Response response = await DioHelper.getData(
        url: EndPoints.favorites, token: 'Token $tokenHolder');

    for (var item in response.data) {
      allfavorites.add(PropertiesModel2.fromJson(item['property']));
      favoritesID.add(item['property']['id']);
    }

    debugPrint('|||||||In GetFavs Allfavs length:${allfavorites.length} |||||');
    debugPrint('|||||||In GetFavs FavsID length:${favoritesID.length} |||||');
    debugPrint('|||||||In GetFavs FavsID length:$favoritesID |||||');
    emit(GetFavoritesSuccessState());
  }

  addtoFavorites({required id}) async {
    emit(AddedToFavoritesLoadingState());

    if (!favoritesID.contains(id)) {
      favoritesID.add(id);
    }

    try {
      Response response = await DioHelper.postData(
          url: EndPoints.favorites,
          data: {'property_id': id},
          token: 'Token $tokenHolder');
      emit(AddedToFavoritesSuccessState(true));
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.type == DioExceptionType.badResponse) {
          // isalreadyinfav = true;
          // debugPrint(isalreadyinfav.toString());
          debugPrint('Is AlreadyIn Favs');
          throw Exception('ALREADY IN FAVORITES');
        } else {
          print('isadded');
        }
      }
      emit(AddedToFavoritesFailureState(e.message.toString()));
    }
    // await  getAllFavorites();
  }

  deleteFromFav({
    required int propertyID,
  }) async {
    emit(DeleteFavoritesLoadingState());
    if (favoritesID.contains(propertyID)) {
      favoritesID.remove(propertyID);
    }
    try {
      Response response = await DioHelper.deleteData(
          url: 'http://66.45.248.247:8000/properties/fav/prop/$propertyID/',
          token: 'Token $tokenHolder');
      if (response.statusCode == 204) {
        debugPrint('DELEAAAAATED');
      } else {
        debugPrint(response.statusCode.toString());
        debugPrint(response.data['error']);
      }
      emit(DeleteFavoritesSuccessState());
    } catch (e) {
      if (e is DioError) {
        if (e.error is SocketException && e.error == 113) {
          // Handle "No route to host" error
          print(
              '*-*-*-*-*-*-*-No route to host error occurred*-*-*-*-*-*-*-*-');
          // Display an appropriate error message to the user
        } else {
          // Handle other Dio errors
          print('Dio error occurred: ${e.error}');
          // Display an appropriate error message to the user
        }
      } else {
        // Handle other exceptions
        print('Exception occurred: $e');
        // Display an appropriate error message to the user
      }
      emit(DeleteFavoritesFailureState(e.toString()));
    }
    //  await getAllFavorites();
  }

  deleteFromFavortiteView({
    required int favID,
  }) async {
    emit(DeleteFavoritesLoadingState());
    // if (favoritesID.contains(propertyID)) {
    //   favoritesID.remove(propertyID);
    // }
    try {
      Response response = await DioHelper.deleteData(
          url: 'http://66.45.248.247:8000/properties/fav/prop/$favID/',
          token: 'Token $tokenHolder');
      // if (response.statusCode == 204) {
      //   print('DELEAAAAATED');
      // }
      emit(DeleteFavoritesSuccessState());
    } catch (e) {
      if (e is DioError) {
        if (e.error is SocketException && e.error == 113) {
          // Handle "No route to host" error
          print(
              '*-*-*-*-*-*-*-No route to host error occurred*-*-*-*-*-*-*-*-');
          // Display an appropriate error message to the user
        } else {
          // Handle other Dio errors
          print('Dio error occurred: ${e.error}');
          // Display an appropriate error message to the user
        }
      } else {
        // Handle other exceptions
        print('Exception occurred: $e');
        // Display an appropriate error message to the user
      }
      emit(DeleteFavoritesFailureState(e.toString()));
    }
    await getAllFavorites();
  }

  bool isNavigatetoDetailsFromMap = false;
  seenOrnot({required propertyID}) async {
    Response response = await DioHelper.postData(
        url: EndPoints.seen,
        data: {'property_id': propertyID},
        token: 'Token $tokenHolder');

    debugPrint('SEEN');
    isNavigatetoDetailsFromMap = true;
    print(isNavigatetoDetailsFromMap);
    if (response.statusCode == 200) {
      // await getAllproperties(context: context);
      // filterCategories(0);
    }

    emit(SeenOrNotSuccessState());
  }

  Future<void> navigateToGoogleMaps(String link) async {
    final url = link;
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  // bool isInternetConnected = true;

  // Future<bool> isInternetConnectFunc() async {
  //   return await InternetConnectionChecker().hasConnection;
  // }
}
