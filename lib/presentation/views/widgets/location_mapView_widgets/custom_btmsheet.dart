// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'custom_btmsheet_card.dart';
import 'custom_divider.dart';

abstract class LocationBottomSheet {
  static Future<dynamic> locationBTMSheet(context, model) {
    return showModalBottomSheet(
      enableDrag: true,
      useSafeArea: true,
      isScrollControlled: true,
      constraints: BoxConstraints(
        minWidth: 400.w,
        maxWidth: 900.w,
      ),
      context: context,
      builder: (context) {
        //! Outer Container
        return Container(
          height: 300.h,
          // width: ResponsiveBreakpoints.of(context).isTablet ? 700.w : 350.w,
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                //! Divider
                const CustomDivider(),
                SizedBox(
                  height: 20.h,
                ),
                //! Core Container
                CustomBtmsheetCard(model: model)
              ],
            ),
          ),
        );
      },
    );
  }
}
