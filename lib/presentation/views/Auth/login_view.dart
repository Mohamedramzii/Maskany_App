import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_animation_transition/animations/left_to_right_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

import '../../../core/app_resources/colors.dart';
import '../../../core/app_resources/strings.dart';
import '../../../core/common_widgets/custom_buttom.dart';
import '../../../core/common_widgets/custom_snackbar.dart';
import '../../../core/common_widgets/custom_textformfield_widget.dart';
import '../../../core/constants.dart';
import '../../../generated/l10n.dart';
import '../../view_model/CUBIT/cubit/auth_cubit.dart';
import '../AppLayout.dart';
import 'forgot_view_step1.dart';
import 'register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  // @override
  // void dispose() {
  //   emailcontroller.dispose();
  //   passwordcontroller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // systemOverlayStyle:
      //   //     const SystemUiOverlayStyle(statusBarColor: Colors.white),
      // ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // if (state is LoginSuccessState) {
          // } else if (state is LoginFailureState) {
           
          // }
        },
        builder: (context, state) {
          var cubit = BlocProvider.of<AuthCubit>(context);
          return SafeArea(
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.only(right: 16.w, left: 16.w, top: 60.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).login,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      S.of(context).belowlogin,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(
                      height: 45.h,
                    ),

                    //! Email Or Phone
                    CustomTextFormFieldWIdget(
                      controller: emailcontroller,
                      hinttext: S.of(context).enteremailorphone,
                      isEmail: true,
                      isPassword: false,
                      onsave: (newValue) {
                        emailcontroller.text = newValue!;
                      },
                      onvalidate: (value) {
                        if (!emailValidation.hasMatch(value!) ||
                            value.length == 11) {
                          return S.of(context).erroremailorphone;
                        }
                        return null;
                      },
                      textInputType: TextInputType.emailAddress,
                      textinputaction: TextInputAction.next, obsecure: false,
                    ),

                    SizedBox(
                      height: 20.h,
                    ),
                    //! Password
                    CustomTextFormFieldWIdget(
                      controller: passwordcontroller,
                      // controller: passwordcontroller,
                      hinttext: S.of(context).enterpassword,
                      isEmail: true,
                      isPassword: cubit.isvisible,
                      onsave: (newValue) {
                        passwordcontroller.text = newValue!;
                      },
                      onvalidate: (value) {
                        if (value!.length < 4) {
                          return S.of(context).errorpassword;
                        }
                        return null;
                      },
                      textInputType: TextInputType.emailAddress,
                      textinputaction: TextInputAction.done, obsecure: true,
                    ),
                    SizedBox(
                      height: 9.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(PageAnimationTransition(
                            page: const ForgotViewStep1(),
                            pageAnimationType: LeftToRightTransition()));
                      },
                      child: Text(
                        S.of(context).forgotpassword,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),

                    SizedBox(
                      height: 40.h,
                    ),
                    state is LoginLoadingState
                        ? Center(
                            child: LoadingAnimationWidget.staggeredDotsWave(
                                color: ColorsManager.kprimaryColor, size: 40.r),
                          )
                        : CustomButton(
                            text: Strings.login,
                            onpressed: () async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();

                                await cubit.login(
                                    emailOrphone: emailcontroller.text.trim(),
                                    password: passwordcontroller.text.trim(),
                                    context: context);

                                emailcontroller.clear();
                                passwordcontroller.clear();
                              }
                            }),

                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(S.of(context).donthaveaccount,
                            style: Theme.of(context).textTheme.bodyMedium),
                        SizedBox(
                          width: 6.w,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  PageAnimationTransition(
                                      page: const RegisterView(),
                                      pageAnimationType:
                                          LeftToRightTransition()));
                            },
                            child: Text(S.of(context).soRegister,
                                style: Theme.of(context).textTheme.bodySmall)),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    )
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
