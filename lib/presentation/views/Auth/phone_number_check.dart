// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/animations/left_to_right_faded_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

// Project imports:
import 'package:maskany_app/presentation/views/Auth/location_view.dart';
import '../../../core/common_widgets/custom_OTP.dart';
import '../../../core/common_widgets/custom_buttom.dart';
import '../../../core/common_widgets/custom_dialog.dart';
import '../../../core/common_widgets/custom_snackbar.dart';
import '../../../core/common_widgets/custom_textformfield_widget.dart';
import '../../../generated/l10n.dart';
import '../../view_model/CUBIT/cubit/auth_cubit.dart';
import 'login_view.dart';

class PhoneNumberCheckView extends StatefulWidget {
  const PhoneNumberCheckView({
    Key? key,
    required this.email,
    required this.username,
    required this.password,
  }) : super(key: key);
  final String email;
  final String username;
  final String password;

  @override
  State<PhoneNumberCheckView> createState() => _PhoneNumberCheckViewState();
}

class _PhoneNumberCheckViewState extends State<PhoneNumberCheckView> {
  TextEditingController pin1 = TextEditingController();
  TextEditingController pin2 = TextEditingController();
  TextEditingController pin3 = TextEditingController();
  TextEditingController pin4 = TextEditingController();

  TextEditingController phoneNumber_controller = TextEditingController();
  // TextEditingController repasswordcontroller = TextEditingController();

  final formKey5 = GlobalKey<FormState>();
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
            Dialogs.successDialog(
                context,
                'أبدأ الأن',
                () => Navigator.of(context).pushReplacement(
                    PageAnimationTransition(
                        page: const LoginView(),
                        pageAnimationType: BottomToTopTransition())));
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
                key: formKey5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S.of(context).phone,
                        style: Theme.of(context).textTheme.bodyLarge),
                    // Text(S.of(context).enterPhoneNumber,
                    //     style: Theme.of(context)
                    //         .textTheme
                    //         .bodyMedium!
                    //         .copyWith(color: Colors.grey)),
                    SizedBox(
                      height: 20.h,
                    ),
                    //! Phone Number
                    CustomTextFormFieldWIdget(
                      controller: phoneNumber_controller,
                      hinttext: S.of(context).phone,
                      isEmail: true,
                      isPassword: false,
                      onsave: (newValue) {
                        phoneNumber_controller.text = newValue!;
                      },
                      onvalidate: (value) {
                        if (value!.length < 11) {
                          return S.of(context).errorPhone;
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

                    Visibility(
                      visible: cubit.isPhoneNumberCorrectandSMSCodeSent,
                      replacement: Container(),
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
                          // Text(widget.email,
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .bodyMedium!
                          //         .copyWith(color: ColorsManager.kprimaryColor)),
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),

                    !cubit.isPhoneNumberCorrectandSMSCodeSent
                        ? CustomButton(
                            text: 'ارسال',
                            onpressed: () {
                              if (formKey5.currentState!.validate()) {
                                formKey5.currentState!.save();
                                //! Send phone number to server to  check
                                cubit.sendingPhoneNumberToRetrieveSMScode(
                                    phoneNumber:
                                        phoneNumber_controller.text.trim());
                              }
                            })
                        : CustomButton(
                            text: 'تحقق',
                            onpressed: () {
                              if (formKey5.currentState!.validate()) {
                                formKey5.currentState!.save();

                                //! Check if the entered code is the same like the sent code then navigate to location view
                                cubit.checkIfServerOtpAndUserOtpAreMatched(
                                    code: pin1.text +
                                        pin2.text +
                                        pin3.text +
                                        pin4.text);
                                if (cubit.isOtpCorrect == true) {
                                  Navigator.of(context).push(
                                      PageAnimationTransition(
                                          page: LocationView(
                                            email: widget.email,
                                            username: widget.username,
                                            password: widget.password,
                                            phoneNumber: phoneNumber_controller
                                                .text
                                                .trim(),
                                          ),
                                          pageAnimationType:
                                              LeftToRightFadedTransition()));
                                } else {
                                  Flushbar(
                                    message: 'تأكد من كتابة الرمز المرسل اليك ',
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 3),
                                    flushbarStyle: FlushbarStyle.GROUNDED,
                                  )..show(context);
                                }
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
