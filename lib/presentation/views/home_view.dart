// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_animation_transition/animations/right_to_left_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

// Project imports:
import 'package:maskany_app/core/app_resources/colors.dart';
import 'package:maskany_app/presentation/views/detailsForhorizontal.dart';
import 'package:maskany_app/presentation/views/widgets/HomeView_widgets/home_loading_view.dart';
import '../../core/constants.dart';
import '../../generated/l10n.dart';
import '../view_model/CUBIT/cubit/app_cubit.dart';
import '../view_model/CUBIT/cubit/auth_cubit.dart';
import 'details_view.dart';
import 'widgets/HomeView_widgets/custom_ads_details_view.dart';
import 'widgets/HomeView_widgets/custom_horizontalContainer.dart';
import 'widgets/HomeView_widgets/custom_textfield.dart';
import 'widgets/HomeView_widgets/custom_vertical_container.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller1 = ScrollController();
  @override
  void initState() {
    BlocProvider.of<AuthCubit>(context).getUserData();
    // BlocProvider.of<AppCubit>(context)
    //         .getAllpropertiesWithPagination(context: context);

    controller1.addListener(() {
      if (controller1.position.maxScrollExtent == controller1.offset) {
        if (BlocProvider.of<AppCubit>(context).hasMore == false) {
          return;
        }
        BlocProvider.of<AppCubit>(context)
            .getAllpropertiesWithPagination(context: context);
      }
    });
    if (isAllRequestsDone == false ||
        BlocProvider.of<AuthCubit>(context).isUserChangedHisLocation) {
      debugPrint('Token Holder: $tokenHolder');

      BlocProvider.of<AppCubit>(context).getAllAds(context);
      BlocProvider.of<AppCubit>(context)
          .getAllpropertiesWithPagination(context: context);
      BlocProvider.of<AppCubit>(context).getNearestPlaces(context);
      BlocProvider.of<AppCubit>(context).getAllFavorites();
      debugPrint('In Home, All requests Status is: $isAllRequestsDone');
      isAllRequestsDone = true;
      BlocProvider.of<AuthCubit>(context).isUserChangedHisLocation = false;
    }

    super.initState();
  }

  @override
  void dispose() {
    controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BlocProvider.of<AppCubit>(context);
          if (cubit.property.isNotEmpty &&
              BlocProvider.of<AuthCubit>(context).userdata?.location != null) {
            return Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: ListView(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined,
                                color: HexColor('#B6B6B6')),
                            SizedBox(
                              width: 6.w,
                            ),
                            BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                var cubit = BlocProvider.of<AuthCubit>(context);
                                return Text(
                                  state is GetUserDataLoadingState
                                      ? "موقعك..."
                                      : cubit.userdata!.location ?? "غير محدد",
                                  style: ResponsiveBreakpoints.of(context)
                                          .isMobile
                                      ? Theme.of(context).textTheme.bodySmall
                                      : Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(fontSize: 8.sp),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          S.of(context).Welcome,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        const CustomTextField(),
                        // SizedBox(
                        //   height: 20.h,
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).NearestPlaces,
                          style: Theme.of(context).textTheme.bodyMedium),
                      // Text(S.of(context).SeeMore,
                      //     style: Theme.of(context)
                      //         .textTheme
                      //         .bodySmall),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  state is GetNearestPlacesLoadingState
                      ? SizedBox(
                          height: 250.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('جاري البحث و مطابقة موقعك'),
                              LoadingAnimationWidget.staggeredDotsWave(
                                  color: ColorsManager.kprimaryColor,
                                  size: 45.r)
                            ],
                          ),
                        )
                      : cubit.allnearestProperties.isEmpty
                          ? SizedBox(
                              height: 250.h,
                              child: Center(
                                child: Text(
                                    'لا توجد عقارات بالقرب من منطقتك حاليا !'),
                              ),
                            )
                          : SizedBox(
                              height: 250.h,
                              child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  PageAnimationTransition(
                                                      page:
                                                          DetailsViewForHorizontal(
                                                        model: cubit
                                                            .allnearestProperties,
                                                        index: index,
                                                      ),
                                                      pageAnimationType:
                                                          RightToLeftTransition()));
                                            },
                                            child: CustomHorizontalCOntainer(
                                                // favs: cubit.allfavorites[index],
                                                model:
                                                    cubit.allnearestProperties,
                                                index: index))
                                        .animate()
                                        .slide(
                                            begin: Offset(2, 0),
                                            duration:
                                                Duration(milliseconds: 500));
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                  itemCount: cubit.allnearestProperties.length),
                            ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('اعلانات',
                          style: Theme.of(context).textTheme.bodyMedium),
                      // Text(S.of(context).SeeMore,
                      //     style: Theme.of(context)
                      //         .textTheme
                      //         .bodySmall),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  state is GetAdsLoadingState
                      ? SizedBox(
                          height: 250.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('جاري البحث و مطابقة موقعك'),
                              LoadingAnimationWidget.staggeredDotsWave(
                                  color: ColorsManager.kprimaryColor,
                                  size: 45.r)
                            ],
                          ),
                        )
                      : cubit.ads.isEmpty
                          ? SizedBox(
                              height: 250.h,
                              child: Center(
                                child: Text(
                                    'لا توجد اعلانات بالقرب من منطقتك حاليا !'),
                              ),
                            )
                          : SizedBox(
                              height: 250.h,
                              child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  PageAnimationTransition(
                                                      page:
                                                          CustomAdsDetailsView(
                                                        model: cubit.ads,
                                                        index: index,
                                                      ),
                                                      pageAnimationType:
                                                          RightToLeftTransition()));
                                            },
                                            child: CustomHorizontalCOntainer(
                                                // favs: cubit.allfavorites[index],
                                                model: cubit.ads,
                                                index: index))
                                        .animate()
                                        .slide(
                                            begin: Offset(2, 0),
                                            duration:
                                                Duration(milliseconds: 500));
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                  itemCount: cubit.ads.length),
                            ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).suggestedPlaces,
                          style: Theme.of(context).textTheme.bodyMedium),
                      // Text(
                      //   S.of(context).SeeMore,
                      //   style:
                      //       Theme.of(context).textTheme.bodySmall,
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 200.h,
                    child: ListView.separated(
                        controller: controller1,
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (index < cubit.property.length) {
                            return GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                        PageAnimationTransition(
                                            page: DetailsView(
                                                model: cubit.property[index]),
                                            pageAnimationType:
                                                RightToLeftTransition())),
                                    child: CustomVerticalContainer(
                                      model: cubit.property[index],
                                      index: index,
                                    ))
                                .animate()
                                .slide(
                                    begin: Offset(2, 0),
                                    duration: Duration(milliseconds: 500));
                          } else {
                            return Padding(
                              padding:  EdgeInsets.only(bottom: 8.h),
                              child: Center(
                                child: cubit.hasMore
                                    ? const Text('اسحب للمزيد')
                                    : const Text('لا توجد عقارات اخري'),
                              ),
                            );
                          }
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10.h,
                            ),
                        itemCount: cubit.property.length + 1),
                  ),
                ],
              ),
            );
          } else if (cubit.property.isEmpty ||
              cubit.allProperties.isEmpty ||
              cubit.allfavorites.isEmpty ||
              BlocProvider.of<AuthCubit>(context).userdata?.location == null) {
            return HomeLoadingView();
          } else if (state is GetAllPropertiesFailureState ||
              state is GetUserDataFailureState) {
            return Center(
              child: Text(
                  'No Internet Connection, Please make sure you are connected and try again'),
            );
          } else {
            return Center(
              child: Text('Something Error Happened'),
            );
          }

          // : CustomScrollView(
          //     physics: const BouncingScrollPhysics(),
          //     slivers: [
          //         SliverToBoxAdapter(
          //           child:
          // Padding(
          //             padding: EdgeInsets.only(left: 16.w, right: 16.w),
          //             child: Column(
          //               children: [
          //                 SizedBox(
          //                   height: 10.h,
          //                 ),
          //                 SizedBox(
          //                   child: Column(
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //                       Row(
          //                         children: [
          //                           Icon(Icons.location_on_outlined,
          //                               color: HexColor('#B6B6B6')),
          //                           SizedBox(
          //                             width: 6.w,
          //                           ),
          //                           BlocBuilder<AuthCubit, AuthState>(
          //                             builder: (context, state) {
          //                               var cubit =
          //                                   BlocProvider.of<AuthCubit>(
          //                                       context);
          //                               return Text(
          //                                 state is GetUserDataLoadingState
          //                                     ? "موقعك..."
          //                                     : cubit.userdata!.location ??
          //                                         "غير محدد",
          //                                 style: ResponsiveBreakpoints.of(
          //                                             context)
          //                                         .isMobile
          //                                     ? Theme.of(context)
          //                                         .textTheme
          //                                         .bodySmall
          //                                     : Theme.of(context)
          //                                         .textTheme
          //                                         .bodySmall!
          //                                         .copyWith(fontSize: 8.sp),
          //                               );
          //                             },
          //                           ),
          //                         ],
          //                       ),
          //                       SizedBox(
          //                         height: 10.h,
          //                       ),
          //                       Text(
          //                         S.of(context).Welcome,
          //                         style: Theme.of(context)
          //                             .textTheme
          //                             .bodyMedium,
          //                       ),
          //                       SizedBox(
          //                         height: 8.h,
          //                       ),
          //                       const CustomTextField(),
          //                       // SizedBox(
          //                       //   height: 20.h,
          //                       // ),
          //                     ],
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: 20.h,
          //                 ),
          //                 Row(
          //                   mainAxisAlignment:
          //                       MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Text(S.of(context).NearestPlaces,
          //                         style: Theme.of(context)
          //                             .textTheme
          //                             .bodyMedium),
          //                     // Text(S.of(context).SeeMore,
          //                     //     style: Theme.of(context)
          //                     //         .textTheme
          //                     //         .bodySmall),
          //                   ],
          //                 ),
          //                 SizedBox(
          //                   height: 15.h,
          //                 ),
          //                 state is GetAllPropertiesLoadingState
          //                     ? SizedBox(
          //                         height: 250.h,
          //                         child: Column(
          //                           mainAxisAlignment:
          //                               MainAxisAlignment.center,
          //                           crossAxisAlignment:
          //                               CrossAxisAlignment.center,
          //                           children: [
          //                             Text('جاري البحث و مطابقة موقعك'),
          //                             LoadingAnimationWidget
          //                                 .staggeredDotsWave(
          //                                     color: ColorsManager
          //                                         .kprimaryColor,
          //                                     size: 45.r)
          //                           ],
          //                         ),
          //                       )
          //                     : cubit.nearestPlaces.isEmpty
          //                         ? SizedBox(
          //                             height: 250.h,
          //                             child: Center(
          //                               child: Text(
          //                                   'لا توجد عقارات بالقرب من منطقتك حاليا !'),
          //                             ),
          //                           )
          //                         : SizedBox(
          //                             height: 250.h,
          //                             child: ListView.separated(
          //                                 physics:
          //                                     const BouncingScrollPhysics(),
          //                                 scrollDirection: Axis.horizontal,
          //                                 itemBuilder: (context, index) {
          //                                   return GestureDetector(
          //                                           onTap: () {
          //                                             Navigator.of(context).push(
          //                                                 PageAnimationTransition(
          //                                                     page:
          //                                                         DetailsViewForHorizontal(
          //                                                       model: cubit
          //                                                           .nearestPlaces,
          //                                                       index:
          //                                                           index,
          //                                                     ),
          //                                                     pageAnimationType:
          //                                                         RightToLeftTransition()));
          //                                           },
          //                                           child:
          //                                               CustomHorizontalCOntainer(
          //                                                   // favs: cubit.allfavorites[index],
          //                                                   model: cubit
          //                                                       .nearestPlaces,
          //                                                   index: index))
          //                                       .animate()
          //                                       .slide(
          //                                           begin: Offset(2, 0),
          //                                           duration: Duration(
          //                                               milliseconds: 500));
          //                                 },
          //                                 separatorBuilder:
          //                                     (context, index) => SizedBox(
          //                                           width: 20.w,
          //                                         ),
          //                                 itemCount:
          //                                     cubit.nearestPlaces.length),
          //                           ),
          //                 SizedBox(
          //                   height: 40.h,
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //         SliverFillRemaining(
          //           child: Padding(
          //             padding: EdgeInsets.only(left: 16.w, right: 16.w),
          //             child: Column(
          //               children: [
          //                 Row(
          //                   mainAxisAlignment:
          //                       MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Text(S.of(context).suggestedPlaces,
          //                         style: Theme.of(context)
          //                             .textTheme
          //                             .bodyMedium),
          //                     // Text(
          //                     //   S.of(context).SeeMore,
          //                     //   style:
          //                     //       Theme.of(context).textTheme.bodySmall,
          //                     // ),
          //                   ],
          //                 ),
          //                 SizedBox(
          //                   height: 10.h,
          //                 ),
          //                 Expanded(
          //                   child: ListView.separated(
          //                       controller: controller1,
          //                       physics: AlwaysScrollableScrollPhysics(),
          //                       shrinkWrap: true,
          //                       itemBuilder: (context, index) {
          //                         if (index < cubit.property.length) {
          //                           return GestureDetector(
          //                                   onTap: () => Navigator.of(
          //                                           context)
          //                                       .push(PageAnimationTransition(
          //                                           page: DetailsView(
          //                                               model:
          //                                                   cubit.property[
          //                                                       index]),
          //                                           pageAnimationType:
          //                                               RightToLeftTransition())),
          //                                   child: CustomVerticalContainer(
          //                                     model: cubit.property[index],
          //                                     index: index,
          //                                   ))
          //                               .animate()
          //                               .slide(
          //                                   begin: Offset(2, 0),
          //                                   duration: Duration(
          //                                       milliseconds: 500));
          //                         } else {
          //                           return Center(
          //                             child: cubit.hasMore
          //                                 ? const Text(
          //                                     'اضغط لتحميل عقارات اخري')
          //                                 : const Text(
          //                                     'لا توجد عقارات اخري'),
          //                           );
          //                         }
          //                       },
          //                       separatorBuilder: (context, index) =>
          //                           SizedBox(
          //                             height: 10.h,
          //                           ),
          //                       itemCount: cubit.property.length + 1),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         )
          //       ]);
        },
      ),
    );
  }
}
