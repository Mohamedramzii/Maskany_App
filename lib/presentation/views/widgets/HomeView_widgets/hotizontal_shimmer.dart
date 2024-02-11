// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HorizontalShimmer extends StatelessWidget {
  const HorizontalShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: Container(
            height: 150.h,
            width: 150.w,
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(15.r)),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          ),
        ),
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          width: 10.w,
        ),
      ),
    );
  }
}
