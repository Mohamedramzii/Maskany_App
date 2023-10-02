import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/models/propertiesModel/propertiesModel.dart';
import 'custom_btmsheet_card.dart';
import 'custom_divider.dart';

abstract class LocationBottomSheet {
  static Future<dynamic> locationBTMSheet(
      context, PropertiesModel model) {
    return showModalBottomSheet(
      enableDrag: true,
      useSafeArea: true,
      context: context,
      builder: (context) {
        //! Outer Container
        return Container(
          height: 300.h,
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30.w,
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
                 CustomBtmsheetCard(
                  model: model
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
