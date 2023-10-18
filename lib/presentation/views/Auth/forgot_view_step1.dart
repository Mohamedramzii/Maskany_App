import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_animation_transition/animations/right_to_left_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

import '../../../core/app_resources/colors.dart';
import '../../../core/common_widgets/custom_buttom.dart';
import '../../../core/common_widgets/custom_snackbar.dart';
import '../../../core/common_widgets/custom_textformfield_widget.dart';
import '../../../core/constants.dart';
import '../../../generated/l10n.dart';
import '../../view_model/CUBIT/cubit/auth_cubit.dart';
import 'otpView.dart';

class ForgotViewStep1 extends StatefulWidget {
  const ForgotViewStep1({super.key});

  @override
  State<ForgotViewStep1> createState() => _ForgotViewStep1State();
}

class _ForgotViewStep1State extends State<ForgotViewStep1> {
  TextEditingController emailcontroller = TextEditingController();
  final formKey3 = GlobalKey<FormState>();

  // @override
  // void dispose() {
  //   emailcontroller.clear();
  //   emailcontroller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (BuildContext context, AuthState state) {
            if (state is SendOTPSuccessState) {
              SnackBars.successSnackBar(context, S.of(context).verificationcode,
                  state.successMessage);
              Navigator.push(
                  context,
                  PageAnimationTransition(
                      page: OTPView(email: emailcontroller.text),
                      pageAnimationType: RightToLeftTransition()));
            } else if (state is SendOTPFailureState) {
              SnackBars.failureSnackBar(
                  context, S.of(context).verificationcode, state.errMessage);
            }
          },
          builder: (context, state) {
            var cubit = BlocProvider.of<AuthCubit>(context);
            return Padding(
              padding: EdgeInsets.only(right: 16.w, left: 16.w, top: 60.h),
              child: Form(
                key: formKey3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).forgotpassword,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      S.of(context).enteremailorphoneOTP,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),

                    //! Email
                    CustomTextFormFieldWIdget(
                      controller: emailcontroller,
                      hinttext: S.of(context).enteremailorphone,
                      isEmail: true,
                      isPassword: false,
                      onsave: (newValue) {
                        emailcontroller.text = newValue!;
                      },
                      onvalidate: (value) {
                        if (!emailValidation.hasMatch(value!)) {
                          return S.of(context).erroremailorphone;
                        }
                        return null;
                      },
                      textInputType: TextInputType.emailAddress,
                      textinputaction: TextInputAction.next, obsecure: false,
                    ),

                    SizedBox(
                      height: 40.h,
                    ),
                    state is SendOTPLoadingState
                        ? Center(
                            child: LoadingAnimationWidget.staggeredDotsWave(
                                color: ColorsManager.kprimaryColor, size: 40.r),
                          )
                        : CustomButton(
                            text: S.of(context).Send,
                            onpressed: () {
                              if (formKey3.currentState!.validate()) {
                                formKey3.currentState!.save();

                                cubit.sendOTP(
                                    email: emailcontroller.text.trim());
                              }
                            }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
