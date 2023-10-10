import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

import '../../../../core/app_resources/colors.dart';
import '../../../../data/models/propertiesModel/properties_model2/properties_model2.dart';
import 'custom_rowIcons.dart';

class CustomVerticalContainer extends StatelessWidget {
  const CustomVerticalContainer({
    Key? key,
    required this.model,
    required this.index,
  }) : super(key: key);
  final PropertiesModel2 model;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: FittedBox(
        child: Container(
          width: 350.w,
          height: ResponsiveBreakpoints.of(context).isMobile ? 90.h : 110.h,
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r), color: Colors.white),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(height: 15.h,),
                    SizedBox(
                      width: 210.w,
                      child: Text(
                        model.title!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 13.sp),
                      ),
                    ),
                    Text(
                      model.city!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      '${model.price} / شهريأ',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: ColorsManager.kprimaryColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconRow(
                          count: 25,
                          fontsize: 8,
                          icon: Icon(
                            Icons.bathtub_rounded,
                            size: 12.r,
                          ),
                        ),
                        IconRow(
                          count: 25,
                          fontsize: 8,
                          icon: Icon(
                            Icons.bathtub_rounded,
                            size: 12.r,
                          ),
                        ),
                        IconRow(
                          count: 25,
                          fontsize: 8,
                          icon: Icon(
                            Icons.bathtub_rounded,
                            size: 12.r,
                          ),
                        ),
                        IconRow(
                          count: 25,
                          fontsize: 8,
                          icon: Icon(
                            Icons.bathtub_rounded,
                            size: 12.r,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [

              //   ],
              // ),
              FittedBox(
                child: SizedBox(
                    width: 200.w,
                    height: 150.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.r),
                      child: Hero(
                        tag: '${model.title}+vertical',
                        child: Image.network(
                                'http://66.45.248.247:8000${model.images![0].image}',
                                fit: BoxFit.cover,
                              ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
