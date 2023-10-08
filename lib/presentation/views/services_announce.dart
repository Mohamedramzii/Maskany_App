import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/app_resources/colors.dart';
import '../../core/common_widgets/custom_buttom.dart';
import '../../generated/l10n.dart';
import 'AppLayout.dart';
import 'widgets/servicesView_widgets/custom_container.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

import '../../core/app_resources/fonts.dart';
import '../../data/models/services_model/services_model.dart';

class ServicesAnnouncementView extends StatelessWidget {
  const ServicesAnnouncementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(left: 35.w, right: 35.w, top: 50.h),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        PageAnimationTransition(
                            page: const AppLayout(),
                            pageAnimationType: BottomToTopTransition()));
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.red,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
              RichText(
                text: TextSpan(
                    text: 'مسكني',
                    style: Theme.of(context).textTheme.displayLarge,
                    children: [
                      const TextSpan(text: ' '),
                      TextSpan(
                          text: 'بلس',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(color: ColorsManager.kprimaryColor))
                    ]),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                S.of(context).belowMasknyPlus,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
              // SizedBox(
              //   height: 20.h,
              // ),
              Flexible(
                child: GridView.builder(
                  itemCount: service.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 15.w,
                      mainAxisSpacing: 40.h,
                      childAspectRatio: 0.76),
                  itemBuilder: (context, index) {
                    return CustomContainer(index: index);
                  },
                ),
              ),
              Text(
                '29.99' 'جنية/شهريا ',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.grey.shade500),
              ),
              SizedBox(
                height: 8.h,
              ),
              CustomButton(text: S.of(context).Subscribe, onpressed: () {}),
              SizedBox(
                height: 10.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
