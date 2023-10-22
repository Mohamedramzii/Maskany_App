import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_resources/colors.dart';

class CustomTextFieldForAdvSearch extends StatelessWidget {
  const CustomTextFieldForAdvSearch(
      {super.key, required this.controller, required this.hinttext});

  final TextEditingController controller;
  final String hinttext;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 33.h,
      child: TextField(
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.black,fontSize: 20.sp,fontWeight: FontWeight.normal
            ),
        // textAlign: TextAlign.start,
        // textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.number,
        controller: controller,
        onSubmitted: (value) {
          controller.text = value;
        },

        showCursor: true,

        decoration: InputDecoration(
          // alignLabelWithHint: true,
          // floatingLabelAlignment: FloatingLabelAlignment.center,
          hintText: hinttext,
          hintStyle: Theme.of(context).textTheme.bodySmall,
          enabledBorder: OutlineInputBorder(
              // gapPadding: 0,
              borderRadius: BorderRadius.circular(7.r),
              borderSide: BorderSide(
                color: ColorsManager.borderColor,
                width: 2,
                strokeAlign: 1,
              )),
          focusedBorder: OutlineInputBorder(
            // gapPadding: 0,
            borderRadius: BorderRadius.circular(7.r),
            borderSide: BorderSide(
              color: ColorsManager.borderColor,
              width: 2,
              strokeAlign: 1,
            ),
          ),
        ),
      ),
    );
  }
}
