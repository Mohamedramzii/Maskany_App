import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maskany_app/core/app_resources/colors.dart';
import 'package:maskany_app/core/common_widgets/custom_buttom.dart';
import 'package:maskany_app/core/constants.dart';
import 'package:maskany_app/presentation/view_model/CUBIT/cubit/app_cubit.dart';
import 'package:maskany_app/presentation/views/widgets/advanced_search_view_widgets/customLocationDropDownWidget.dart';
import 'package:maskany_app/presentation/views/widgets/advanced_search_view_widgets/price_widget.dart';
import '../../core/app_resources/images.dart';
import 'widgets/advanced_search_view_widgets/CustomPropertyCategoryTypeWidget.dart';

class AdnvancedSearchView extends StatelessWidget {
  AdnvancedSearchView({super.key});

  String propType = '';
  String location = '';
  TextEditingController priceStart = TextEditingController();
  TextEditingController priceEnd = TextEditingController();
  TextEditingController spaceStart = TextEditingController();
  TextEditingController spaceEnd = TextEditingController();
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
                  returnedtext: propType,
                  list: cubit.allcategories,
                ),
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
                        child: CustomLocationDropDownWidget(
                            list: gov, returnedtext: location))
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Divider(),
                SizedBox(
                  height: 10.h,
                ),
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
                    SizedBox(
                      width: 30.w,
                    ),
                    Container(
                      height: 30.h,
                      width: 160.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: ColorsManager.kprimaryColor),
                          borderRadius: BorderRadius.circular(7.r)),
                      child: Wrap(
                        direction: Axis.vertical,
                        children: numbers.map((e) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 15.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  cubit
                                      .changeNumbersIndexSelectionInAdvSearchForRooms(
                                          e);
                                },
                                child: Text(
                                  e.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontWeight:
                                              cubit.advSearchIndexForrooms == e
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                          color: cubit.advSearchIndexForrooms ==
                                                  e
                                              ? Colors.black
                                              : ColorsManager.kprimaryColor),
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
                      width: 30.w,
                    ),
                    Container(
                      height: 30.h,
                      width: 160.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: ColorsManager.kprimaryColor),
                          borderRadius: BorderRadius.circular(7.r)),
                      child: Wrap(
                        direction: Axis.vertical,
                        children: numbers.map((e) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 15.w,
                              ),
                              GestureDetector(
                                onTap: () {
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
                                              cubit.advSearchIndexForFloor == e
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                          color: cubit.advSearchIndexForFloor ==
                                                  e
                                              ? Colors.black
                                              : ColorsManager.kprimaryColor),
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
                CustomButton(
                    text: 'بحث الأن',
                    onpressed: () {
                      // if (
                      //     // propType.isNotEmpty
                      //     // &&
                      //     // location.isNotEmpty
                      //     // &&
                      //     priceStart.text.isNotEmpty &&
                      //         priceEnd.text.isNotEmpty &&
                      //         spaceStart.text.isNotEmpty &&
                      //         spaceEnd.text.isNotEmpty) {
                        cubit.getAdvancedSearchedFor();
                        // cubit.getAdvancedSearchedFor(
                        //   propType: propType.trim(),
                        //   propLocation: 'حدائق الاهرام',
                        //   priceStart: double.parse(priceStart.text.trim()),
                        //   priceEnd: double.parse(priceEnd.text.trim()),
                        //   spaceStart: double.parse(spaceStart.text.trim()),
                        //   spaceEnd: double.parse(spaceEnd.text.trim()),
                        //   numberofFloor: cubit.advSearchIndexForFloor,
                        //   numberofRooms: cubit.advSearchIndexForrooms
                        // );
                      // }
                    }),
                    if(cubit.advancedSearch.isEmpty)
                    Text('ZEROOO')
              ],
            ),
          ),
        );
      }),
    );
  }
}
