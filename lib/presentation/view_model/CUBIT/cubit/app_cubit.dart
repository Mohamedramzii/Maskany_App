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
import 'package:maskany_app/data/models/ads_model/property.dart';
import 'package:maskany_app/data/models/categories_model/categories_model.dart';
import 'package:maskany_app/presentation/view_model/CUBIT/cubit/auth_cubit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants.dart';
import '../../../../data/data_sources/network/dio_helper.dart';
import '../../../../data/models/ads_model/ads_model.dart';
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

//
  // List<String> category = ['الكل', 'شقق للأيجار', 'شقق للبيع'];
  List<CategoriesModel> allcategories = [];
  List<CategoriesModel> allcategoriesForAdvSearch = [];
  getCategories() {
    DioHelper.getData(url: EndPoints.categories, token: 'Token $tokenHolder').then((value) {
      for (var category in value.data) {
        allcategories.add(CategoriesModel.fromJson(category));
        allcategoriesForAdvSearch.add(CategoriesModel.fromJson(category));
      }
      allcategories.insert(0, CategoriesModel(id: 1, name: 'الكل'));
      print('###### All categories : $allcategories ######');
      emit(GetCategoriesState());
    });
  }

  List<PropertiesModel2> property = [];
  List<PropertiesModel2> nearestPlaces = [];
  int limit = 2;
  int page = 1;
  bool hasMore = true;
  bool isLoading = false;
  getAllpropertiesWithPagination({required context}) async {
    // isInternetConnectFunc();
    CacheHelper.getData(key: tokenKey);
    nearestPlaces = [];
    emit(GetAllPropertiesLoadingState());
    if (BlocProvider.of<AuthCubit>(context).userdata?.location == null) {
      await BlocProvider.of<AuthCubit>(context).getUserData();
      print('From getAllProps | getUserData');
    }
    var location = BlocProvider.of<AuthCubit>(context).userdata!.location;
    print('User Location From GetAllProps Method is: $location');
    try {
      Response response = await DioHelper.getData(
        url: 'http://66.45.248.247:8000/properties/?objects=$limit&page=$page',
        token: 'Token $tokenHolder',
      );
      if (response.statusCode == 200) {
        final List<PropertiesModel2> newItems = [];
        // List<PropertiesModel2> newItemsPerLocation = [];
        for (var item in response.data['results']) {
          newItems.add(PropertiesModel2.fromJson(item));
        }
        // setState(() {
        page++;
        isLoading = false;

        print(newItems.length);
        // nearestPlaces=[];
        if (newItems.length < limit) {
          hasMore = false;
          print(hasMore);
        }
        property.addAll(newItems);
      }
      nearestPlaces =
          property.where((element) => element.city == location).toList();

      debugPrint('######### ${property.length} ###############');
      debugPrint('######### ${nearestPlaces.length} ###############');

      debugPrint('Get All properties Success');
      emit(GetAllPropertiesSuccessState());
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.connectionError) {
          emit(GetAllPropertiesFailureState());
        }
      } else {
        // Handle other exceptions
        // getAllpropertiesWithPagination(context: context);//!
        // Display an appropriate error message to the user
      }
      debugPrint('Get All properties Failed -- ${e.toString()}');
      emit(GetAllPropertiesFailureState());
    }
  }

  List<PropertiesModel2> allProperties = [];

  getAllPropertiesWithOutPagination(BuildContext context) async {
    // isInternetConnectFunc();
    CacheHelper.getData(key: tokenKey);
    allProperties = [];
    emit(GetNearestPlacesLoadingState());

    print('User Location From GetAllProps Method is: $location');
    try {
      Response response = await DioHelper.getData(
          url: EndPoints.map, token: 'Token $tokenHolder');
      // List<PropertiesModel2> tempList = [];
      for (var item in response.data) {
        allProperties.add(PropertiesModel2.fromJson(item));
      }

      debugPrint('######### ALL Props without pagination ${allProperties.length} ###############');

      debugPrint('Get All properties Success');
      emit(GetNearestPlacesSuccessState());
    } catch (e) {
      if (e is DioError) {
        return ServerFailure.fromDioError(e);
      } else {
        // Handle other exceptions
        // getAllPropertiesWithOutPagination(context);//!
        // Display an appropriate error message to the user
      }
      debugPrint('Get All properties Failed -- ${e.toString()}');
      emit(GetNearestPlacesFailureState(e.toString()));
    }
  }

  //!  Ads Method
  List<Property> ads = [];

  getAllAds(BuildContext context) async {
    // isInternetConnectFunc();
    CacheHelper.getData(key: tokenKey);
    ads = [];
    emit(GetAdsLoadingState());

    try {
      Response response = await DioHelper.getData(
        url: EndPoints.ads,token: 'Token $tokenHolder'
      );
      for (var item in response.data) {
        ads.add(Property.fromJson(item['property']));
      }

      debugPrint('Get All ads Success ${ads.length} , ${ads[0].title}');
      emit(GetAdsSuccessState());
    } catch (e) {
      if (e is DioError) {
        return ServerFailure.fromDioError(e);
      } else {}
      debugPrint('Get All ads Failed -- ${e.toString()}');
      emit(GetAdsFailureState(e.toString()));
    }
  }

  int categoryIndex = 0;

  blabla(index) {
    categoryIndex = index;
    emit(IndexChangedSuccessState());
    print(categoryIndex);
  }

  List<PropertiesModel2> filterCategories(int index) {
    if (index == 0)
      return allProperties;
    else
      return allProperties
          .where((e) => e.category!.name == allcategories[index].name)
          .toList();
  }

  List<PropertiesModel2> search = [];
  String emptyValue = '';
  getSearchedFor(String query) {
    search = allProperties
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
      advancedSearch = allProperties
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
      advancedSearch = allProperties
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
