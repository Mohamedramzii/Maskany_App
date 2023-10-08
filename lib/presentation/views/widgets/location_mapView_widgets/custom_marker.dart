import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_resources/colors.dart';

class CustomMarker extends StatelessWidget {
  const CustomMarker({
    Key? key,
    required this.price,
    required this.isviewed,
  }) : super(key: key);

  final int price;
  final bool isviewed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      width: 70.w,
      child: Stack(
        clipBehavior: Clip.none,
        // alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              clipBehavior: Clip.none,
              width: 50.w,
              height: 30.h,
              decoration: BoxDecoration(
                  color: isviewed ? Colors.green : ColorsManager.kprimaryColor,
                  borderRadius: BorderRadius.circular(10.r)),
              child:
                  // Center(child: Text(price),)
                  Center(child: Text('${(price / 10000).toStringAsFixed(0)}K')),
            ),
          ),
          Positioned(
            top: 32.h,
            right: 11.w,
            child: ClipRRect(
              clipBehavior: Clip.none,
              child: Icon(
                Icons.arrow_drop_down,
                color: isviewed ? Colors.green : ColorsManager.kprimaryColor,
                size: 50,
              ),
            ),
          )
        ],
      ),
    );
  }
}
