import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

import '../../../core/app_resources/colors.dart';
import '../../../core/app_resources/fonts.dart';
import '../../../core/common_widgets/custom_OTP.dart';
import '../../../core/common_widgets/custom_buttom.dart';
import '../../../core/common_widgets/custom_snackbar.dart';
import '../../../core/common_widgets/custom_textformfield_widget.dart';
import '../../../generated/l10n.dart';
import '../../view_model/CUBIT/cubit/auth_cubit.dart';
import 'login_view.dart';

class OTPView extends StatefulWidget {
  const OTPView({
    Key? key,
    required this.email,
  }) : super(key: key);
  final String email;

  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  TextEditingController pin1 = TextEditingController();
  TextEditingController pin2 = TextEditingController();
  TextEditingController pin3 = TextEditingController();
  TextEditingController pin4 = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController repasswordcontroller = TextEditingController();

  final formKey4 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccessState) {
            // Dialogs.successDialog(
            //     context,
            //   );
            SnackBars.successSnackBar(
                context, S.of(context).changePassword, state.successMessage);
            Navigator.of(context).pushReplacement(PageAnimationTransition(
                page: const LoginView(),
                pageAnimationType: BottomToTopTransition()));
          } else if (state is ChangePasswordFailureState) {
            SnackBars.failureSnackBar(
                context, S.of(context).changePassword, state.errMessage);
          }
        },
        builder: (context, state) {
          var cubit = BlocProvider.of<AuthCubit>(context);

          return Padding(
            padding: EdgeInsets.only(left: 16.h, right: 16.h),
            child: Align(
              alignment: Alignment.topRight,
              child: Form(
                key: formKey4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S.of(context).verificationcode,
                        style: Theme.of(context).textTheme.bodyLarge),
                    Text(S.of(context).belowVC,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.grey)),
                    Text(widget.email,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: ColorsManager.kprimaryColor)),
                    SizedBox(
                      height: 25.h,
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomOTPWidget(
                            pinController: pin1,
                            onsave: (newValue) {
                              pin1.text = newValue!;
                            },
                            onvalidate: (value) {
                              if (value!.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                          ),
                          CustomOTPWidget(
                            pinController: pin2,
                            onsave: (newValue) {
                              pin2.text = newValue!;
                            },
                            onvalidate: (value) {
                              if (value!.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                          ),
                          CustomOTPWidget(
                            pinController: pin3,
                            onsave: (newValue) {
                              pin3.text = newValue!;
                            },
                            onvalidate: (value) {
                              if (value!.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                          ),
                          CustomOTPWidget(
                            pinController: pin4,
                            onsave: (newValue) {
                              pin4.text = newValue!;
                            },
                            onvalidate: (value) {
                              if (value!.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    //! Password
                    CustomTextFormFieldWIdget(
                      controller: passwordcontroller,
                      hinttext: S.of(context).newPassowrd,
                      isEmail: true,
                      isPassword: true,
                      onsave: (newValue) {
                        passwordcontroller.text = newValue!;
                      },
                      onvalidate: (value) {
                        if (value!.length < 8) {
                          return S.of(context).errorpassword;
                        }
                        return null;
                      },
                      textInputType: TextInputType.text,
                      textinputaction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    //! rePassword
                    CustomTextFormFieldWIdget(
                      controller: repasswordcontroller,
                      hinttext: S.of(context).repassword,
                      isEmail: true,
                      isPassword: true,
                      onsave: (newValue) {
                        repasswordcontroller.text = newValue!;
                      },
                      onvalidate: (value) {
                        if (value != passwordcontroller.text) {
                          return S.of(context).errorRePassword;
                        }
                        return null;
                      },
                      textInputType: TextInputType.text,
                      textinputaction: TextInputAction.done,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    state is ChangePasswordLoadingState
                        ? Center(
                            child: LoadingAnimationWidget.staggeredDotsWave(
                                color: ColorsManager.kprimaryColor, size: 40.r),
                          )
                        : CustomButton(
                            text: S.of(context).change,
                            onpressed: () {
                              if (formKey4.currentState!.validate()) {
                                formKey4.currentState!.save();

                                cubit.changePassword(
                                    otpCode: pin1.text +
                                        pin2.text +
                                        pin3.text +
                                        pin4.text,
                                    newPassword:
                                        passwordcontroller.text.trim());
                              }
                            })
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
