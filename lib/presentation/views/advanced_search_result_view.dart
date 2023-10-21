import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maskany_app/presentation/views/details_view.dart';
import 'package:maskany_app/presentation/views/widgets/HomeView_widgets/custom_vertical_container.dart';
import 'package:page_animation_transition/animations/right_to_left_faded_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

import '../../data/models/propertiesModel/properties_model2/properties_model2.dart';

class AdvancedSearchResultView extends StatelessWidget {
  const AdvancedSearchResultView({super.key, required this.resultSearch});
  final List<PropertiesModel2> resultSearch;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50.h, left: 20.w, right: 20.w),
        child: Column(
          children: [
            Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            PageAnimationTransition(
                                page: DetailsView(model: resultSearch[index]),
                                pageAnimationType:
                                    RightToLeftFadedTransition())),
                        child: CustomVerticalContainer(
                            model: resultSearch[index], index: index),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 20.h,
                        ),
                    itemCount: resultSearch.length))
          ],
        ),
      ),
    );
  }
}
