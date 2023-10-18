// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_resources/colors.dart';

class CustomLocationDropDownWidget extends StatelessWidget {
  CustomLocationDropDownWidget(
      {super.key, required this.list, required this.returnedtext});
  String returnedtext;
  final List list;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
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
      items: list
          .map((gov) => DropdownMenuItem<String>(
                value:  gov["governorate_name_ar"],
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
        returnedtext = value!;
      },
    );
  }
}
