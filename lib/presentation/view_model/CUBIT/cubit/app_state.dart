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


final class GetCategoriesState extends AppState {}
final class FillListsSuccessState extends AppState {}
final class ToggleMapTypeSuccessState extends AppState {}


final class AddOrRemoveSuccessState extends AppState{}
final class AddOrRemoveFailureState extends AppState{}



final class SeenOrNotSuccessState extends AppState{}
final class SeenOrNotFailureState extends AppState{}