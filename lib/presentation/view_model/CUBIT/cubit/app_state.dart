part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

//! Getting cuurent location
final class GetCurrentLocationSuccess extends AppState {}

//! Nav bar
final class NavBarIndexChangedSuccess extends AppState {}

//! Get All props
final class GetAllPropertiesSuccessState extends AppState {
  // final String successMsg;

  // GetAllPropertiesSuccessState(this.successMsg);
}

final class GetAllPropertiesLoadingState extends AppState {}

final class GetAllPropertiesFailureState extends AppState {
  // final String errMsg;z

  // GetAllPropertiesFailureState(this.errMsg);
}

// final String successMsg;
final class GetPaginatedPropertiesSuccessState extends AppState {
  // GetAllPropertiesSuccessState(this.successMsg);
}

final class GetPaginatedPropertiesLoadingState extends AppState {}

final class GetPaginatedPropertiesFailureState extends AppState {
  // final String errMsg;

  // GetAllPropertiesFailureState(this.errMsg);
}

//! for seen marker
final class IsViewedSuccessState extends AppState {}

//! For map categories
final class IndexChangedSuccessState extends AppState {}

//! Search
final class GetSearchSuccessState extends AppState {
  // final String successMsg;

  // GetAllPropertiesSuccessState(this.successMsg);
}

//! Add to favs
final class AddedToFavoritesSuccessState extends AppState {
  final bool isadded;

  AddedToFavoritesSuccessState(this.isadded);
}

final class AddedToFavoritesLoadingState extends AppState {}

final class AddedToFavoritesFailureState extends AppState {
  final String errMsg;

  AddedToFavoritesFailureState(this.errMsg);
}

//! Get Favs
final class GetFavoritesSuccessState extends AppState {
  // final String successMsg;

  // GetAllPropertiesSuccessState(this.successMsg);
}

final class GetFavoritesLoadingState extends AppState {}

final class GetFavoritesFailureState extends AppState {
  final String errMsg;

  GetFavoritesFailureState(this.errMsg);
}

//! Delte Favs
final class DeleteFavoritesSuccessState extends AppState {
  // final String successMsg;

  // GetAllPropertiesSuccessState(this.successMsg);
}

final class DeleteFavoritesLoadingState extends AppState {}

final class DeleteFavoritesFailureState extends AppState {
  final String errMsg;

  DeleteFavoritesFailureState(this.errMsg);
}

//! Get Favs
final class GetNearestPlacesSuccessState extends AppState {
  // final String successMsg;

  // GetAllPropertiesSuccessState(this.successMsg);
}

final class GetNearestPlacesLoadingState extends AppState {}

final class GetNearestPlacesFailureState extends AppState {
  final String errMsg;

  GetNearestPlacesFailureState(this.errMsg);
}

final class GetAdsLoadingState extends AppState {}

final class GetAdsSuccessState extends AppState {}

final class GetAdsFailureState extends AppState {
  final String errMsg;

  GetAdsFailureState(this.errMsg);
}

//! Get packages
final class GetPackagesLoadingState extends AppState {}

final class GetPackagesSuccessState extends AppState {}

final class GetPackagesFailureState extends AppState {
  final String errMsg;

  GetPackagesFailureState(this.errMsg);
}

//! Get package Payment Info (URL)
final class GetPayementPackagesURLLoadingState extends AppState {}

final class GetPayementPackagesURLSuccessState extends AppState {}
final class UserAlreadySubscribedInAPackageState extends AppState {}

final class GetPayementPackagesURLFailureState extends AppState {
  final String errMsg;

  GetPayementPackagesURLFailureState(this.errMsg);
}

final class GetCategoriesState extends AppState {}

// final class FillListsSuccessState extends AppState {}

final class ToggleMapTypeSuccessState extends AppState {}

final class AddOrRemoveSuccessState extends AppState {}

// final class AddOrRemoveFailureState extends AppState {}

final class SeenOrNotSuccessState extends AppState {}

final class SeenOrNotFailureState extends AppState {}

final class AdvSearchIndexChangeSuccessState extends AppState {}

final class CheckBoxTappedSuccessState extends AppState {}
final class ConfirmTransactionSuccessState extends AppState {}
final class ConfirmTransactionLoadingState extends AppState {}
final class Refresh extends AppState {}
