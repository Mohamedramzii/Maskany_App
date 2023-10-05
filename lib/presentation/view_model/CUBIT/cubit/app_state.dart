part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

final class GetCurrentLocationSuccess extends AppState {}

final class NavBarIndexChangedSuccess extends AppState {}

final class GetAllPropertiesSuccessState extends AppState {
  // final String successMsg;

  // GetAllPropertiesSuccessState(this.successMsg);
}

final class GetAllPropertiesLoadingState extends AppState {}

final class GetAllPropertiesFailureState extends AppState {
  // final String errMsg;

  // GetAllPropertiesFailureState(this.errMsg);
}

final class IsViewedSuccessState extends AppState{}
final class IndexChangedSuccessState extends AppState{}
