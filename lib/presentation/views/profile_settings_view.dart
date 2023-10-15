import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:maskany_app/core/common_widgets/custom_buttom.dart';
import 'package:maskany_app/presentation/view_model/CUBIT/cubit/auth_cubit.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../core/app_resources/colors.dart';
import '../../core/app_resources/images.dart';

class ProfileSettingsVIew extends StatelessWidget {
  const ProfileSettingsVIew(
      {super.key, required this.email, required this.phoneNumber});
  final String email;
  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'معلومات شخصية',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BlocProvider.of<AuthCubit>(context);
          return state is UpdateUserDataLoadingState ||
                  state is GetUserDataLoadingState
              ? Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                      color: ColorsManager.kprimaryColor, size: 45.r),
                )
              : Padding(
                  padding: EdgeInsets.only(top: 25.h, left: 16.w, right: 16.h),
                  child: Flex(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    direction: Axis.vertical,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 55.r,
                              backgroundImage:  AssetImage(cubit.userdata!.image?? Images.profile),
                            ),
                          ),
                          Positioned(
                            right: ResponsiveBreakpoints.of(context).isTablet
                                ? 460
                                : 120.w,
                            top: 85.h,
                            child: Center(
                              child: ClipRRect(
                                  clipBehavior: Clip.none,
                                  child: SvgPicture.asset(
                                    Images.editimage,
                                    width: ResponsiveBreakpoints.of(context)
                                            .isTablet
                                        ? 50.w
                                        : null,
                                    height: ResponsiveBreakpoints.of(context)
                                            .isTablet
                                        ? 50.h
                                        : null,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text('معلومات الحساب',
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
                          height: 230.h,
                          padding: EdgeInsets.all(15.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            // border: Border.all(color: Colors.grey)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildRowdata(
                                label: 'رقم الهاتف',
                                hint: cubit.userdata!.phoneNumber ?? 'أضف رقم الهاتف',
                                needWidget: true,
                                whatToUpdate: 'phoneNumber',
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              _buildRowdata(
                                label: 'البريد الألكتروني',
                                hint: cubit.userdata!.email!,
                                needWidget: true,
                                whatToUpdate: 'email',
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              const _buildRowdata(
                                label: 'تاريخ الميلاد',
                                hint: '2000/01/25',
                                needWidget: true,
                                whatToUpdate: '',
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              _buildRowdata(
                                label: 'منطقة الحساب',
                                hint: cubit.userdata!.location ?? 'غير محدد',
                                needWidget: false,
                                whatToUpdate: '',
                              ),
                              Text(
                                '.يتم تحديد منطقة حسابك في البداية بناء علي وقت التسجيل ومكانه',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontSize: 5.sp),
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
                        child: CustomButton(
                            text: 'حفظ المعلومات', onpressed: () {}),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}

class _buildRowdata extends StatelessWidget {
  const _buildRowdata({
    super.key,
    required this.label,
    required this.hint,
    required this.needWidget,
    required this.whatToUpdate,
    // required this.ontap,
  });
  final String label;
  final String hint;
  final String whatToUpdate;
  final bool needWidget;
  // final Function() ontap;
  static TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.black),
        ),
        Row(
          children: [
            needWidget
                ? GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1)),
                            child: Container(
                              padding: EdgeInsets.all(16.0.r),
                              width: double.infinity,
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
                                      Text('تــغـير $label',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(color: Colors.black)),
                                    ],
                                  ),
                                  SizedBox(height: 16.0.h),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Text(
                                        'التعديل علي $label',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.0.h),
                                  SizedBox(
                                    height: 50.h,
                                    child: TextField(
                                      controller: controller,
                                      // onChanged: (value) {},
                                      onSubmitted: (value) {
                                        controller.text = value;
                                      },
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        // suffixIcon: IconButton(
                                        //     onPressed: () {},
                                        //     icon: const Icon(
                                        //         Icons.search_rounded)),
                                        hintText: hint,
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: Colors.grey,
                                            ),
                                        enabledBorder: OutlineInputBorder(
                                            // gapPadding: 0,
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                            borderSide: BorderSide(
                                              color: ColorsManager.borderColor,
                                              width: 2,
                                              strokeAlign: 1,
                                            )),
                                        focusedBorder: OutlineInputBorder(
                                          // gapPadding: 0,
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                          borderSide: BorderSide(
                                            color: ColorsManager.borderColor,
                                            width: 2,
                                            strokeAlign: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 50.0.h),
                                  CustomButton(
                                      text: 'حفـظ التــغيـرات',
                                      onpressed: () {
                                        Navigator.of(context).pop();
                                        if (controller.text.isNotEmpty) {
                                          BlocProvider.of<AuthCubit>(context)
                                              .updateUserData(
                                                  dataToChange: whatToUpdate,
                                                  updateData:
                                                      controller.text.isEmpty
                                                          ? "أضف $label"
                                                          : controller.text);
                                        }
                                        controller.clear();
                                      })
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: SvgPicture.asset(Images.editdata))
                : Container(),
            SizedBox(
              width: 5.w,
            ),
            Text(
              hint,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.black),
            )
          ],
        )
      ],
    );
  }
}
