import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maskany_app/generated/l10n.dart';
import 'package:maskany_app/presentation/views/Auth/location_view.dart';
import 'package:page_animation_transition/animations/left_to_right_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import '../../../../core/common_widgets/custom_snackbar.dart';
import '../../../../core/constants.dart';
import '../../../../data/data_sources/local/shared_pref.dart';
import '../../../../data/data_sources/network/dio_helper.dart';
import '../../../../data/models/login_model/login_model.dart';
import '../../../../data/models/login_model/login_model2/login_model2.dart';
import '../../../../data/models/register_model/register_model.dart';
import '../../../../data/models/register_model/register_model2/register_model2.dart';
import '../../../views/AppLayout.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

//! Login
  LoginModel2? loginModel;
  // String? successLogin = '';
  login({required emailOrphone, required password, context}) async {
    emit(LoginLoadingState());
    try {
      var response = await DioHelper.postData(
          url: EndPoints.login,
          data: {'email': emailOrphone, 'password': password});

      loginModel = LoginModel2.fromJson(response.data);
      debugPrint('Login Message: ${loginModel!.detail}');
      if (loginModel!.type == 'successful') {
        CacheHelper.saveData(key: tokenKey, value: loginModel!.token);
        SnackBars.successSnackBar(
            context, S.of(context).login, loginModel!.detail);
        Navigator.of(context).pushReplacement(PageAnimationTransition(
            page: const AppLayout(),
            pageAnimationType: LeftToRightTransition()));
      } else {
        SnackBars.failureSnackBar(
            context, S.of(context).login, loginModel!.detail);
      }
      // print(CacheHelper.getData(key: tokenKey));
      // successLogin = loginModel!.detail;
      // PageAnimationTransition(
      //           page: const AppLayout(),
      //           pageAnimationType: LeftToRightTransition());
      emit(LoginSuccessState(successMessage: loginModel!.detail!));
    } on DioError catch (e) {
      if (e.response != null) {
        emit(LoginFailureState(errMessage: e.response!.data['detail']));
      }
    }
  }

//! Register
  RegisterModel2? registerModel;
  register(
      {required username,
      required email,
      required phone,
      required password,
      context}) async {
    emit(RegisterLoadingState());

    try {
      var response = await DioHelper.postData(url: EndPoints.register, data: {
        'username': username,
        'email': email,
        'password': password,
      });

      registerModel = RegisterModel2.fromJson(response.data);
      debugPrint('Register Message: ${registerModel!.detail}');
      if (registerModel!.type == 'successful') {
        CacheHelper.saveData(key: tokenKey, value: registerModel!.token);
        SnackBars.successSnackBar(
            context, S.of(context).CreateAccount, registerModel!.detail);
        Navigator.of(context).pushReplacement(PageAnimationTransition(
            page:  LocationView(),
            pageAnimationType: LeftToRightTransition()));
      } else {
        SnackBars.failureSnackBar(
            context, S.of(context).CreateAccount, registerModel!.detail);
      }
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
