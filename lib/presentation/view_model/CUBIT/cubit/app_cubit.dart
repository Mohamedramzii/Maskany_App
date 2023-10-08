import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maskany_app/data/models/favorites_model/favorites_model.dart';
import '../../../../core/common_widgets/custom_dialog.dart';
import '../../../../core/common_widgets/custom_snackbar.dart';
import '../../../../core/constants.dart';
import '../../../../data/data_sources/network/dio_helper.dart';
import '../../../../data/models/fav_model2/fav_model2.dart';
import '../../../../data/models/propertiesModel/propertiesModel.dart';

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
    if (currentindex == 1) {
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

  List<String> category = [
    'الكل',
    'شقق للايجار',
    'أراضي للبيع',
    'فلل للبيع',
    'دور للايجار',
    'شقق للبيع',
  ];
  PropertiesModel? properties;
  List<PropertiesModel> property = [];
  List<PropertiesModel> bee3Prop = [];
  List<PropertiesModel> egaarProp = [];
  getAllproperties() async {
    emit(GetAllPropertiesLoadingState());
    //  isviewed = CacheHelper.getData(key: 'loc');
    try {
      Response response = await DioHelper.getData(
          url: EndPoints.properties, token: 'Token $tokenHolder');
      for (var item in response.data) {
        property.add(PropertiesModel.fromJson(item));
        bee3Prop = property
            .where((e) => e.category.name == category[5].toString())
            .toList();
        egaarProp = property
            .where((e) => e.category.name == category[1].toString())
            .toList();
      }

      debugPrint('######### ${egaarProp.length} ###############');
      debugPrint('######### ${bee3Prop.length} ###############');

      // property.add(properties!);
      debugPrint('Get All properties Success');
      emit(GetAllPropertiesSuccessState());
    } catch (e) {
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

  List<PropertiesModel> filterCategories(int index) {
    switch (categoryIndex) {
      case 0:
        return property;
      case 1:
        return egaarProp;
      case 5:
        return bee3Prop;

      default:
        return property;
    }
  }

  List<PropertiesModel> search = [];
  String emptyValue = '';
  getSearchedFor(String query) {
    search = property
        .where((item) => item.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    // search=[];
    emit(GetSearchSuccessState());
  }

  bool isalreadyinfav = false;
  bool isFav = false;
  // FavModel2? favoritesModel;
  List<FavoritesModel> allfavorites = [];
  getAllFavorites() {
    allfavorites = [];
    emit(GetFavoritesLoadingState());
    DioHelper.getData(url: EndPoints.favorites, token: 'Token $tokenHolder')
        .then((value) {
      for (var item in value.data) {
        allfavorites.add(FavoritesModel.fromJson(item));
      }
      // debugPrint('Get Favs Success : ${allfavorites[0].property!.title}');
      emit(GetFavoritesSuccessState());
    }).catchError((e) {
      debugPrint('Get Favs Failed ${e.toString()}');
      emit(GetFavoritesFailureState(e.toString()));
    });
  }

  // void toggleFavorites(int itemID) {
  //   emit(AddedToFavoritesLoadingState());
  //   DioHelper.postData(
  //           url: EndPoints.favorites,
  //           data: {"property_id": itemID},
  //           token: tokenHolder)
  //       .then((value) {
  //     bool isFav = allfavorites.any((element) => element.id == itemID);
  //     if (isFav) {
  //       debugPrint('Item Is In Favs And removed now');
  //       allfavorites.removeWhere((element) => element.id == itemID);
  //     } else {
  //       // FavModel2 item = FavModel2(id: itemID);
  //       debugPrint('Item Isnot In Favs And added now');
  //       allfavorites.add(FavModel2.fromJson(value.data));
  //     }
  //     emit(GetAllPropertiesSuccessState());
  //   }).catchError((e) {
  //     emit(GetAllPropertiesFailureState());
  //   });
  // }

  bool isaddedtofav = false;
  addtoFavorites({required int id}) {
    emit(AddedToFavoritesLoadingState());

    try {
      DioHelper.postData(
              url: EndPoints.favorites,
              data: {'property_id': id},
              token: 'Token $tokenHolder')
          .then((value) {
        // FavoritesModel.fromJson(value.data['property']);
        // if (allfavorites.contains(value.data['property'])) {
        //   isalreadyinfav = true;
        //   debugPrint('Is Already in Favs');
        // }
        isFav = true;
        getAllFavorites();
        // emit(AddedToFavoritesSuccessState(true));
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

  deleteFromFav({required favoriteItemID}) {
    emit(DeleteFavoritesLoadingState());

    DioHelper.deleteData(
            url: 'http://66.45.248.247:8000/properties/fav/$favoriteItemID/',
            token: 'Token $tokenHolder')
        .then((value) {
      getAllFavorites();
      // emit(DeleteFavoritesSuccessState());
    }).catchError((e) {
      emit(DeleteFavoritesFailureState(e.toString()));
    });
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
