import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maskany_app/data/models/categories_model/categories_model.dart';
import 'package:maskany_app/presentation/view_model/CUBIT/cubit/app_cubit.dart';

import '../../../../core/app_resources/colors.dart';

class CustomCategoryContainer extends StatelessWidget {
  const CustomCategoryContainer({
    Key? key,
    required this.list,
    required this.index,
  }) : super(key: key);
  final List<CategoriesModel> list;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          var cubit = BlocProvider.of<AppCubit>(context);
          return GestureDetector(
            onTap: () {
              cubit.blabla(index);
            },
            child: Container(
              width: 70.w,
              padding: EdgeInsets.all(3.r),
              alignment: Alignment.center,
              height: 40.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: index == cubit.categoryIndex
                    ? Colors.green
                    : ColorsManager.kprimaryColor,
              ),
              child: Text(
                list[index].name!,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
