import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maskany_app/core/app_resources/colors.dart';
import 'package:maskany_app/core/common_widgets/custom_buttom.dart';

import '../../core/app_resources/images.dart';

class PackagesView extends StatelessWidget {
   PackagesView({super.key});
   List<String> texts = [
    'التواصل مع ملاك طلبات التسويق',
    'مستخدم واحد فقط',
    'عدد الإعلانات : 50 اعلان',
    'ترقية مؤقتة للإعلان 1 في التطبيق (75 مئة )',
     'التواصل مع ملاك طلبات التسويق',
    'مستخدم واحد فقط',
    'عدد الإعلانات : 50 اعلان',
    'ترقية مؤقتة للإعلان 1 في التطبيق (75 مئة )'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'الباقات',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            EdgeInsets.only(left: 16.w, right: 16.w,  bottom: 20.h),
        child: Column(
          children: [
            Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('باقــة 50 اعـلان'),
                              SizedBox(
                                width: 7.w,
                              ),
                              Text(
                                '1,500 جنيه سنويأ',
                                style: TextStyle(
                                    color: ColorsManager.kprimaryColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                              // width: double.infinity,
                              height: texts.length > 4 ? 350.h:250.h,
                              padding: EdgeInsets.all(8.r),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                      color: ColorsManager.kprimaryColor)),
                              child: Column(
                              
                                children: [
                                  Expanded(
                                    child: ListView.separated(
                                      physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: ColorsManager
                                                            .kprimaryColor),
                                                    child: SvgPicture.asset(
                                                        Images.correct),
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Text(
                                                    texts[index],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                            color: Colors.black),
                                                  )
                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                        itemCount: texts.length),
                                  ),
                                   CustomButton(
                                            text: 'اشتراك في الباقة',
                                            onpressed: () {}),
                                      
                                ],
                              )),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 20.h,
                        ),
                    itemCount: 4)),
          ],
        ),
      ),
    );
  }
}
