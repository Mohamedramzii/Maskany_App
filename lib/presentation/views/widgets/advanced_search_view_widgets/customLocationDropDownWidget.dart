// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../../../../core/app_resources/colors.dart';
import '../../../../core/constants.dart';

class customLocationDropDownWidget extends StatelessWidget {
  const customLocationDropDownWidget({
    super.key,
    required this.locationcontroller,
  });

  final TextEditingController locationcontroller;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      borderRadius: BorderRadius.circular(20.r),
      hint: Text('الموقع لاختيار العقار',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: ColorsManager.kprimaryColor)),
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide:
                BorderSide(color: ColorsManager.kprimaryColor, width: 2)),
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
                child: Text(
                  gov["governorate_name_ar"],
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: ColorsManager.kprimaryColor),
                ),
              ))
          .toList(),
      onChanged: (value) {
        locationcontroller.text = value!;
      },
    );
  }
}
