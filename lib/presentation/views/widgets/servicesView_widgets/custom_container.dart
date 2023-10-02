import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/models/services_model/services_model.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Container(
            width: 70.w,
            height: 70.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11.r),
                color: Colors.grey.shade200,
                boxShadow: const [
                  BoxShadow(color: Colors.grey, blurRadius: 0.5)
                ]),
            child: Image.asset(
              service[index].image,
            ),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          service[index].text,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        )
      ],
    ).animate().slide(
        duration: const Duration(milliseconds: 400),
        begin: const Offset(0.9, 0));
  }
}
