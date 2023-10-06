import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

import '../../../../core/app_resources/colors.dart';
import '../../../../core/app_resources/images.dart';
import 'custom_rowIcons.dart';

class CustomVerticalContainer extends StatelessWidget {
  const CustomVerticalContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: FittedBox(
        child: Container(
          width: 350.w,
          height:  ResponsiveBreakpoints.of(context).isMobile ? 90.h : 110.h ,
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: Colors.grey.shade100),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(height: 15.h,),
                  Text(
                    'فيلا مكونة من 6 غرف',
                    style: TextStyle(fontSize: 13.sp),
                  ),
                  Text(
                    'السعودية , الرياض',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    '120,000 / شهريأ',
                    style:
                        Theme.of(context).textTheme.bodySmall!.copyWith(color: ColorsManager.kprimaryColor),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      IconRow(
                        count: 25,
                        fontsize: 8,
                        icon: Icon(
                          Icons.bathtub_rounded,
                          size: 12.r,
                        ),
                      ),
                      IconRow(
                        count: 25,
                        fontsize: 8,
                        icon: Icon(
                          Icons.bathtub_rounded,
                          size: 12.r,
                        ),
                      ),
                      IconRow(
                        count: 25,
                        fontsize: 8,
                        icon: Icon(
                          Icons.bathtub_rounded,
                          size: 12.r,
                        ),
                      ),
                      IconRow(
                        count: 25,
                        fontsize: 8,
                        icon: Icon(
                          Icons.bathtub_rounded,
                          size: 12.r,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              FittedBox(
                child: SizedBox(
                    width: 200.w,
                    height: 150.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.r),
                      child: Image.asset(
                        Images.villa,
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
