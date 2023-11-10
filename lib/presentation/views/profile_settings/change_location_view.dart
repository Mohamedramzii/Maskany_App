import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:maskany_app/presentation/view_model/CUBIT/cubit/app_cubit.dart';
import 'package:maskany_app/presentation/view_model/CUBIT/cubit/auth_cubit.dart';

import '../../../core/app_resources/colors.dart';
import '../../../core/common_widgets/custom_buttom.dart';
import '../../../core/constants.dart';
import '../../../generated/l10n.dart';

class ChangeUserLocation extends StatelessWidget {
  ChangeUserLocation({super.key});
  String govern = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<AuthCubit, AuthState>(
      builder: (BuildContext context, AuthState state) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          child: Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.h,
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(S.of(context).location,
                          style: Theme.of(context).textTheme.bodyLarge),
                      Text(S.of(context).belowLocation,
                          style: Theme.of(context).textTheme.bodySmall),
                      SizedBox(
                        height: 30.h,
                      ),
                      DropdownButtonFormField<String>(
                        hint: Text('المحافظة',
                            style: Theme.of(context).textTheme.bodyMedium),
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                              borderSide: BorderSide(
                                  color: ColorsManager.borderColor, width: 2)),
                          enabledBorder: OutlineInputBorder(
                              // gapPadding: 0,
                              borderRadius: BorderRadius.circular(15.r),
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
                        items: gov
                            .map((gov) => DropdownMenuItem<String>(
                                  value: gov["governorate_name_ar"],
                                  child: Text(gov["governorate_name_ar"]),
                                ))
                            .toList(),
                        onChanged: (value) {
                          govern = value!;
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      state is UpdateUserDataLoadingState
                          ? Center(
                              child: LoadingAnimationWidget.staggeredDotsWave(
                                  color: ColorsManager.kprimaryColor,
                                  size: 40.r),
                            )
                          : CustomButton(
                              text: 'تغيير',
                              onpressed: () {
                                if (govern.isNotEmpty) {
                                  BlocProvider.of<AuthCubit>(context)
                                      .updateUserData(
                                          dataToChange: 'location',
                                          updateData: govern);
                                  BlocProvider.of<AuthCubit>(context)
                                      .isUserChangedHisLocation = true;
                                  Navigator.of(context).pop();
                                }
                              })
                    ]),
              ))),
    ));
  }
}
