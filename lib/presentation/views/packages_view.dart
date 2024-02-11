// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// Project imports:
import 'package:maskany_app/core/app_resources/colors.dart';
import 'package:maskany_app/core/common_widgets/custom_buttom.dart';
import 'package:maskany_app/presentation/view_model/CUBIT/cubit/app_cubit.dart';
import 'package:maskany_app/presentation/views/purchase_package_check_view.dart';
import '../../core/app_resources/images.dart';

class PackagesView extends StatefulWidget {
  PackagesView({super.key});

  @override
  State<PackagesView> createState() => _PackagesViewState();
}

class _PackagesViewState extends State<PackagesView> {
  // List<String> texts = [
  //   'التواصل مع ملاك طلبات التسويق',
  //   'مستخدم واحد فقط',
  //   'عدد الإعلانات : 50 اعلان',
  //   'ترقية مؤقتة للإعلان 1 في التطبيق (75 مئة )',
  //   'التواصل مع ملاك طلبات التسويق',
  //   'مستخدم واحد فقط',
  //   'عدد الإعلانات : 50 اعلان',
  //   'ترقية مؤقتة للإعلان 1 في التطبيق (75 مئة )'
  //       'مستخدم واحد فقط',
  //   'عدد الإعلانات : 50 اعلان',
  //   'ترقية مؤقتة للإعلان 1 في التطبيق (75 مئة )'
  //       'مستخدم واحد فقط',
  //   'عدد الإعلانات : 50 اعلان',
  //   'ترقية مؤقتة للإعلان 1 في التطبيق (75 مئة )'
  // ];

  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).getPackages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (context) => AppCubit()..getPackages(),
      child: BlocListener<AppCubit, AppState>(
        listener: (context, state) {},
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            // BlocProvider.of<AppCubit>(context).refresh();
            var cubit = BlocProvider.of<AppCubit>(context);
            if (cubit.packages.length != 0) {
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
                      padding: EdgeInsets.only(
                          left: 16.w, right: 16.w, bottom: 20.h, top: 20.h),
                      child: Column(
                        children: [
                          Expanded(
                              //! Outer Listview
                              child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(cubit.packages[index].name!),
                                            SizedBox(
                                              width: 7.w,
                                            ),
                                            Text(
                                              '${cubit.packages[index].price} جنيه شهريا',
                                              style: TextStyle(
                                                  color: ColorsManager
                                                      .kprimaryColor),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Container(
                                            // width: double.infinity,
                                            height: 350.h,
                                            padding: EdgeInsets.all(8.r),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                                border: Border.all(
                                                    color: ColorsManager
                                                        .kprimaryColor)),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  //! inner listview
                                                  child: ListView.separated(
                                                      physics:
                                                          AlwaysScrollableScrollPhysics(),
                                                      itemBuilder:
                                                          (context, indexx) {
                                                        return Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: ColorsManager
                                                                          .kprimaryColor),
                                                                  child: SvgPicture
                                                                      .asset(Images
                                                                          .correct),
                                                                ),
                                                                SizedBox(
                                                                  width: 10.w,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    cubit.packages[index].packageFeatures !=
                                                                            null
                                                                        ? cubit
                                                                            .packages[index]
                                                                            .packageFeatures![indexx]
                                                                        : 'لا يوجد',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .copyWith(
                                                                            color:
                                                                                Colors.black),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                      separatorBuilder:
                                                          (context, index) =>
                                                              SizedBox(
                                                                height: 10.h,
                                                              ),
                                                      itemCount: cubit
                                                              .packages[index]
                                                              .packageFeatures
                                                              ?.length ??
                                                          0),
                                                ),
                                                // if (CacheHelper.getData(
                                                //         key: 'trxBool') ==
                                                //     null)
                                                cubit.packages[index]
                                                        .isUserSubscribed!
                                                    ? Center(
                                                        child: Container(
                                                            height: 50.h,
                                                            width:
                                                                double.infinity,
                                                            alignment: Alignment
                                                                .center,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(15
                                                                            .r),
                                                                color: Colors
                                                                    .green),
                                                            child: Text(
                                                              'مشترك',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .white),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            )),
                                                      )
                                                    : CustomButton(
                                                        text: 'اشترك في الباقة',
                                                        onpressed: () {
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) => PurchasePackageCheckView(
                                                                    packageID: cubit
                                                                        .packages[
                                                                            index]
                                                                        .id!),
                                                              ));
                                                        },
                                                      )
                                              ],
                                            )),
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                  itemCount: cubit.packages.length)),
                        ],
                      )));
            } else if (state is GetPackagesLoadingState) {
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('جاري تحميل الباقات الان...'),
                      SizedBox(
                        height: 10.h,
                      ),
                      LoadingAnimationWidget.staggeredDotsWave(
                          color: ColorsManager.kprimaryColor, size: 45.r)
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
