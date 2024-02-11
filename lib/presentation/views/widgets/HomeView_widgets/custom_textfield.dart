// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_animation_transition/animations/top_to_bottom_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

// Project imports:
import '../../Search/search_view.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageAnimationTransition(
            page: const SearchView(),
            pageAnimationType: TopToBottomTransition()));
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
