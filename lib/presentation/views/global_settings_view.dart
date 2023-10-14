import 'package:csc_picker/dropdown_with_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:maskany_app/core/common_widgets/custom_buttom.dart';
import 'package:maskany_app/presentation/view_model/CUBIT/cubit/auth_cubit.dart';

import '../../core/app_resources/colors.dart';
import '../../core/app_resources/images.dart';
import '../../core/common_widgets/custom_OTP.dart';
import '../../core/common_widgets/custom_dialog.dart';

class GlobalSettingsView extends StatelessWidget {
  const GlobalSettingsView({super.key});
  static TextEditingController emailController = TextEditingController();
  static TextEditingController pin1 = TextEditingController();
  static TextEditingController pin2 = TextEditingController();
  static TextEditingController pin3 = TextEditingController();
  static TextEditingController pin4 = TextEditingController();
  static TextEditingController passwordcontroller = TextEditingController();

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الاعــدادات العـامـة',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccessState) {
            Dialogs.successDialog(
              context,
              'أبدأ الان',
              () => Navigator.of(context).pop(),
            );
          }
        },
        builder: (context, state) => Padding(
          padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text('الاعــدادات',
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.bodyMedium!
                  // .copyWith(color: Colors.grey),
                  ),
              SizedBox(
                height: 10.h,
              ),
              Card(
                // color: Colors.white,
                elevation: 5,
                surfaceTintColor: Colors.white,
                child: Container(
                  width: double.infinity,
                  height: 130.h,
                  padding: EdgeInsets.all(15.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    // border: Border.all(color: Colors.grey)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'تـغير كلمة المرور',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black, fontSize: 13.sp),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          insertEmailDialog(context, state);
                        },
                        child: SvgPicture.asset(
                          Images.editdata,
                          height: 16.h,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: CustomButton(text: 'حفظ المعلومات', onpressed: () {}),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> insertEmailDialog(
      BuildContext context, AuthState state) async {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
          child: Container(
            padding: EdgeInsets.all(16.0.r),
            width: double.infinity,
            // height: 260.h,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      Images.editdata,
                      width: 17.w,
                    ),
                    Text('ادخل عنوان البريد الالكتروني',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black)),
                  ],
                ),
                // SizedBox(height: 16.0.h),
                Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      '''قد يتم استخدام عنوان بريدك الالكتروني لتوصيلك باشخاص قد تعرفهم
وتحسين الإعلانات والمزيد , بناء علي اعداداتك''',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 8.sp),
                    ),
                  ],
                ),
                SizedBox(height: 12.0.h),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: SizedBox(
                    height: 50.h,
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      // onChanged: (value) {},
                      onSubmitted: (value) {
                        emailController.text = value;
                      },
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        // suffixIcon: IconButton(
                        //     onPressed: () {},
                        //     icon: const Icon(
                        //         Icons.search_rounded)),
                        hintText: 'عنوان البريد الالكتروني',
                        hintStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.grey,
                                ),
                        enabledBorder: OutlineInputBorder(
                            // gapPadding: 0,
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide(
                              color: ColorsManager.borderColor,
                              width: 2,
                              strokeAlign: 1,
                            )),
                        focusedBorder: OutlineInputBorder(
                          // gapPadding: 0,
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: ColorsManager.borderColor,
                            width: 2,
                            strokeAlign: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 60.0.h),
                CustomButton(
                    text: 'ارسال الرمز',
                    onpressed: () async {
                      if (emailController.text.isNotEmpty) {
                        BlocProvider.of<AuthCubit>(context)
                            .sendOTP(email: emailController.text.trim());
                        Navigator.of(context).pop();
                        emailController.clear();
                        InsertOTPDialog(context, state);
                      }
                    }),
                SizedBox(height: 18.0.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> InsertOTPDialog(BuildContext context, AuthState state) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
          child: Container(
            padding: EdgeInsets.all(16.0.r),
            width: double.infinity,
            // height: 260.h,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      Images.editdata,
                      width: 17.w,
                    ),
                    Text('ادخل الرمز المكون من 4 ارقام',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black)),
                  ],
                ),
                Text('تم ارسال الرمز الخاص بك في رسالة بريد الكترونية',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 8.sp)),
                // SizedBox(height: 16.0.h),
                Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                  ],
                ),
                SizedBox(height: 12.0.h),
                // Text(
                //   'أدخل الرمز',
                //   style: Theme.of(context).textTheme.bodySmall,
                // ),
                // SizedBox(height: 12.0.h),
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
                SizedBox(height: 12.0.h),
                Text(
                  'ادخل كلمة المرور الجديدة',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(height: 12.0.h),
                SizedBox(
                  height: 50.h,
                  child: TextField(
                    controller: passwordcontroller,
                    obscureText: true,
                    // onChanged: (value) {},
                    onSubmitted: (value) {
                      passwordcontroller.text = value;
                    },
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      // suffixIcon: IconButton(
                      //     onPressed: () {},
                      //     icon: const Icon(
                      //         Icons.search_rounded)),
                      hintText: 'كلمة المرور الجديدة',
                      hintStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Colors.grey,
                              ),
                      enabledBorder: OutlineInputBorder(
                          // gapPadding: 0,
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            color: ColorsManager.borderColor,
                            width: 2,
                            strokeAlign: 1,
                          )),
                      focusedBorder: OutlineInputBorder(
                        // gapPadding: 0,
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: ColorsManager.borderColor,
                          width: 2,
                          strokeAlign: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 60.0.h),
               CustomButton(
                        text: 'تغيير كلمة المرور',
                        onpressed: () {
                          if (pin1.text.isNotEmpty &&
                              pin2.text.isNotEmpty &&
                              pin3.text.isNotEmpty &&
                              pin4.text.isNotEmpty &&
                              passwordcontroller.text.isNotEmpty) {
                            BlocProvider.of<AuthCubit>(context).changePassword(
                                otpCode: pin1.text +
                                    pin2.text +
                                    pin3.text +
                                    pin4.text,
                                newPassword: passwordcontroller.text.trim());
                          }
                       Navigator.of(context).pop();
                          pin1.clear();
                          pin2.clear();
                          pin3.clear();
                          pin4.clear();
                          passwordcontroller.clear();
                        }),
                SizedBox(height: 18.0.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
