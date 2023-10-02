import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_animation_transition/animations/left_to_right_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

import '../../../core/app_resources/colors.dart';
import '../../../core/app_resources/fonts.dart';
import '../../../core/common_widgets/custom_buttom.dart';
import '../../../core/constants.dart';
import '../../../generated/l10n.dart';
import '../AppLayout.dart';

class LocationView extends StatelessWidget {
  LocationView({super.key});

  String govern = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.h,
          ),
          child: Align(
            alignment: Alignment.topRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).location, style: Theme.of(context).textTheme.bodyLarge),
                Text(S.of(context).belowLocation, style: Theme.of(context).textTheme.bodySmall),

                SizedBox(
                  height: 30.h,
                ),
                // Container(
                //   width: double.infinity,
                //   height: 45.h,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(15.r),
                //     border: Border.all(
                //       color: ColorsManager.borderColor,
                //       width: 2.5
                //     )
                //   ),
                //   child:
                // )
                DropdownButtonFormField<String>(
                  hint: Text('المحافظة', style: Theme.of(context).textTheme.bodyMedium),
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide: BorderSide(
                            color: ColorsManager.borderColor, width: 2)),
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
                  items: gov
                      .map((gov) => DropdownMenuItem<String>(
                            value: gov["governorate_name_ar"],
                            child: Text(gov["governorate_name_ar"]),
                          ))
                      .toList(),
                  onChanged: (value) {
                    govern = value!;
                  },
                ),

                SizedBox(
                  height: 40.h,
                ),
                CustomButton(
                    text: 'ابدأ الأن',
                    onpressed: () {
                      PageAnimationTransition(
                          page: const AppLayout(),
                          pageAnimationType: LeftToRightTransition());
                    })
              ],
            ),
          ),
        ));
  }
}

/*
 Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: EdgeInsets.only(
            right: 16.w,
            left: 16.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.of(context).location, style: Theme.of(context).textTheme.bodyLarge),
              Text(S.of(context).belowLocation, style: Theme.of(context).textTheme.bodySmall),
              SizedBox(
                height: 30.h,
              ),
              CSCPicker(
                ///Enable disable state dropdown [OPTIONAL PARAMETER]
                showStates: true,

                /// Enable disable city drop down [OPTIONAL PARAMETER]
                showCities: true,

                ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                flagState: CountryFlag.DISABLE,

                ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300, width: 1.w)),

                ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                disabledDropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey.shade300,
                    border: Border.all(color: Colors.grey.shade300, width: 1.w)),

                ///placeholders for dropdown search field
                countrySearchPlaceholder: "دولة",
                stateSearchPlaceholder: "ولاية",
                citySearchPlaceholder: "مدينة",

                ///labels for dropdown
                countryDropdownLabel: "دولة",
                stateDropdownLabel: "ولاية",
                cityDropdownLabel: "مدينة",

                ///Default Country
                //defaultCountry: CscCountry.India,

                ///Disable country dropdown (Note: use it with default country)
                //disableCountry: true,

                ///Country Filter [OPTIONAL PARAMETER]
                countryFilter: [
                  CscCountry.Egypt,
                  CscCountry.Saudi_Arabia,
                  // CscCountry.Canada
                ],

                ///selected item style [OPTIONAL PARAMETER]
                selectedItemStyle:  TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                ),

                ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                dropdownHeadingStyle:  TextStyle(
                    color: Colors.black,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold),

                ///DropdownDialog Item style [OPTIONAL PARAMETER]
                dropdownItemStyle:  TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                ),

                ///Dialog box radius [OPTIONAL PARAMETER]
                dropdownDialogRadius: 10.0,

                ///Search bar radius [OPTIONAL PARAMETER]
                searchBarRadius: 10.0,

                ///triggers once country selected in dropdown
                onCountryChanged: (value) {
                  ///store value in country variable
                  countryValue = value ?? "";
                },

                ///triggers once state selected in dropdown
                onStateChanged: (value) {
                  ///store value in state variable
                  stateValue = value?? "";
                },

                ///triggers once city selected in dropdown
                onCityChanged: (value) {
                  ///store value in city variable
                  cityValue = value ?? "";
                },
              ),

              SizedBox(height: 45.h,),
              CustomButton(text: "ابدأ الأن", onpressed: (){})
            ],
          ),
        ),
      ),
*/
