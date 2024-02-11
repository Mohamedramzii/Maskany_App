// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../../../../core/app_resources/colors.dart';
import '../../../view_model/CUBIT/cubit/app_cubit.dart';

class CustomPropertyCategoryTypeWidget extends StatelessWidget {
  const CustomPropertyCategoryTypeWidget({
    super.key,
    required this.cubit,
    required this.propTypecontroller,
  });

  final AppCubit cubit;
  final TextEditingController propTypecontroller;

  @override
  Widget build(BuildContext context) {
    // cubit.allcategories.removeAt(0);
    return DropdownButtonFormField<String>(
      hint: Text('نوع العقار',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: ColorsManager.kprimaryColor)),
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide:
                BorderSide(color: ColorsManager.kprimaryColor, width: 2)),
        enabledBorder: OutlineInputBorder(
            // gapPadding: 0,
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(
              color: ColorsManager.borderColor,
              width: 2,
              strokeAlign: 1,
            )),
        focusedBorder: OutlineInputBorder(
          // gapPadding: 0,
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(
            color: ColorsManager.borderColor,
            width: 2,
            strokeAlign: 1,
          ),
        ),
      ),
      items: cubit.allcategoriesForAdvSearch
          .map((category) => DropdownMenuItem<String>(
                value: category.name,
                child: Text(
                  category.name!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: ColorsManager.kprimaryColor),
                ),
                // onTap: () {
                //   setState(() {
                //     widget.returnedtext = value!;
                //   });
                //   print(widget.returnedtext);
                // },
              ))
          .toList(),
      onChanged: (value) {
        propTypecontroller.text = value!;
        print(propTypecontroller.text);
      },
    );
  }
}
