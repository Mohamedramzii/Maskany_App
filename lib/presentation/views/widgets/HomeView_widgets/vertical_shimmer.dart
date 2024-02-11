// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class VerticalShimmer extends StatelessWidget {
  const VerticalShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: 2,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: Container(
            height: 100.h,
            // width: 350.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: Colors.grey.shade100,
            ),
          ),
        ),
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          height: 10.h,
        ),
      ),
    );
  }
}
