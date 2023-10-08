import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../app_resources/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.onpressed,
  }) : super(key: key);
  final String text;
  final Function onpressed;

  @override
  Widget build(BuildContext context) {
    // var isTablet = MediaQuery.of(context).size.width > 451 && MediaQuery.of(context).size.width < 900 ;
    // var isMobile=  MediaQuery.of(context).size.width <= 450;

    return InkWell(
      onTap: () {
        onpressed();
      },
      child: Container(
        width: 345.w,
        height: ResponsiveBreakpoints.of(context).isMobile ? 45.h : 55.h,
        decoration: BoxDecoration(
            color: ColorsManager.kprimaryColor,
            borderRadius: BorderRadius.circular(15.r)),
        child: Center(
            child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        )),
      ),
    );
  }
}
