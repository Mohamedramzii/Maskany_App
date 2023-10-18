import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:maskany_app/presentation/view_model/CUBIT/cubit/app_cubit.dart';
import 'package:maskany_app/presentation/views/advanced_search_view.dart';
import 'package:page_animation_transition/animations/right_to_left_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import '../../core/app_resources/images.dart';
import 'details_view.dart';
import 'widgets/HomeView_widgets/custom_vertical_container.dart';
import 'widgets/searchView_widgets/custom_textfield.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0.r),
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            var cubit = BlocProvider.of<AppCubit>(context);

            return Padding(
              padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextFieldForSearchView(cubit: cubit),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(PageAnimationTransition(
                              page:  AdnvancedSearchView(),
                              pageAnimationType: RightToLeftTransition()));
                        },
                        child: Text(
                          'بحث متقدم',
                          style: Theme.of(context).textTheme.bodySmall,
                        )),
                  ),
                  cubit.emptyValue.isEmpty
                      ? SizedBox(
                          height: 100.h,
                        )
                      : const SizedBox(),
                  cubit.emptyValue == '' || cubit.emptyValue.isEmpty
                      ? Column(
                          children: [
                            Center(
                              child: Lottie.asset(Images.emptySearch),
                            ),
                            const Text('لا يوجد نتائج لبحثك !')
                          ],
                        )
                      : Expanded(
                          child: ListView.builder(
                          itemCount: cubit.search.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                PageAnimationTransition(
                                    page:
                                        DetailsView(model: cubit.search[index]),
                                    pageAnimationType:
                                        RightToLeftTransition())),
                            child: CustomVerticalContainer(
                              model: cubit.search[index],
                              index: index,
                            ),
                          ),
                        ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
