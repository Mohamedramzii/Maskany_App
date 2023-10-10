import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maskany_app/data/data_sources/local/shared_pref.dart';
import 'package:maskany_app/data/models/categories_model/categories_model.dart';
import 'package:maskany_app/data/models/favorites_model/favorites_model.dart';
import '../../../../core/common_widgets/custom_dialog.dart';
import '../../../../core/common_widgets/custom_snackbar.dart';
import '../../../../core/constants.dart';
import '../../../../data/data_sources/network/dio_helper.dart';
import '../../../../data/models/fav_model2/fav_model2.dart';
import '../../../../data/models/propertiesModel/propertiesModel.dart';

import '../../../../data/models/propertiesModel/properties_model2/properties_model2.dart';
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
  bool isSatalite = false;

  toggleMapType() {
    isSatalite = !isSatalite;
    emit(ToggleMapTypeSuccessState());
  }

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

  bool isNotNavBar = false;
  //! Bottom Nav bar
  btmNavBar(index) {
    currentindex = index;
    if (index == 0) {
      // getAllFavorites();
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
        // return debugPrint('Location permissions are denied');
        return Dialogs.failureDialog(context);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      // return debugPrint(
      //     'Location permissions are permanently denied, we cannot request permissions.');
      return Dialogs.failureDialog(context);
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

  List<String> category = ['الكل', 'شقق للأيجار', 'شقق للبيع'];
  List<CategoriesModel> allcategories = [];
  getCategories() {
    DioHelper.getData(url: EndPoints.categories).then((value) {
      for (var category in value.data) {
        allcategories.add(CategoriesModel.fromJson(category));
      }
      emit(GetCategoriesState());
    });
  }

  PropertiesModel? properties;
  List<PropertiesModel2> property = [];

  List<PropertiesModel2> bee3Prop = [];
  List<PropertiesModel2> egaarProp = [];
  getAllproperties() async {
    CacheHelper.getData(key: tokenKey);
    emit(GetAllPropertiesLoadingState());
    //  isviewed = CacheHelper.getData(key: 'loc');
    try {
      Response response = await DioHelper.getData(
          url: EndPoints.properties,
          token: 'Token ${CacheHelper.getData(key: tokenKey)}');
      for (var item in response.data) {
        property.add(PropertiesModel2.fromJson(item));
      }

      // egaarProp = property
      //     .where((e) => e.category.name == allcategories[0].name)
      //     .toList();
      // bee3Prop = property
      //     .where((e) => e.category.name == allcategories[1].name)
      //     .toList();
      // debugPrint('######### ${property.length} ###############');
      // debugPrint('######### ${egaarProp.length} ###############');
      // debugPrint('######### ${bee3Prop.length} ###############');

      // property.add(properties!);
      debugPrint('Get All properties Success');
      emit(GetAllPropertiesSuccessState());
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
      debugPrint('Get All properties Failed -- ${e.toString()}');
      emit(GetAllPropertiesFailureState());
    }
  }

  fillcategriesLists() {
    emit(FillListsSuccessState());
  }

  int categoryIndex = 0;

  blabla(index) {
    categoryIndex = index;
    emit(IndexChangedSuccessState());
    print(categoryIndex);
  }

  List<PropertiesModel2> filterCategories(int index) {
    switch (index) {
      // case 0:
      //   return property;
      case 0:
        return egaarProp;
      case 1:
        return bee3Prop;

      default:
        return property;
    }
  }

  List<PropertiesModel2> search = [];
  String emptyValue = '';
  getSearchedFor(String query) {
    search = property
        .where((item) => item.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    // search=[];
    emit(GetSearchSuccessState());
  }

  // List<int?> favsID = [];
  bool isalreadyinfav = false;
  // bool isFav = false;
  // FavoritesModel? favoritesModel;

  List<FavoritesModel> allfavorites = [];
  Set<int> favoritesID = {};
  Set<int> favoritesID2 = {};
  getAllFavorites() async {
    CacheHelper.getData(key: tokenKey);

    allfavorites.clear();
    favoritesID.clear();
    favoritesID2.clear();
    // favsID = [];
    emit(GetFavoritesLoadingState());
    Response response = await DioHelper.getData(
        url: EndPoints.favorites,
        token: 'Token ${CacheHelper.getData(key: tokenKey)}');

    // favoritesModel = FavoritesModel.fromJson(response.data);
    for (var item in response.data) {
      allfavorites.add(FavoritesModel.fromJson(item));
      favoritesID.add(item['id']);
      favoritesID2.add(item['property']['id']);
      // favsID.add(item['id']);
    }
     print('favorites IDs length: ${favoritesID.length}');
     print('favorites IDs length: ${favoritesID2.length}');
    // if (CacheHelper.getData(key: 'favMap') != null) {
    //   favMap = json.decode(CacheHelper.getData(key: 'favMap'));
    //   print(favMap);
    // }

    debugPrint('|||||||In GetFavs Allfavs length:${allfavorites.length} |||||');
    // debugPrint('|||||||In GetFavs FavsID length:${favsID.length} |||||');
    // debugPrint('|||||||In GetFavs FavsID length:${favsID} |||||');
    // debugPrint('Get Favs Success : ${allfavorites[0]!.title}');
    emit(GetFavoritesSuccessState());
  }

  List<int> topIDFavs = [];
  List<int> favsID = [];
  bool isaddedtofav = false;
  Map<int, FavoritesModel> favMap = {};
  addtoFavorites({required id, index}) async {
    emit(AddedToFavoritesLoadingState());

    try {
      var response = await DioHelper.postData(
              url: EndPoints.favorites,
              data: {'property_id': id},
              token: 'Token $tokenHolder')
          .then((value) async {
        // topIDFavs.addAll(value.data['id']);
        // favMap[index] = FavoritesModel.fromJson(value.data);
        // favoritesID.add(id);
        // CacheHelper.saveData(key: 'favMap', value: json.encode(favMap));
        // print('Added Item Index $index where its ID ${favMap[index]!.id}');
        // favsID.addAll(value.data['property']['id']);
        // debugPrint(
        //     '|||||||In AddFavs topIDFavs length:${topIDFavs.length} |||||');
        // debugPrint(
        //     '|||||||In AddFavs FavsID length:${favsID.length} |||||');
        // CacheHelper.saveData(key: 'favs', value: updatedFavs.toString());
        // FavoritesModel.fromJson(value.data['property']);
        // if (allfavorites.contains(value.data['property'])) {
        //   isalreadyinfav = true;
        //   debugPrint('Is Already in Favs');
        // }
        // isFav = true;

        // favsID.add(value.data['id']);

        // if (response.statusCode == 400) {
        //   print(response.data['error']);
        // }
        // debugPrint('|||||||In AddFavs FavsID length:${favsID.length} |||||');
        // isaddedtofav = true;
        // print('Is ADD to fav: $isaddedtofav');
        await getAllFavorites();
        emit(AddedToFavoritesSuccessState(true));
      });
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.type == DioExceptionType.badResponse) {
          isalreadyinfav = true;
          debugPrint(isalreadyinfav.toString());
          debugPrint('Is AlreadyIn Favs');
          throw Exception('ALREADY IN FAVORITES');
        } else {
          print('isadded');
        }
      }
      emit(AddedToFavoritesFailureState(e.message.toString()));
    }
  }

  addOrdeleteFavorite({required favoriteItemID, required id}) {
    if (favoritesID.contains(favoriteItemID)) {
      deleteFromFav(favoriteItemID: favoriteItemID);
    } else if (favoritesID.contains(id)) {
      addtoFavorites(id: id);
    }
    emit(AddOrRemoveSuccessState());
  }

  int? indexOfDeletedItem;
  deleteFromFav({
    required int favoriteItemID,
  }) async {
    emit(DeleteFavoritesLoadingState());

    try {
      Response response = await DioHelper.deleteData(
          url: 'http://66.45.248.247:8000/properties/fav/$favoriteItemID/',
          token: 'Token ${CacheHelper.getData(key: tokenKey)}');
      // favsID.remove(favoriteItemID);
      // isaddedtofav=false;
      // print('Is ADD to fav: $isaddedtofav');
      // indexOfDeletedItem = updatedFavs.indexOf(favoriteItemID);
      // updatedFavs.removeAt(indexOfDeletedItem!);

      // favoritesID.remove(favoriteItemID);

    await   getAllFavorites();
      // debugPrint('|||||||In DeleteFavs FavsID length:${favsID.length} |||||');
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
  }

  // Map<int, bool> favorites = {};
  // addtoFavorites({required  id, context}) {
  //   // favorites[id!] = !favorites[id]!;
  //   emit(AddedToFavoritesLoadingState());
  //   DioHelper.postData(
  //           url: EndPoints.favorites,
  //           data: {'property_id': id},
  //           token: 'Token $tokenHolder')
  //       .then((value) {
  //     // allfavorites.add(FavoritesModel.fromJson(value.data));
  //     // debugPrint('******* Favs: ${favoritesModel!.title}*****');
  //     // if (favorites[id] == false) {
  //     //   SnackBars.failureSnackBar(context, 'المفضلة', 'تمت الازالة بنجاح');

  //     // } else {
  //     //   SnackBars.successSnackBar(context, 'المفضلة', 'تمت الاضافة بنجاح');
  //     // }
  //     // getAllFavorites();
  //   }).catchError((e) {
  //     favorites[id] = !favorites[id]!;
  //     emit(AddedToFavoritesFailureState(e.toString()));
  //   });
  // }
}
