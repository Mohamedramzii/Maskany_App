import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maskany_app/core/app_resources/colors.dart';
import 'package:maskany_app/core/common_widgets/custom_buttom.dart';
import 'package:maskany_app/presentation/view_model/CUBIT/cubit/app_cubit.dart';
import 'package:maskany_app/presentation/views/advanced_search_result_view.dart';
import 'package:maskany_app/presentation/views/widgets/advanced_search_view_widgets/custom_textfiled_forAdvSearch.dart';
import 'package:maskany_app/presentation/views/widgets/advanced_search_view_widgets/price_widget.dart';
import 'package:page_animation_transition/animations/right_to_left_faded_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import '../../core/app_resources/images.dart';
import '../../core/common_widgets/custom_snackbar.dart';
import 'widgets/advanced_search_view_widgets/CustomPropertyCategoryTypeWidget.dart';
import 'widgets/advanced_search_view_widgets/customLocationDropDownWidget.dart';

class AdnvancedSearchView extends StatelessWidget {
  AdnvancedSearchView({super.key});

  // String propType = '';
  // String location = '';
  TextEditingController propTypecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  TextEditingController priceStart = TextEditingController();
  TextEditingController priceEnd = TextEditingController();
  TextEditingController spaceStart = TextEditingController();
  TextEditingController spaceEnd = TextEditingController();
  TextEditingController numberOfRooms = TextEditingController();
  List<int> numbers = [1, 2, 3, 4];
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = BlocProvider.of<AppCubit>(context);
    return Scaffold(
      body: BlocBuilder<AppCubit, AppState>(builder: (context, state) {
        var cubit = BlocProvider.of<AppCubit>(context);
        return Padding(
          padding: EdgeInsets.only(top: 50.h, left: 20.w, right: 20.w),
          child: SingleChildScrollView(
            child: Column(
              // direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomPropertyCategoryTypeWidget(
                    cubit: cubit, propTypecontroller: propTypecontroller),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(Images.locationicon),
                    SizedBox(
                      width: 20.w,
                    ),
                    Expanded(
                        child: customLocationDropDownWidget(
                            locationcontroller: locationcontroller))
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Divider(),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Checkbox.adaptive(
                      activeColor: ColorsManager.kprimaryColor,
                      value: cubit.isCheckBoxTapped,
                      onChanged: (value) {
                        cubit.checkBoxTapped();
                        print(cubit.isCheckBoxTapped);
                      },
                    ),
                    Text('المزيد من التفاصيل')
                  ],
                ),
                Visibility(
                  visible: cubit.isCheckBoxTapped,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('تحديد السعر'),
                      SizedBox(
                        height: 10.h,
                      ),

                      PriceWidget(
                          startController: priceStart, endController: priceEnd),
                      SizedBox(
                        height: 10.h,
                      ),
                      const Divider(),
                      const Text('تحديد المساحة'),
                      SizedBox(
                        height: 10.h,
                      ),
                      PriceWidget(
                          startController: spaceStart, endController: spaceEnd),
                      SizedBox(
                        height: 10.h,
                      ),
                      const Divider(),
                      SizedBox(
                        height: 10.h,
                      ),

                      //! ROOOOOOOOMs
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('عدد الغرف'),
                          // SizedBox(
                          //   width: 15.w,
                          // ),
                          SizedBox(
                            width: 25.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              print('Pressed');
                              cubit.isAllRooms = true;
                              print(cubit.isAllRooms);
                              cubit
                                  .changeNumbersIndexSelectionInAdvSearchForRooms(
                                      0);
                            },
                            child: Container(
                              width: 50.w,
                              height: 25.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: ColorsManager.kprimaryColor,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Text('الكل',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.white)),
                            ),
                          ),
                          SizedBox(
                            width: 25.w,
                          ),
                          Container(
                              height: 30.h,
                              width: 160.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorsManager.kprimaryColor),
                                  borderRadius: BorderRadius.circular(7.r)),
                              child:
                          // Flexible(
                          //   child: CustomTextFieldForAdvSearch(
                          //     controller: numberOfRooms,
                          //     hinttext: 'اكتب العدد',
                          //     textalign: TextAlign.center,
                          //   ),
                          // ),

                          Wrap(
                            direction: Axis.vertical,
                            alignment: WrapAlignment.center,
                            children: numbers.map((e) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      cubit.isAllRooms = false;
                                      cubit
                                          .changeNumbersIndexSelectionInAdvSearchForRooms(
                                              e);
                                    },
                                    child: Text(
                                      e == 4 ? '$e' : e.toString(),
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight:
                                                  cubit.advSearchIndexForrooms ==
                                                          e
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                              color:
                                                  cubit.advSearchIndexForrooms ==
                                                          e
                                                      ? Colors.black
                                                      : ColorsManager
                                                          .kprimaryColor),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  if (e != 4)
                                    Container(
                                      height: 17.h,
                                      width: 1.w,
                                      color: ColorsManager.kprimaryColor,
                                    ),
                                ],
                              );
                            }).toList(),
                          ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      const Divider(),
                      SizedBox(
                        height: 15.h,
                      ),
                      //! Floooooor
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('رقم الدور'),
                          SizedBox(
                            width: 35.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              print('Pressed');
                              cubit.isAnotherFloor = true;

                              cubit
                                  .changeNumbersIndexSelectionInAdvSearchForFloor(
                                      0);
                            },
                            child: Container(
                              width: 50.w,
                              height: 25.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: ColorsManager.kprimaryColor,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Text('أخري',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.white)),
                            ),
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          Container(
                            height: 30.h,
                            width: 160.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorsManager.kprimaryColor),
                                borderRadius: BorderRadius.circular(7.r)),
                            child: Wrap(
                              direction: Axis.vertical,
                              children: numbers.map((e) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        cubit.isAnotherFloor = false;
                                        cubit
                                            .changeNumbersIndexSelectionInAdvSearchForFloor(
                                                e);
                                      },
                                      child: Text(
                                        e.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontWeight:
                                                    cubit.advSearchIndexForFloor ==
                                                            e
                                                        ? FontWeight.bold
                                                        : FontWeight.normal,
                                                color:
                                                    cubit.advSearchIndexForFloor ==
                                                            e
                                                        ? Colors.black
                                                        : ColorsManager
                                                            .kprimaryColor),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    if (e != 4)
                                      Container(
                                        height: 17.h,
                                        width: 1.w,
                                        color: ColorsManager.kprimaryColor,
                                      ),
                                  ],
                                );
                              }).toList(),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      const Divider(),
                      // const Spacer(),
                      SizedBox(
                        height: 60.h,
                      ),
                    ],
                  ),
                  replacement: Container(),
                ),
                CustomButton(
                    text: 'بحث الأن',
                    onpressed: () {
                      print('***** ${propTypecontroller.text} ****');
                      if (!cubit.isCheckBoxTapped) {
                        if (propTypecontroller.text.isNotEmpty
                            // &&
                            // location.isNotEmpty
                            // &&
                            // priceStart.text.isNotEmpty &&
                            // priceEnd.text.isNotEmpty &&
                            // spaceStart.text.isNotEmpty &&
                            // spaceEnd.text.isNotEmpty
                            ) {
                          // cubit.getAdvancedSearchedFor();
                          cubit.getAdvancedSearchedFor1(
                            propType: propTypecontroller.text,
                            // propLocation: 'حدائق الاهرام',
                          );

                          if (cubit.advancedSearch.isNotEmpty) {
                            Navigator.of(context).push(PageAnimationTransition(
                                page: AdvancedSearchResultView(
                                    resultSearch: cubit.advancedSearch),
                                pageAnimationType:
                                    RightToLeftFadedTransition()));
                          }
                          if (cubit.advancedSearch.isEmpty) {
                            SnackBars.failureSnackBar(
                                context, 'بحث متقدم', 'لا توجد نتائج لبحثك');
                          }
                        }
                      } else {
                        if (propTypecontroller.text.isNotEmpty &&
                            // location.isNotEmpty
                            // &&
                            priceStart.text.isNotEmpty &&
                            priceEnd.text.isNotEmpty &&
                            spaceStart.text.isNotEmpty &&
                            spaceEnd.text.isNotEmpty) {
                          print('ROOOMS : ${cubit.advSearchIndexForrooms}');
                          // cubit.getAdvancedSearchedFor();
                          cubit.getAdvancedSearchedFor2(
                              propType: propTypecontroller.text,
                              // propLocation: 'حدائق الاهرام',
                              priceStart: int.parse(priceStart.text.trim()),
                              priceEnd: int.parse(priceEnd.text.trim()),
                              spaceStart: int.parse(spaceStart.text.trim()),
                              spaceEnd: int.parse(spaceEnd.text.trim()),
                              numberofFloor: cubit.advSearchIndexForFloor,
                              numberofRooms: cubit.advSearchIndexForrooms);
                              // numberofRooms: int.parse(numberOfRooms.text.trim()));

                          if (cubit.advancedSearch.isNotEmpty) {
                            Navigator.of(context).push(PageAnimationTransition(
                                page: AdvancedSearchResultView(
                                    resultSearch: cubit.advancedSearch),
                                pageAnimationType:
                                    RightToLeftFadedTransition()));
                          }
                          if (cubit.advancedSearch.isEmpty) {
                            SnackBars.failureSnackBar(
                                context, 'بحث متقدم', 'لا توجد نتائج لبحثك');
                          }
                        }
                      }
                    }),
                // if (cubit.advancedSearch.isEmpty) Text('ZEROOO')
              ],
            ),
          ),
        );
      }),
    );
  }
}
