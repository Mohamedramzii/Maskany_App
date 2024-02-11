// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../../../../core/app_resources/colors.dart';
import '../../../view_model/CUBIT/cubit/app_cubit.dart';

class CustomTextFieldForSearchView extends StatelessWidget {
  const CustomTextFieldForSearchView({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final AppCubit cubit;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: TextField(
        onChanged: (value) {
          cubit.getSearchedFor(value);
          cubit.emptyValue = value;
        },
        // onSubmitted: ,
        style: Theme.of(context).textTheme.bodyMedium,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: 'أبحث',
          hintStyle: Theme.of(context).textTheme.bodyMedium,
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
      ),
    );
  }
}
