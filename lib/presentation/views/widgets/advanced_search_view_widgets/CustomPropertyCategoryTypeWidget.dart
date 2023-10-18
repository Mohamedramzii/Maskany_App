import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_resources/colors.dart';

// ignore: must_be_immutable
class CustomPropertyCategoryTypeWidget extends StatelessWidget {
  CustomPropertyCategoryTypeWidget({
    super.key,
    required this.returnedtext,
    required this.list,
  });
  String returnedtext;
  final List list;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      hint: Text('نوع العقار',
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
          .map((category) => DropdownMenuItem<String>(
                value: category.name,
                child: Text(
                  category.name!,
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
