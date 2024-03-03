// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_animation_transition/animations/left_to_right_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

// Project imports:
import 'package:maskany_app/data/models/userdata_model/user_data_model.dart';
import 'package:maskany_app/generated/l10n.dart';
import 'package:maskany_app/presentation/view_model/CUBIT/cubit/app_cubit.dart';
import 'package:maskany_app/presentation/views/services_announce.dart';
import '../../../../core/common_widgets/custom_snackbar.dart';
import '../../../../core/constants.dart';
import '../../../../data/data_sources/local/shared_pref.dart';
import '../../../../data/data_sources/network/dio_helper.dart';
import '../../../../data/models/login_model/login_model2/login_model2.dart';
import '../../../../data/models/register_model/register_model2/register_model2.dart';
import '../../../views/AppLayout.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  bool isUserChangedHisLocation = false;
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
        tokenHolder = loginModel!.token!;
        CacheHelper.saveData(key: tokenKey, value: tokenHolder);
        // CacheHelper.saveData(key: tokenKey, value: loginModel!.token);
        SnackBars.successSnackBar(
            context, S.of(context).login, loginModel!.detail);
        Navigator.of(context)
            .pushReplacement(PageAnimationTransition(
                page: const AppLayout(),
                pageAnimationType: LeftToRightTransition()))
            //! recently added 2/10/2024
            .then((value) => BlocProvider.of<AppCubit>(context).btmNavBar(0));
      } else {
        SnackBars.failureSnackBar(
            context, S.of(context).login, loginModel!.detail);
      }
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
      required location,
      context}) async {
    emit(RegisterLoadingState());

    try {
      Response response =
          await DioHelper.postData(url: EndPoints.register, data: {
        'username': username,
        'email': email,
        'password': password,
        'phoneNumber': phone,
        'location': location
      });

      registerModel = RegisterModel2.fromJson(response.data);
      // debugPrint('Register Message: ${registerModel!.detail}');
      if (response.statusCode == 200) {
        tokenHolder = registerModel!.token!;
        CacheHelper.saveData(key: tokenKey, value: tokenHolder);
        SnackBars.successSnackBar(
            context, S.of(context).CreateAccount, 'تم انشاء الحساب بنجاح');
        Navigator.of(context).pushReplacement(PageAnimationTransition(
            page: const ServicesAnnouncementView(),
            pageAnimationType: LeftToRightTransition()));
      } else {
        SnackBars.failureSnackBar(context, S.of(context).CreateAccount,
            'تم استخدام هذا البريد الالكتروني من قبل');
      }
      emit(RegisterSuccessState(successMessage: 'تم انشاء الحساب بنجاح'));
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint('Register Error: ${e.response!.data['detail']}');
        emit(RegisterFailureState(errMessage: e.message.toString()));
      }
    }
  }
String? otpToken;
  sendOTP({required email}) async {
    emit(SendOTPLoadingState());

    try {
      var response = await DioHelper.postData(
          url: EndPoints.sendOTP, data: {"email": email});

      if(response.statusCode == 200){
        otpToken=response.data['token'];
        debugPrint('OTP Token: $otpToken');
        emit(SendOTPSuccessState(successMessage: response.data['detail']));
      }else{
        emit(SendOTPFailureState(errMessage: response.data['detail']));
      }
      debugPrint("SendOTP Success: ${response.data['detail']}");
    } on DioError catch (e) {
      if (e.response != null) {
        emit(SendOTPFailureState(errMessage: e.response!.data['detail']));
        debugPrint("SendOTP error: ${e.response!.data['detail']}");
      }
    }
  }

  String wrongOTP = '';
  bool isOTPwrong = false;
  changePassword({
    required otpCode,
    required newPassword,
  }) async {
    emit(ChangePasswordLoadingState());

    try {
      debugPrint('OTP sent is : $otpCode ');
      Response response = await DioHelper.postData(
          url: EndPoints.changePassword,
          data: {'otp': otpCode, 'new_password': newPassword},
          token: 'Token $otpToken');

      if (response.statusCode == 200) {
        debugPrint('ChangePassword Success: ${response.data['detail']} ');
        emit(ChangePasswordSuccessState(
            successMessage: response.data['detail']));
      } else if (response.statusCode == 400) {
        wrongOTP = response.data['detail'];
        isOTPwrong = true;
        emit(ChangePasswordFailureState(errMessage: response.data['detail']));
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(
            'ChangePassword Error: ${e.message} -- + ${e.response!.data['detail']}');
        emit(
            ChangePasswordFailureState(errMessage: e.response!.data['detail']));
      }
    }
  }

  bool isvisible = true;
  toggleVisibility() {
    isvisible = !isvisible;
    emit(ToggleVisibilitystate());
  }

  UserDataModel? userdata;
  getUserData() async {
    emit(GetUserDataLoadingState());

    try {
      Response response = await DioHelper.getData(
          url: EndPoints.userData, token: 'Token $tokenHolder');

      userdata = UserDataModel.fromJson(response.data);
      debugPrint('Username : ${userdata!.username ?? 'Guest'}');
      emit(GetUserDataSuccessState());
    } catch (e) {
      emit(GetUserDataFailureState(errMessage: e.toString()));
    }
  }

  String emailIsExistMsg = '';
  bool isEmailExist = false;
  updateUserData(
      {required String dataToChange, required dynamic updateData}) async {
    emit(UpdateUserDataLoadingState());

    try {
      Response response = await DioHelper.putData(
          url: EndPoints.updateUserData,
          data: {dataToChange: updateData},
          token: 'Token $tokenHolder');
      if (response.statusCode == 400) {
        // emailIsExistMsg = response.data['email'];
        isEmailExist = true;
        print(isEmailExist);
      } else {
        await getUserData();
      }

      emit(UpdateUserDataSuccessState());
    } catch (e) {
      print(e.toString());
      emit(UpdateUserDataFailureState(errMessage: e.toString()));
    }
  }

  File? image;
  final imagePicker = ImagePicker();
  pickImage() async {
    var pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      FormData formdata = FormData.fromMap({
        'image': await MultipartFile.fromFile(pickedImage.path),
      });
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Token $tokenHolder';
      Response response = await dio
          .put('http://66.45.248.247:8000/auth/user/update/', data: formdata);
      if (response.statusCode == 200) {
        debugPrint('Success While Posting Profile Image');
        debugPrint(pickedImage.path);
      } else {
        debugPrint('Error While Posting Profile Image');
        debugPrint(pickedImage.path);
      }
      getUserData();
      emit(ImagePickerSuccessState());
    } else {}
  }

  //! Check if Phone number is sent or not
  bool isPhoneNumberCorrectandSMSCodeSent = false;
  String correctOTP = '';
  sendingEmailToRetrieveSMScode({
    required String email,
  }) async {
    isPhoneNumberCorrectandSMSCodeSent = true;
    print('SMS Is Sent ==>$isPhoneNumberCorrectandSMSCodeSent ');
    emit(SmsCodeSentLoadinhState());
    try {
      Response response = await DioHelper.getData(
          url: 'http://66.45.248.247:8000/auth/sms/',
          query: {'email': email});
      correctOTP = response.data['otp'];
      print('Server OTP : $correctOTP');

      emit(SmsCodeSentSuccesState());
    } catch (e) {
      emit(SmsCodeSentFailureState());
    }
  }

  bool isOtpCorrect = false;
  checkIfServerOtpAndUserOtpAreMatched({required String code}) {
    if (correctOTP == code) {
      isOtpCorrect = true;
      debugPrint('Server OTP $correctOTP  == UserOTP $code');
    }
    emit(OTPMatchedSuccesState());
  }

  logout(context) async {
    CacheHelper.clearData(key: tokenKey);
    debugPrint(
        'After Logging out, token is ${CacheHelper.getData(key: tokenKey)}');
    isAllRequestsDone = false;
    // userdata = null;
    // userdata!.location = null;
    BlocProvider.of<AppCubit>(context).property = [];
    BlocProvider.of<AppCubit>(context).allProperties = [];
    BlocProvider.of<AppCubit>(context).allnearestProperties = [];
    BlocProvider.of<AppCubit>(context).allfavorites = [];
    BlocProvider.of<AppCubit>(context).favoritesID = {};
    emit(UserLoggedOutSuccessState());
  }
}
