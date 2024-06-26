part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

//! LOGIN
final class LoginSuccessState extends AuthState {
  final String successMessage;

  LoginSuccessState({required this.successMessage});
}

final class LoginLoadingState extends AuthState {}

final class LoginFailureState extends AuthState {
  final String errMessage;

  LoginFailureState({required this.errMessage});
}

//! REGISTER

final class RegisterSuccessState extends AuthState {
  final String successMessage;

  RegisterSuccessState({required this.successMessage});
}

final class RegisterLoadingState extends AuthState {}

final class RegisterFailureState extends AuthState {
  final String errMessage;

  RegisterFailureState({required this.errMessage});
}

//! Send OTP

final class SendOTPSuccessState extends AuthState {
  final String successMessage;

  SendOTPSuccessState({required this.successMessage});
}

final class SendOTPLoadingState extends AuthState {}

final class SendOTPFailureState extends AuthState {
  final String errMessage;

  SendOTPFailureState({required this.errMessage});
}

//! Change Password

final class ChangePasswordSuccessState extends AuthState {
  final String successMessage;

  ChangePasswordSuccessState({required this.successMessage});
}

final class ChangePasswordLoadingState extends AuthState {}

final class ChangePasswordFailureState extends AuthState {
  final String errMessage;

  ChangePasswordFailureState({required this.errMessage});
}

final class ToggleVisibilitystate extends AuthState {}

final class GetUserDataSuccessState extends AuthState {}

final class GetUserDataLoadingState extends AuthState {}

final class GetUserDataFailureState extends AuthState {
  final String errMessage;

  GetUserDataFailureState({required this.errMessage});
}

final class UpdateUserDataSuccessState extends AuthState {}

final class UpdateUserDataLoadingState extends AuthState {}

final class UpdateUserDataFailureState extends AuthState {
  final String errMessage;

  UpdateUserDataFailureState({required this.errMessage});
}

final class ImagePickerSuccessState extends AuthState {}

final class UserLoggedOutSuccessState extends AuthState {}

//! SMS code sent
final class SmsCodeSentSuccesState extends AuthState {}
final class SmsCodeSentLoadinhState extends AuthState {}
final class SmsCodeSentFailureState extends AuthState {}

final class OTPMatchedSuccesState extends AuthState {}
