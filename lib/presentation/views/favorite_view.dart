import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/app_resources/fonts.dart';
import 'widgets/HomeView_widgets/custom_horizontalContainer.dart';

import '../../core/app_resources/colors.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: EdgeInsets.only(left: 16.h, right: 16.h,top: 16.h),
        child: Column(
          children: [
            Text(
          'المفضلة',
          style: Fonts.large,
          textAlign: TextAlign.center,
        ),
            Row(
              children: [
                Icon(Icons.location_on_outlined,
                    color: ColorsManager.kprimaryColor),
                SizedBox(
                  width: 6.w,
                ),
                Text(
                  'السعودية, البارحة',
                  style: Fonts.xsmall,
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
                child: GridView.builder(
              // addAutomaticKeepAlives: true,
              physics: const BouncingScrollPhysics(),
              // shrinkWrap: false,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.80),
              itemBuilder: (context, index) =>  CustomHorizontalCOntainer(model: const [],index: 0,),
              itemCount: 10,
            ))
          ],
        ),
      ),
    );
  }
}
