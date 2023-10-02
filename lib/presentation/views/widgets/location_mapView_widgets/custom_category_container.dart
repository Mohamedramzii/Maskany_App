import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_resources/colors.dart';
import '../../../../core/app_resources/fonts.dart';

class CustomCategoryContainer extends StatelessWidget {
  const CustomCategoryContainer({
    Key? key,
    required this.list,
    required this.index,
  }) : super(key: key);
  final List<String> list;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Container(
        width: 70.w,
        padding: EdgeInsets.all(3.r),
        alignment: Alignment.center,
        height: 40.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: ColorsManager.kprimaryColor,
        ),
        child: Text(
          list[index],
          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
