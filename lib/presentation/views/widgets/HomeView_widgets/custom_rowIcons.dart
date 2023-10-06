import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_resources/fonts.dart';

class IconRow extends StatelessWidget {
  const IconRow({
    Key? key,
    required this.count,
    required this.icon,
    required this.fontsize,
    this.style,
  }) : super(key: key);

  final int count;
  final Widget icon;
  final double fontsize;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          count.toString(),
          style: style ??
              Theme.of(context).textTheme.bodySmall!
                  .copyWith(fontSize: fontsize.sp, fontWeight: FontWeight.bold),
        ),
        icon,
        SizedBox(
          width: 2.w,
        )
      ],
    );
  }
}
