import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


abstract class SnackBars {
  static successSnackBar(context, proccessText, successtext) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      width: double.infinity,
      duration: const Duration(milliseconds: 500),
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      backgroundColor: Colors.white,
      content: Container(
        // alignment: Alignment.topLeft,
        height: 80.h,
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: Colors.green.shade100.withOpacity(0.2),
          borderRadius: BorderRadiusDirectional.circular(15.r),
          border: Border.all(color: Colors.green, width: 3),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 25.w,
              height: 25.h,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.green, width: 2)),
              child: Icon(
                Icons.done,
                color: Colors.green,
                size: 15.r,
                fill: 1,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  proccessText,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 17),
                ),
                Text(
                  successtext,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  static failureSnackBar(context, proccessText, failureText) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      width: double.infinity,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      backgroundColor: Colors.white,
      content: Container(
        // alignment: Alignment.topLeft,
        height: 80.h,
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: Colors.red.shade100.withOpacity(0.2),
          borderRadius: BorderRadiusDirectional.circular(15.r),
          border: Border.all(color: Colors.red, width: 3),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 25.w,
              height: 25.h,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red, width: 2)),
              child: Icon(
                Icons.cancel_rounded,
                color: Colors.red,
                size: 15.r,
                fill: 1,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  proccessText,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 17),
                ),
                Text(
                  failureText,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
