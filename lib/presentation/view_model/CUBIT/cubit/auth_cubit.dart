import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants.dart';
import '../../../../data/data_sources/local/shared_pref.dart';
import '../../../../data/data_sources/network/dio_helper.dart';
import '../../../../data/models/login_model/login_model.dart';
import '../../../../data/models/register_model/register_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

//! Login
  LoginModel? loginModel;
  // String? successLogin = '';
  login({
    required emailOrphone,
    required password,
  }) async {
    emit(LoginLoadingState());
    try {
      var response = await DioHelper.postData(
          url: EndPoints.login,
          data: {'email': emailOrphone, 'password': password});

      loginModel = LoginModel.fromJson(response.data);
      debugPrint('Login Message: ${loginModel!.detail}');
      CacheHelper.saveData(key: tokenKey, value: loginModel!.token);
      // successLogin = loginModel!.detail;
      emit(LoginSuccessState(successMessage: loginModel!.detail!));
    } on DioError catch (e) {
      if (e.response != null) {
        emit(LoginFailureState(errMessage: e.response!.data['detail']));
      }
    }
  }

//! Register
  RegisterModel? registerModel;
  register(
      {required username,
      required email,
      required phone,
      required password}) async {
    emit(RegisterLoadingState());

    try {
      var response = await DioHelper.postData(url: EndPoints.register, data: {
        'username': username,
        'email': email,
        'password': password,
      });

      registerModel = RegisterModel.fromJson(response.data);
      CacheHelper.saveData(key: tokenHolder, value: registerModel!.token);
      debugPrint('Register Message: ${registerModel!.detail}');

      emit(RegisterSuccessState(successMessage: registerModel!.detail!));
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint('Register Error: ${e.response!.data['detail']}');
        emit(RegisterFailureState(errMessage: e.message.toString()));
      }
    }
  }

  sendOTP({required email}) async {
    emit(SendOTPLoadingState());

    try {
      var response = await DioHelper.postData(
          url: EndPoints.sendOTP, data: {"email": email});
      CacheHelper.saveData(key: tokenKey, value: response.data['token']);
      debugPrint("SendOTP token: ${response.data['token']}");
      emit(SendOTPSuccessState(successMessage: response.data['detail']));
      debugPrint("SendOTP Success: ${response.data['detail']}");
    } on DioError catch (e) {
      if (e.response != null) {
        emit(SendOTPFailureState(errMessage: e.response!.data['detail']));
        debugPrint("SendOTP error: ${e.response!.data['detail']}");
      }
    }
  }

  changePassword({
    required otpCode,
    required newPassword,
  }) async {
    emit(ChangePasswordLoadingState());

    try {
      Response response = await DioHelper.postData(
          url: EndPoints.changePassword,
          data: {'otp': otpCode, 'new_password': newPassword},
          token: 'Token ${CacheHelper.getData(key: tokenKey)}');

      debugPrint('ChangePassword Success: ${response.data['detail']} ');
      emit(ChangePasswordSuccessState(successMessage: response.data['detail']));
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(
            'ChangePassword Error: ${e.message} -- + ${e.response!.data['detail']}');
        emit(
            ChangePasswordFailureState(errMessage: e.response!.data['detail']));
      }
    }
  }
}
