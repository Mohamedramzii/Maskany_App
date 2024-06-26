// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_framework/responsive_framework.dart';

// Project imports:
import 'package:maskany_app/core/common_widgets/custom_buttom.dart';
import 'package:maskany_app/presentation/view_model/CUBIT/cubit/auth_cubit.dart';
import '../../../core/app_resources/colors.dart';
import '../../../core/app_resources/images.dart';
import '../../../core/common_widgets/custom_snackbar.dart';

class ProfileSettingsVIew extends StatelessWidget {
  const ProfileSettingsVIew(
      {super.key,
      required this.email,
      required this.phoneNumber,
      required this.userlocation});
  final String email;
  final String phoneNumber;
  final String userlocation;
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
                  child: SingleChildScrollView(
                    child: Flex(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      direction: Axis.vertical,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.r),
                                child: Container(
                                  width: 100.w,
                                  height: 100.h,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(50.r)),
                                  child: state is GetUserDataLoadingState
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : cubit.userdata?.image != null
                                          ? Image.network(
                                              cubit.userdata!.image!,
                                              fit: BoxFit.cover,
                                            )
                                          : cubit.image != null
                                              ? Image.file(
                                                  cubit.image!,
                                                  fit: BoxFit.cover,
                                                )
                                              : SvgPicture.asset(Images.user,
                                                  fit: BoxFit.cover),
                                  // cubit.image != null
                                  //     ? Image.file(
                                  //         cubit.image!,
                                  //         fit: BoxFit.cover,
                                  //       )
                                  //     : Image.asset(Images.profile,
                                  //         fit: BoxFit.cover),
                                ),
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
                                    child: GestureDetector(
                                      onTap: () => cubit.pickImage(),
                                      child: SvgPicture.asset(
                                        Images.editimage,
                                        width: ResponsiveBreakpoints.of(context)
                                                .isTablet
                                            ? 50.w
                                            : null,
                                        height:
                                            ResponsiveBreakpoints.of(context)
                                                    .isTablet
                                                ? 50.h
                                                : null,
                                      ),
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
                                  hint: cubit.userdata!.phoneNumber ??
                                      'أضف رقم الهاتف',
                                  needWidget: true,
                                  whatToUpdate: 'phoneNumber',
                                  nottochange: false,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                _buildRowdata(
                                  label: 'البريد الألكتروني',
                                  hint: cubit.userdata!.email!,
                                  needWidget: true,
                                  whatToUpdate: 'email',
                                  nottochange: false,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                const _buildRowdata(
                                  label: 'تاريخ الميلاد',
                                  hint: '2000/01/25',
                                  needWidget: false,
                                  whatToUpdate: '',
                                  nottochange: true,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                _buildRowdata(
                                  label: 'منطقة الحساب',
                                  hint: cubit.userdata!.location ?? 'غير محدد',
                                  needWidget: false,
                                  whatToUpdate: '',
                                  nottochange: true,
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
                  ),
                );
        },
      ),
    );
  }
}

class _buildRowdata extends StatelessWidget {
  const _buildRowdata({
    //!removed 2/11/2024
    // super.key,
    required this.label,
    required this.hint,
    required this.needWidget,
    required this.whatToUpdate,
    required this.nottochange,
    // required this.ontap,
  });
  final String label;
  final String hint;
  final String whatToUpdate;
  final bool needWidget;
  final bool nottochange;
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
        !needWidget && !nottochange
            ? Container()
            : GestureDetector(
                onTap: () {
                  if (nottochange) {
                    return null;
                  }
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
                                height: 60.h,
                                child: TextField(
                                  controller: controller,
                                  // onChanged: (value) {},
                                  onSubmitted: (value) {
                                    controller.text = value;
                                  },
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  textAlignVertical: TextAlignVertical.center,
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
                                      borderRadius: BorderRadius.circular(15.r),
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
                                      if (!BlocProvider.of<AuthCubit>(context)
                                          .isEmailExist) {
                                        BlocProvider.of<AuthCubit>(context)
                                            .updateUserData(
                                                dataToChange: whatToUpdate,
                                                updateData:
                                                    controller.text.isEmpty
                                                        ? "أضف $label"
                                                        : controller.text);
                                      } else {
                                        return SnackBars.failureSnackBar(
                                            context,
                                            'تغيير البريد الالكتروني',
                                            'هذا الايميل مستخدم من قبل');
                                      }
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
                child: Row(
                  children: [
                    if (!nottochange) SvgPicture.asset(Images.editdata),
                    SizedBox(
                      width: 5.w,
                    ),
                    SizedBox(
                      child: Text(
                        hint,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black),
                      ),
                    )
                  ],
                ),
              )
      ],
    );
  }
}
