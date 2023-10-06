import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        
      },
      child: Container(
        width: double.infinity,
        height: 45.h,
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: Colors.grey.shade500)),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: Colors.grey.shade400,
              size: 30.r,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              'أبحث',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 17.sp),
            )
          ],
        ),
      ),
    );
  }
}
