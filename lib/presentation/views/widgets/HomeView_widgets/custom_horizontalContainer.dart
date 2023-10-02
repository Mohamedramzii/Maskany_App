import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../data/models/propertiesModel/propertiesModel.dart';

import '../../../../core/app_resources/colors.dart';
import '../../../../core/app_resources/images.dart';
import 'custom_rowIcons.dart';

class CustomHorizontalCOntainer extends StatelessWidget {
  const CustomHorizontalCOntainer({
    super.key,
    required this.model,
    required this.index,
  });
  final List<PropertiesModel> model;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: FittedBox(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(15.r)),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: 150.w,
                  // height: 200.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.r),
                    child: Image.asset(
                      Images.villa,
                      fit: BoxFit.fill,
                    ),
                  )),
              Text(
                model[index].title,
                style: TextStyle(fontSize: 13.sp),
              ),
              Text(
                model[index].city,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                '${model[index].price.toString()} جنيه / شهريأ',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: ColorsManager.kprimaryColor),
              ),
              Row(
                children: [
                  IconRow(
                    count: model[index].bathrooms,
                    fontsize: 8,
                    icon: Icon(
                      Icons.bathtub_rounded,
                      size: 20.r,
                    ),
                  ),
                  IconRow(
                    count: 25,
                    fontsize: 8,
                    icon: Icon(
                      Icons.bathtub_rounded,
                      size: 20.r,
                    ),
                  ),
                  IconRow(
                    count: 25,
                    fontsize: 8,
                    icon: Icon(
                      Icons.bathtub_rounded,
                      size: 20.r,
                    ),
                  ),
                  IconRow(
                    count: 25,
                    fontsize: 8,
                    icon: Icon(
                      Icons.bathtub_rounded,
                      size: 20.r,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
