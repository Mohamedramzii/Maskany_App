import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_resources/colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 10.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: ColorsManager.kprimaryColor),
    );
  }
}
