import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maskany_app/presentation/views/Auth/phone_number_check.dart';
import 'package:page_animation_transition/animations/left_to_right_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

import 'package:responsive_framework/responsive_framework.dart';

import '../../../core/common_widgets/custom_buttom.dart';
import '../../../core/common_widgets/custom_textformfield_widget.dart';
import '../../../core/constants.dart';
import '../../../generated/l10n.dart';
import '../../view_model/CUBIT/cubit/auth_cubit.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final formKey2 = GlobalKey<FormState>();
  TextEditingController fullnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController repasswordcontroller = TextEditingController();

  // @override
  // void dispose() {
  //   fullnamecontroller.dispose();
  //   emailcontroller.dispose();
  //   phonecontroller.dispose();
  //   passwordcontroller.dispose();
  //   repasswordcontroller.dispose();
  //   fullnamecontroller.clear();
  //   emailcontroller.clear();
  //   phonecontroller.clear();
  //   passwordcontroller.clear();
  //   repasswordcontroller.clear();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    //! SafeArea
    return Scaffold(
        // appBar: AppBar(
        //   elevation: 0,
        // ),
        body: BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // if (state is RegisterSuccessState) {
        //   SnackBars.successSnackBar(
        //       context, S.of(context).CreateAccount, state.successMessage);
        //   Navigator.push(
        //       context,
        //       PageAnimationTransition(
        //           page: LocationView(),
        //           pageAnimationType: RightToLeftTransition()));
        // } else if (state is RegisterFailureState) {
        //   SnackBars.failureSnackBar(
        //       context, S.of(context).CreateAccount, state.errMessage);
        // }
      },
      builder: (context, state) {
        var cubit = BlocProvider.of<AuthCubit>(context);
        return CustomScrollView(
          slivers: [
            SliverAppBar(),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) => Form(
                key: formKey2,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 16.w,
                    left: 16.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).CreateAccount,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        S.of(context).enteryouraccountdetails,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(
                        height: 45.h,
                      ),
                      //! Full Name
                      CustomTextFormFieldWIdget(
                        controller: fullnamecontroller,
                        hinttext: S.of(context).fullname,
                        isEmail: false,
                        isPassword: false,
                        onsave: (newValue) {
                          fullnamecontroller.text = newValue!;
                        },
                        onvalidate: (value) {
                          if (value!.length < 6) {
                            return S.of(context).errorName;
                          }
                          return null;
                        },
                        textInputType: TextInputType.text,
                        textinputaction: TextInputAction.next,
                        obsecure: false,
                      ),

                      SizedBox(
                        height: 20.h,
                      ),

                      //! Email
                      CustomTextFormFieldWIdget(
                        controller: emailcontroller,
                        hinttext: S.of(context).email,
                        isEmail: true,
                        isPassword: false,
                        onsave: (newValue) {
                          emailcontroller.text = newValue!;
                        },
                        onvalidate: (value) {
                          if (!emailValidation.hasMatch(value!)) {
                            return S.of(context).errorEmail;
                          }
                          return null;
                        },
                        textInputType: TextInputType.emailAddress,
                        textinputaction: TextInputAction.next,
                        obsecure: false,
                      ),

                      SizedBox(
                        height: 20.h,
                      ),

                      // //! Phone Number
                      // CustomTextFormFieldWIdget(
                      //   controller: phonecontroller,
                      //   hinttext: S.of(context).phone,
                      //   isEmail: false,
                      //   isPassword: false,
                      //   onsave: (newValue) {
                      //     phonecontroller.text = newValue!;
                      //   },
                      //   onvalidate: (value) {
                      //     if (value!.isNotEmpty && value.length < 11) {
                      //       return S.of(context).errorPhone;
                      //     }
                      //     return null;
                      //   },
                      //   textInputType: TextInputType.number,
                      //   textinputaction: TextInputAction.next,
                      //   obsecure: false,
                      // ),

                      // SizedBox(
                      //   height: 20.h,
                      // ),

                      //! Password
                      CustomTextFormFieldWIdget(
                        controller: passwordcontroller,
                        hinttext: S.of(context).password,
                        isEmail: false,
                        isPassword: cubit.isvisible,
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
                        obsecure: true,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      //! Re-Password
                      CustomTextFormFieldWIdget(
                        controller: repasswordcontroller,
                        // controller: passwordcontroller,
                        hinttext: S.of(context).repassword,
                        isEmail: false,
                        isPassword: cubit.isvisible,
                        onsave: (newValue) {
                          repasswordcontroller.text = newValue!;
                        },
                        onvalidate: (value) {
                          if (value!.length < 8 ||
                              value != passwordcontroller.text) {
                            return S.of(context).errorRePassword;
                          }
                          return null;
                        },
                        textInputType: TextInputType.text,
                        textinputaction: TextInputAction.done, obsecure: true,
                      ),

                      SizedBox(
                        height: 40.h,
                      ),
                      CustomButton(
                          text: 'ابدأ الأن',
                          onpressed: () async {
                            //! Attention here to uncommment these lines

                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) => PhoneNumberCheckView(),
                            // ));
                            if (formKey2.currentState!.validate()) {
                              formKey2.currentState!.save();

                              Navigator.of(context).push(
                                  PageAnimationTransition(
                                      page: PhoneNumberCheckView(
                                        email: emailcontroller.text.trim(),
                                        username:
                                            fullnamecontroller.text.trim(),
                                        password: passwordcontroller.text,
                                      ),
                                      pageAnimationType:
                                          LeftToRightTransition()));
                            }
                          }),

                      SizedBox(
                        height: ResponsiveBreakpoints.of(context).isMobile
                            ? 170.h
                            : 140.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(S.of(context).haveAnAccount,
                              style: Theme.of(context).textTheme.bodyMedium),
                          SizedBox(
                            width: 6.w,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(S.of(context).login,
                                  style:
                                      Theme.of(context).textTheme.bodySmall)),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      )
                    ],
                  ),
                ),
              ),
            ))
          ],
        );
      },
    ));
  }
}
